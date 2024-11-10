# Builder stage
FROM ghcr.io/astral-sh/uv:python3.13-bookworm AS builder

LABEL maintainer="Mystic"

# Set build-time variables
ARG UV_INDEX_URL="https://mirrors.cernet.edu.cn/pypi/web/simple"
ARG PIP_INDEX_URL="https://mirrors.cernet.edu.cn/pypi/web/simple"

WORKDIR /app

COPY pyproject.toml .

# Install dependencies
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync

# Runtime stage
FROM python:3.13-slim-bookworm

# Add non-root user
RUN groupadd -r app && useradd -r -g app app

WORKDIR /app

# Copy virtual environment from builder
COPY --from=builder --chown=app:app /app/.venv /app/.venv

# Set environment variables
ENV TZ="Asia/Shanghai" \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/app/.venv/bin:$PATH" \
    # Django superuser settings - Consider moving these to runtime environment
    DJANGO_SUPERUSER_PASSWORD="admin" \
    DJANGO_SUPERUSER_EMAIL="admin@admin.io" \
    DJANGO_SUPERUSER_USERNAME="admin"

# Copy application code
COPY --chown=app:app . .

# Set permissions
RUN chmod +x x.sh

# Switch to non-root user
USER app

# Expose port
EXPOSE 8000

# Healthcheck
HEALTHCHECK --start-period=30s CMD python -c "import requests; requests.get('http://localhost:8000', timeout=2)"

# Start application
CMD ["./x.sh"]
