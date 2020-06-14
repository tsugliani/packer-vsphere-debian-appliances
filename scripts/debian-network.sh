#!/bin/bash -eux

##
## Debian Network
## Install Network utilities
##


echo '> Installing Network utilities...'

apt-get install -y \
  ntp \
  curl \
  wget \
  rsync \
  telnet \
  netcat \
  quagga \
  dnsmasq \
  mtr-tiny \
  speedometer \
  bridge-utils

echo '> Done'
