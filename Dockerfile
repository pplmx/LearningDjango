FROM python:3.10-slim AS builder

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
# create .venv at the current directory
ENV PIPENV_VENV_IN_PROJECT 1

COPY Pipfile Pipfile.lock ./

# for those packages who need to be built in the container
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential libmariadb-dev && \
    rm -rf /var/lib/apt/lists/* && \
    pip install -U pip pipenv setuptools wheel && \
    pipenv install --deploy && \
    pipenv install mysqlclient


FROM python:3.10-slim

ENV DJANGO_SUPERUSER_PASSWORD admin
ENV DJANGO_SUPERUSER_EMAIL admin@admin.io
ENV DJANGO_SUPERUSER_USERNAME admin

WORKDIR /app

# build python environment
COPY --from=builder /.venv /app/.venv
ENV PATH="/app/.venv/bin:$PATH"

# copy project
COPY . .

EXPOSE 8000

# here the gunicorn will read the default settings from ./gunicorn.conf.py
RUN chmod +x run.sh
CMD ["./run.sh"]
