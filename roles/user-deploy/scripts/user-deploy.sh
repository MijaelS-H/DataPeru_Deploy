#!/bin/bash -eux

USER_NAME="$1"
USER_PASS="$2"

if id "$USER_NAME" &>/dev/null; then
  echo 'user already exist'
else
  # create new username
  adduser --disabled-login --gecos "" $USER_NAME
  echo $USER_NAME:$USER_PASS | chpasswd
  usermod -aG sudo $USER_NAME

  # add authorized_keys to ssh
  mkdir -p /home/$USER_NAME/.ssh
  touch /home/$USER_NAME/.ssh/authorized_keys

  # apply diferent chmod to .ssh folder
  chown -R $USER_NAME: /home/$USER_NAME/.ssh
  chmod 700 /home/$USER_NAME/.ssh
  chmod 600 /home/$USER_NAME/.ssh/*
fi