#!/bin/sh

set -x

useradd -rm -s /bin/bash -g root -G sudo "${SSH_USER}"
echo "${SSH_USER}:${SSH_PASSWORD}" | chpasswd

mkdir -p /home/${SSH_USER}/.ssh
cp /mnt/git-key/* /home/${SSH_USER}/.ssh
chown ${SSH_USER}:root /home/${SSH_USER}/.ssh/*

if [ -n "${GIT_EMAIL}" ]; then
  git config --global user.email "${GIT_EMAIL}"
fi
if [ -n "${GIT_NAME}" ]; then
  git config --global user.name "${GIT_NAME}"
fi

/usr/sbin/sshd -D "${@}"
