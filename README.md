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

# use gunicorn and uvicorn and read config from ./gunicorn.conf.py
gunicorn blog.asgi
```

## create more apps

[Reference Here](https://docs.djangoproject.com/en/3.2/intro/tutorial01/#creating-the-polls-app)

```shell
python manage.py startapp demo1
python manage.py startapp demo2
```

## FYI
If you wanna a much smaller image, maybe you can use the following:
```dockerfile
FROM python:3.10-alpine
WORKDIR /app

# set environment variables
# Prevents Python from writing pyc files to disc (equivalent to python -B option)
# https://docs.python.org/3/using/cmdline.html#cmdoption-B
ENV PYTHONDONTWRITEBYTECODE 1
# Prevents Python from buffering stdout and stderr (equivalent to python -u option)
# https://docs.python.org/3/using/cmdline.html#cmdoption-u
ENV PYTHONUNBUFFERED 1
# NO Cache
ENV PIP_NO_CACHE_DIR 1
ENV PIP_INDEX_URL https://pypi.tuna.tsinghua.edu.cn/simple


# install dependencies
COPY requirements.txt .

# the apk dependencies is for installing Pillow
RUN apk add --update --no-cache --virtual .tmp gcc libc-dev linux-headers zlib-dev jpeg-dev && \
    apk add libjpeg && \
    pip install -U pip && \
    pip install -r requirements.txt && \
    echo '====== requirements.txt Installed ======' && \
    pip install uvicorn gunicorn && \
    apk del .tmp


# copy project
COPY . .

EXPOSE 8000

# here the gunicorn will read the default settings from ./gunicorn.conf.py
RUN chmod +x run.sh
CMD ["./run.sh"]
```
