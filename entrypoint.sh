#!/bin/sh

set -x

useradd -rm -s /bin/bash -g root -G sudo "${SSH_USER}"
echo "${SSH_USER}:${SSH_PASSWORD}" | chpasswd

mkdir -p /home/${SSH_USER}/.ssh
cp /mnt/git-key/* /home/${SSH_USER}/.ssh

/usr/sbin/sshd -D
