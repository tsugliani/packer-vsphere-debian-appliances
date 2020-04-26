#!/bin/bash -eux

##
## Debian Storage
## Install Storage utilities
##

echo '> Installing Storage utilities...'

apt-get install -y \
  pydf \
  yafc \
  pure-ftpd \
  nfs-kernel-server

echo '> Done'