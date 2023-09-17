#!/bin/sh

set -x

useradd -rm -s /bin/bash -g root -G sudo "${SSH_USER}"
echo "${SSH_USER}:${SSH_PASSWORD}" | chpasswd

mkdir -p /home/${SSH_USER}/.ssh
cp /mnt/git-key/* /home/${SSH_USER}/.ssh
chown -R ${SSH_USER}:root /home/${SSH_USER}/.ssh

if [ -n "${GIT_EMAIL}" ]; then
  sudo -u ${SSH_USER} git config --global user.email "${GIT_EMAIL}"
fi
if [ -n "${GIT_NAME}" ]; then
  sudo -u ${SSH_USER} git config --global user.name "${GIT_NAME}"
fi

runuser -l ${SSH_USER} -c "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"

/usr/sbin/sshd -D "${@}"
