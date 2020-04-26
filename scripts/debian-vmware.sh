#!/bin/bash -eux

##
## VMware related stuff
## Install VMware related tools
##

echo '> Installing VMware Software...'

apt-get install -y \
  open-vm-tools

echo '> Done'