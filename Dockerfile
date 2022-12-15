FROM ubuntu:20.04

WORKDIR /home
COPY . /home/

RUN ./prepare-build-system