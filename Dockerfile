FROM ubuntu:22.04

ENV SSH_USERS=tang
ENV SSH_PASSWORD=a1a2a3a4

RUN apt update

# docker-cli
RUN apt install -y ca-certificates curl gnupg lsb-release
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt update && apt -y install docker-ce-cli 

# necessary tools
RUN apt install -y openssh-server dumb-init sudo vim build-essential git

RUN service ssh start

COPY ./entrypoint.sh /root/entrypoint.sh
RUN chmod 755 /root/entrypoint.sh

ENTRYPOINT ["dumb-init", "/root/entrypoint.sh"]

