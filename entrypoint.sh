#!/bin/sh

python manage migrate --no input
python manage collectstatic --no-input

gunicorn backendExecPython.wsgi:application --workers 3 --bind 0.0.0.0:80
