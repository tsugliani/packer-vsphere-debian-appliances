#!/bin/bash -eux

##
## Debian Network
## Install Network utilities
##


echo '> Installing Network utilities...'

apt-get install -y \
  ntp \
  frr \
  curl \
  wget \
  rsync \
  telnet \
  netcat \
  dnsmasq \
  mtr-tiny \
  speedometer \
  bridge-utils

echo '> Done'
