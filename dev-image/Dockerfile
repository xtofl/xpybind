FROM ubuntu:22.04

RUN apt-get update

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y \
    build-essential cmake git python3 python3-pip

# required for open_spiel
RUN apt-get install -y virtualenv clang curl

# install pybind includes into /usr/local/include/
RUN pip3 install "pybind11[global]"

#RUN apt-get clean

