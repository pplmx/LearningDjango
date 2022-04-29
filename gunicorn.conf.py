import multiprocessing
import os

bind = '0.0.0.0:8000'
worker_class = 'uvicorn.workers.UvicornWorker'

workers = multiprocessing.cpu_count() * 2 + 1
threads = multiprocessing.cpu_count() * 2

# loglevel = 'info'
# access_log_format = '%(t)s %(p)s %(h)s "%(r)s" %(s)s %(L)s %(b)s %(f)s" "%(a)s"'
#
# accesslog = 'logs/gunicorn_access.log'
# errorlog = 'logs/gunicorn_error.log'
#
# pidfile = 'logs/gunicorn.pid'
