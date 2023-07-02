FROM ubuntu:22.04

ENV SSH_USERS=tang
ENV SSH_PASSWORD=a1a2a3a4

RUN apt update
RUN apt install -y openssh-server dumb-init sudo

RUN service ssh start

COPY ./entrypoint.sh /root/entrypoint.sh
RUN chmod 755 /root/entrypoint.sh

ENTRYPOINT ["dumb-init", "/root/entrypoint.sh"]

