FROM python:3.12-bookworm AS builder

LABEL maintainer="Mystic"

ENV PIP_NO_CACHE_DIR 1
ENV PIP_INDEX_URL https://mirrors.cernet.edu.cn/pypi/web/simple

WORKDIR /app

RUN curl -sSL https://install.python-poetry.org | python -

COPY pyproject.toml .
RUN python -m venv --copies venv
RUN . venv/bin/activate && \
    pip install -U pip && \
    PATH="${HOME}/.local/bin:${PATH}" poetry install --no-directory


FROM python:3.12-slim-bookworm

WORKDIR /app
COPY --from=builder /app/venv /app/venv

ENV TZ Asia/Shanghai
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PATH /app/venv/bin:$PATH

ENV DJANGO_SUPERUSER_PASSWORD admin
ENV DJANGO_SUPERUSER_EMAIL admin@admin.io
ENV DJANGO_SUPERUSER_USERNAME admin

COPY . .

EXPOSE 8000

HEALTHCHECK --interval=5s --timeout=3s --retries=3 CMD bash -c 'cat < /dev/null > /dev/tcp/127.0.0.1/8000'

# here the gunicorn will read the default settings from ./gunicorn.conf.py
RUN chmod +x x.sh
CMD ["./x.sh"]
