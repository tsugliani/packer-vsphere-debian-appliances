# packer-vsphere-debian-appliances

My VMware vSphere Debian Appliances

Published builds from repository:

Minimal:

- https://cloud.tsugliani.fr/ova/debian-minimal-10.3.0.ova
- https://cloud.tsugliani.fr/ova/debian-minimal-10.4.0.ova
- https://cloud.tsugliani.fr/ova/debian-minimal-10.5.0.ova
- https://cloud.tsugliani.fr/ova/debian-minimal-10.6.0.ova
- https://cloud.tsugliani.fr/ova/debian-minimal-10.7.0.ova

Toolbox:

- https://cloud.tsugliani.fr/ova/debian-toolbox-10.3.0.ova
- https://cloud.tsugliani.fr/ova/debian-toolbox-10.4.0.ova
- https://cloud.tsugliani.fr/ova/debian-toolbox-10.5.0.ova
- https://cloud.tsugliani.fr/ova/debian-toolbox-10.6.0.ova
- https://cloud.tsugliani.fr/ova/debian-minimal-10.7.0.ova

Build process:

[![asciicast](https://asciinema.org/a/wj7n9czneZs80jg35x9DcoOt0.svg)](https://asciinema.org/a/wj7n9czneZs80jg35x9DcoOt0)

Available OVF Properties for configuring the templates:

```bash
tsugliani at zMacBook in ~
❯ govc import.spec debian-minimal-10.7.0.ova | jq
{
  "DiskProvisioning": "flat",
  "IPAllocationPolicy": "dhcpPolicy",
  "IPProtocol": "IPv4",
  "PropertyMapping": [
    {
      "Key": "guestinfo.hostname",
      "Value": ""
    },
    {
      "Key": "guestinfo.ipaddress",
      "Value": ""
    },
    {
      "Key": "guestinfo.netprefix",
      "Value": ""
    },
    {
      "Key": "guestinfo.gateway",
      "Value": ""
    },
    {
      "Key": "guestinfo.dns",
      "Value": ""
    },
    {
      "Key": "guestinfo.domain",
      "Value": ""
    },
    {
      "Key": "guestinfo.password",
      "Value": ""
    },
    {
      "Key": "guestinfo.sshkey",
      "Value": ""
    }
  ],
  "NetworkMapping": [
    {
      "Name": "VM Network",
      "Network": ""
    }
  ],
  "MarkAsTemplate": false,
  "PowerOn": false,
  "InjectOvfEnv": false,
  "WaitForIP": false,
  "Name": null
}
```
