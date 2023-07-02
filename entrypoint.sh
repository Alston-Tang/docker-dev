#!/bin/sh

set -x

useradd -rm -s /bin/bash -g root -G sudo "${SSH_USER}"
echo "${SSH_USER}:${SSH_PASSWORD}" | chpasswd

/usr/sbin/sshd -D
