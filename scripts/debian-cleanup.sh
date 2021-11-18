#!/bin/bash -eux

##
## Debian Cleanup
## Cleaning VM before OVA Export
##

# Clean up
echo '> Removing unnecessary packages...'
apt-get -y remove linux-headers-$(uname -r) build-essential
apt-get -y purge $(dpkg --list | grep '^rc' | awk '{print $2}')

echo '> Removing package manager unused files'
apt-get -y autoremove
apt-get -y clean
apt-get -y autoclean

echo '> Removing unused locales...'
DEBIAN_FRONTEND=noninteractive apt-get -y install localepurge
sed -i -e 's|^USE_DPKG|#USE_DPKG|' /etc/locale.nopurge
localepurge
apt-get -y purge localepurge

# cleanup installer resolv.conf
echo ""  > /etc/resolv.conf

# Cleanup log files
echo '> Removing Log files...'
cat /dev/null > /var/log/wtmp 2>/dev/null
logrotate -f /etc/logrotate.conf 2>/dev/null
find /var/log -type f -delete
rm -f /var/lib/dhcp/*

# Zero out the free space to save space in the final image, blocking 'til
# written otherwise, the disk image won't be zeroed, and/or Packer will try to
# kill the box while the disk is still full and that's bad.  The dd will run
# 'til failure, so (due to the 'set -e' above), ignore that failure.  Also,
# really make certain that both the zeros and the file removal really sync; the
# extra sleep 1 and sync shouldn't be necessary, but...)

echo '> Zeroing device to make space...'
dd if=/dev/zero of=/EMPTY bs=1M || true; sync; sleep 1; sync
rm -f /EMPTY; sync; sleep 1; sync

echo '> Done'
