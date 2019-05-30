FROM python:3.7-alpine
MAINTAINER Jonatas Oliveira

ENV PYTHONUNBUFFERED 1

ARG SECRET_KEY_ARG
ARG ALLOWED_HOSTS_ARG
ARG DEBUG_ARG

ENV SECRET_KEY=${SECRET_KEY_ARG}
ENV ALLOWED_HOSTS=${ALLOWED_HOSTS_ARG}
ENV DEBUG=${DEBUG_ARG}

COPY ./requirements.txt /requirements.txt

RUN pip install -r requirements.txt

RUN mkdir /src
WORKDIR /src
COPY ./src /src

RUN adduser -D usuario

USER usuario
