#!/bin/bash -eux

##
## Debian 
## Setup HashiCorp apt repository
##

echo '> Setup HashiCorp Repository...'

# Install pre-requisites
apt-get -y install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg2 \
  software-properties-common

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# Refresh sources
apt-get update

echo '> Done'

