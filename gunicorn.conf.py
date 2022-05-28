import multiprocessing

bind = '0.0.0.0:8000'
worker_class = 'uvicorn.workers.UvicornWorker'

workers = multiprocessing.cpu_count() * 2 + 1
threads = multiprocessing.cpu_count() * 2

# https://docs.gunicorn.org/en/stable/settings.html#worker-tmp-dir
worker_tmp_dir = '/dev/shm'
