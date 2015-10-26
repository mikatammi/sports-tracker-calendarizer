import os

def test_import_app():
    app_filename = 'bin/sportstrackercalendarizer-server'
    with open(app_filename) as f:
        code = compile(f.read(), app_filename, 'exec')
        exec(code)
