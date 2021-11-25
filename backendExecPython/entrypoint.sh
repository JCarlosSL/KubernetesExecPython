#!/bin/sh

python manage.py migrate --no-input
#python manage.py collectstatic --no-input
python manage.py runserver
#gunicorn backendExecPython.wsgi:application --workers 3 --bind 0.0.0.0:8001
