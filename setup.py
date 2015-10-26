try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

config = {
        'name': 'sports_tracker_calendarizer',
        'description': 'Sports Tracker Calendarizer',
        'author': 'Mika Tammi',
        'url': 'http://tasker.ponr.fi/',
        'download_url': 'http://tasker.ponr.fi/',
        'author_email': 'mikatammi@gmail.com',
        'version': '0.1',
        'requires': ['nose',
                     'flask',
                     'icalendar',
                     'requests'],
        'provides': ['sports_tracker_calendarizer'],
        'scripts': ['bin/sportstrackercalendarizer-server']
}

setup(**config)
