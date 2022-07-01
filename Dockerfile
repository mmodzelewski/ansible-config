FROM ubuntu:jammy AS base
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential sudo && \
    add-apt-repository --yes ppa:ansible/ansible && \
    apt-get install -y ansible && \
    apt-get clean autoclean && \
    apt-get autoremove --yes
RUN apt-get install -y vim

FROM base AS mm-user
RUN adduser --gecos mm --disabled-password mm
RUN echo "mm  ALL = (ALL) NOPASSWD: ALL" > /etc/sudoers.d/mm
USER mm
WORKDIR /home/mm

FROM mm-user
COPY . .
