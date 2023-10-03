FROM python:3.12-slim

# for those packages who need to be built in the container
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

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

ENV DJANGO_SUPERUSER_PASSWORD admin
ENV DJANGO_SUPERUSER_EMAIL admin@admin.io
ENV DJANGO_SUPERUSER_USERNAME admin


# install dependencies
COPY requirements.txt .

# the apk dependencies is for installing Pillow
RUN pip install -U pip && \
    pip install -r requirements.txt && \
    pip install uvicorn gunicorn psycopg2


# copy project
COPY . .

EXPOSE 8000

# here the gunicorn will read the default settings from ./gunicorn.conf.py
RUN chmod +x run.sh
CMD ["./run.sh"]
