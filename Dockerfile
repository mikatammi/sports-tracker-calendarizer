FROM phusion/baseimage:0.9.17

CMD ["/sbin/my_init"]

RUN echo "HEAD /" | nc 192.168.1.10 8000 | grep squid-deb-proxy \
  && (echo "Acquire::http::Proxy \"http://192.168.1.10:8000\";" > /etc/apt/apt.conf.d/30proxy) \
  && (echo "Acquire::http::Proxy::ppa.launchpad.net DIRECT;" >> /etc/apt/apt.conf.d/30proxy) \
  || echo "No squid-deb-proxy detected on docker host"

#RUN sed -i -e 's/archive\.ubuntu\.com/trumpetti.atm.tut.fi/g' /etc/apt/sources.list
RUN apt-get update && apt-get -y dist-upgrade && \
    apt-get -y install python python-dev python-setuptools nginx python-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN pip install virtualenv

RUN groupadd calendarizer && useradd calendarizer -g calendarizer -d /home/calendarizer -m
ENV HOME /home/calendarizer

RUN pip install uwsgi

ADD . /app
RUN pip install $(python /app/setup.py --require)
RUN pip install /app

RUN mkdir /etc/service/calendarizer
RUN echo "#!/bin/bash\nexec /sbin/setuser calendarizer sportstrackercalendarizer-server" > /etc/service/calendarizer/run
RUN chmod +x /etc/service/calendarizer/run
EXPOSE 5000

#USER calendarizer
#WORKDIR $HOME
