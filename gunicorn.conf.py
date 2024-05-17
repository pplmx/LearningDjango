import multiprocessing

bind = "0.0.0.0:8000"
worker_class = "uvicorn.workers.UvicornWorker"

# https://docs.gunicorn.org/en/stable/settings.html#workers
workers = multiprocessing.cpu_count() * 2 + 1

# https://docs.gunicorn.org/en/stable/settings.html#threads
threads = multiprocessing.cpu_count() * 2
