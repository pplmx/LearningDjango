FROM ghcr.io/astral-sh/uv:python3.13-bookworm AS builder

LABEL maintainer="Mystic"

ENV UV_INDEX_URL="https://mirrors.cernet.edu.cn/pypi/web/simple" \
    PIP_INDEX_URL="https://mirrors.cernet.edu.cn/pypi/web/simple"

WORKDIR /app

COPY pyproject.toml .
RUN uv sync


FROM python:3.13-slim-bookworm

WORKDIR /app
COPY --from=builder /app/.venv /app/.venv

ENV TZ="Asia/Shanghai"
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/app/.venv/bin:$PATH"

ENV DJANGO_SUPERUSER_PASSWORD="admin"
ENV DJANGO_SUPERUSER_EMAIL="admin@admin.io"
ENV DJANGO_SUPERUSER_USERNAME="admin"

COPY . .

EXPOSE 8000

HEALTHCHECK --interval=5s --timeout=3s --retries=3 CMD bash -c 'cat < /dev/null > /dev/tcp/127.0.0.1/8000'

# x.sh will init database and create superuser, then run server with gunicorn
RUN chmod +x x.sh
CMD ["./x.sh"]
