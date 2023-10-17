# Django

## Configuration

Default:

```text
username: admin
password: admin
email: admin@admin.io
```

You can change them by transferring the ENV variables to the Docker container.

ENV:

```text
DJANGO_SUPERUSER_USERNAME
DJANGO_SUPERUSER_PASSWORD
DJANGO_SUPERUSER_EMAIL
```

## Running

### docker & compose

```shell
make dev
```

### k8s

```shell
make prod
```

### python directly

```shell
python manage.py makemigrations
python manage.py migrate

# default running on http://localhost:8000
python manage.py runserver

# change port
python manage.py runserver 8080

# change address
# 0 is a shortcut for 0.0.0.0
python manage.py runserver 0:8080

# use gunicorn and uvicorn and read config from ./gunicorn.conf.py
gunicorn blog.asgi

# create more apps
# https://docs.djangoproject.com/en/3.2/intro/tutorial01/#creating-the-polls-app
python manage.py startapp demo1
python manage.py startapp demo2
```

## Access

<http://localhost:8000>
