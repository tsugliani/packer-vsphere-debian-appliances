#!/bin/bash -eux

##
## Debian Docker
## Install Docker
##

echo '> Installing Docker...'

# Install pre-requisites
apt-get -y install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg2 \
  software-properties-common

# Fetch Docker official GPG key
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

# Add Docker official repository
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

# Update sources & install docker
apt-get update
apt-get install -y docker-ce

echo '> Done'
