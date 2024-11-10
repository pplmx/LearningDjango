# Django Project

A web application built with Django framework.

## 🚀 Quick Start

### Prerequisites

- Python 3.13+
- Docker (optional)
- Kubernetes (optional)
- Make

### Default Configuration

Default superuser credentials:

```text
username: admin
password: admin
email: admin@admin.io
```

### Environment Variables

You can customize the superuser account by setting these environment variables:

| Variable                  | Description    | Default        |
|---------------------------|----------------|----------------|
| DJANGO_SUPERUSER_USERNAME | Admin username | admin          |
| DJANGO_SUPERUSER_PASSWORD | Admin password | admin          |
| DJANGO_SUPERUSER_EMAIL    | Admin email    | admin@admin.io |

## 🛠️ Deployment

### Development with Docker Compose

```shell
make dev
```

### Production with Kubernetes

```shell
make prod
```

### Run with Python Directly

1. Initialize Database

    ```shell
    # Using Django manage.py
    python manage.py makemigrations
    python manage.py migrate
    python manage.py createsuperuser --username admin --email admin@admin.io

    # Or using uvicorn
    uv run manage.py makemigrations
    uv run manage.py migrate
    uv run manage.py createsuperuser --username admin --email admin@admin.io
    ```

2. Run Development Server

    ```shell
    # Using Django manage.py (default: http://localhost:8000)
    python manage.py runserver

    # Change port
    python manage.py runserver 8080

    # Change host and port
    # 0 is shorthand for 0.0.0.0
    python manage.py runserver 0:8080

    # Using uv
    uv run manage.py runserver
    uv run manage.py runserver 8080
    uv run manage.py runserver 0:8080
    ```

3. Run Production Server

    ```shell
    # Using gunicorn with uvicorn workers (config from ./gunicorn.conf.py)
    gunicorn blog.asgi
    ```

## 📦 Creating New Apps

Following Django best practices, create new app modules using:

```shell
# Using Django manage.py
python manage.py startapp <app_name>

# Or using uv
uv run manage.py startapp <app_name>
```

Examples:

```shell
python manage.py startapp demo1
python manage.py startapp demo2
```

For more information,
visit [Django documentation](https://docs.djangoproject.com/en/5.1/intro/tutorial01/#creating-the-polls-app)

## 🌐 Access Application

In development environment:

- Main app: http://localhost:8000
- Admin panel: http://localhost:8000/admin

## 📝 Important Notes

1. Remember to change default admin credentials in production
2. Use virtual environment for dependency management
3. Use production-grade servers like gunicorn in production
4. Backup your database regularly

## 🤝 Contributing

Issues and Pull Requests are welcome!

## 📄 License

[MIT License](LICENSE)
