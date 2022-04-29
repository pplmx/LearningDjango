# Django

## Running

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

# use gunicorn and uvicorn
gunicorn djgo.wsgi:application -b 0.0.0.0:8000 -w 2 -k uvicorn.workers.UvicornWorker
```

## create more apps

[Reference Here](https://docs.djangoproject.com/en/3.2/intro/tutorial01/#creating-the-polls-app)

```shell
python manage.py startapp demo1
python manage.py startapp demo2
```
