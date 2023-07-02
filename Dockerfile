FROM ubuntu:22.04

RUN apt update
RUN apt install -y openssh-server dumb-init sudo

ARG SSH_USER dev
ARG SSH_PASSWORD

RUN useradd -r -m -s /bin/bash -g root -G sudo "${SSH_USER}"
RUN echo "${SSH_USER}:${SSH_PASSWORD}" | chpasswd

RUN service ssh start

CMD ["dumb-init", "/usr/sbin/sshd","-D"]

