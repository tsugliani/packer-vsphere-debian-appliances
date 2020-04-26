#!/bin/bash -eux

##
## Debian system
## Install system utilities
##

echo '> Installing System Utilities...'

apt-get install -y \
  jq \
  grc \
  git \
  tmux \
  htop \
  unzip

echo '> Done'