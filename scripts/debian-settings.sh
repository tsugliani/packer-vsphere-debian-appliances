#!/bin/bash -eux

##
## Debian Settings
## Misc configuration
##

echo '> Debian Settings...'

echo '> Installing resolvconf...'
apt-get install -y resolvconf

echo '> SSH directory'
mkdir -vp $HOME/.ssh

echo '> Debian acts as a Router now'
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf

echo '> Disable IPv6'
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf

echo '> Setup Appliance Banner for /etc/issue & /etc/issue.net'
echo "=============================" | tee /etc/issue /etc/issue.net > /dev/null
echo "Debian vSphere Appliance $(cat /etc/debian_version)" | tee -a /etc/issue /etc/issue.net > /dev/null
echo "=============================" | tee -a /etc/issue /etc/issue.net > /dev/null

echo '> Enable rc.local facility for debian-init.py'
cat << EOF > /etc/rc.local
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

if [ ! -f /etc/debian.config ]; then
    /sbin/debian-init.py
    echo "\$(date)" > /etc/debian.config
    systemctl restart getty@*
fi

exit 0
EOF
chmod +x /etc/rc.local
systemctl daemon-reload

echo '> Done'