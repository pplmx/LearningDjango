#!/usr/bin/env sh

python manage.py makemigrations || exit 1
python manage.py migrate || exit 1
python manage.py createsuperuser --noinput || exit 1

# here the gunicorn will read the default settings from ./gunicorn.conf.py
gunicorn blog.asgi || exit 1
