FROM python:3.7-alpine
MAINTAINER Jonatas Oliveira

ENV PYTHONUNBUFFERED 1

ARG SECRET_KEY_ARG
ARG ALLOWED_HOSTS_ARG
ARG DEBUG_ARG
ARG DB_HOST
ARG DB_NAME
ARG DB_USER
ARG DB_PASS

ENV SECRET_KEY=${SECRET_KEY_ARG}
ENV ALLOWED_HOSTS=${ALLOWED_HOSTS_ARG}
ENV DEBUG=${DEBUG_ARG}
ENV DATABASE_URL=postgres://${DB_USER}:${DB_PASS}@${DB_HOST}:5432/${DB_NAME}

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /src
WORKDIR /src
COPY ./src /src

RUN adduser -D usuario

USER usuario
