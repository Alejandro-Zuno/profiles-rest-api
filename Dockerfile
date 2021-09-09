FROM python:3.9

# ensure local python is preferred over distribution python
ENV PATH /usr/local/bin:$PATH

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

# other runtime dependencies for Python are installed later

ENV GPG_KEY 0D96DF4D4110E5C43FBFB17F2D347EA6AA65421D
ENV PYTHON_VERSION 3.6.12

WORKDIR /usr/src/app

COPY ./requirements.txt ./

RUN apt-get update --yes && \
    apt-get install libsasl2-dev libldap2-dev --yes && \
    pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

ENTRYPOINT ["python"]
# CMD ["manage.py", "startapp", "profiles_api"]
CMD ["/usr/src/app/manage.py", "runserver", "0.0.0.0:8000"]
