FROM python:3.10-slim
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
RUN pip install -U pip && \
    pip install -r requirements.txt && \
    pip install uvicorn gunicorn


# copy project
COPY . .

EXPOSE 8000

# here the gunicorn will read the default settings from ./gunicorn.conf.py
RUN chmod +x run.sh
CMD ["./run.sh"]
