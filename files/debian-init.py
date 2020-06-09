#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
    Debian Init script
    Based on https://vuptime.io/2017/03/06/vmware-dive-into-ovf-properties/
    (password & initial python code for ovfenv properties)
"""

import subprocess
from xml.dom.minidom import parseString


def appliance_get_ovf_properties():
    """
        Return a dict of OVF properties in the ovfenv
    """
    ovfenv_cmd = "/usr/bin/vmtoolsd --cmd 'info-get guestinfo.ovfEnv'"

    properties = {}
    xml_parts = subprocess.Popen(ovfenv_cmd, shell=True, stdout=subprocess.PIPE).stdout.read()
    raw_data = parseString(xml_parts)

    # [0] as we have all the ovfenv sections from the vApp & VMs
    appliancePropertySection = raw_data.getElementsByTagName("PropertySection")[0]

    for property in appliancePropertySection.getElementsByTagName('Property'):
        key, value = [
            property.attributes['oe:key'].value,
            property.attributes['oe:value'].value
        ]
        properties[key] = value
    return properties


def appliance_create_network_config(properties):
    """
        Create debian /etc/network/interfaces file & restart networking.
        if properties['guestinfo.ipaddress'] exists, setup static network
            -> This assumes all the other ovf variables are correct
        else
            -> This assumes this VM will leverage DHCP
    """

    if properties['guestinfo.ipaddress']:

        network_cmd = """cat << EOF > /etc/network/interfaces
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
allow-hotplug eth0
iface eth0 inet static
    address {ipaddress}/{netprefix}
    gateway {gateway}
    dns-nameserver {dns}
EOF
ifdown eth0
ifup eth0
    """.format(
            ipaddress=properties['guestinfo.ipaddress'],
            netprefix=properties['guestinfo.netprefix'],
            gateway=properties['guestinfo.gateway'],
            dns=properties['guestinfo.dns']
        )

        subprocess.Popen(network_cmd, shell=True, stdout=subprocess.PIPE).stdout.read()


def appliance_create_hostfile_config(properties):
    """
    Create debian /etc/hosts file for dnsmasq expand-hosts directive.
    """

    if properties['guestinfo.hostname'] and \
       properties['guestinfo.ipaddress'] and \
       properties['guestinfo.domain']:

        hostfile_cmd = """cat << EOF > /etc/hosts
127.0.0.1       localhost
{ipaddress}     {hostname}.{domain}    {hostname}

EOF
cat << EOF > /etc/hostname
{hostname}
EOF
        """.format(
            hostname=properties['guestinfo.hostname'],
            ipaddress=properties['guestinfo.ipaddress'],
            domain=properties['guestinfo.domain']
        )

        subprocess.Popen(hostfile_cmd, shell=True, stdout=subprocess.PIPE).stdout.read()


def appliance_update_credentials(properties):
    """
        Update Appliance root password & SSH KEY
    """

    if properties['guestinfo.password']:
        password_cmd = """echo root:{password} | chpasswd""".format(password=properties['guestinfo.password'])
        subprocess.Popen(password_cmd, shell=True, stdout=subprocess.PIPE).stdout.read()

    if properties['guestinfo.sshkey']:
        sshkey_cmd = """echo '{sshkey}' >> /root/.ssh/authorized_keys""".format(sshkey=properties['guestinfo.sshkey'])
        subprocess.Popen(sshkey_cmd, shell=True, stdout=subprocess.PIPE).stdout.read()


# Appliance configuration flow.
# Fetch properties from OVF Environment
# 1. Setup Appliance Networking
# 2. Setup /etc/hosts & /etc/hostname file
# 3. Update Root password & SSH Key
#

properties = appliance_get_ovf_properties()
appliance_create_network_config(properties)
appliance_create_hostfile_config(properties)
appliance_update_credentials(properties)
