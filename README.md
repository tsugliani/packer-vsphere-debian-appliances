# packer-vsphere-debian-appliances

My VMware vSphere Debian Appliances

The appliances are built exclusively to be configured without leveraging VMware Guest Customization but relying entirely on OVF Properties.

Deployment through HTML5 UI:

![OVA Deploy through vCenter Server HTML5 UI](https://cloud.tsugliani.fr/img/debian-vsphere-ovf-properties.png)

Published builds from repository:

Minimal:

- https://cloud.tsugliani.fr/ova/debian-minimal-10.8.0.ova
- https://cloud.tsugliani.fr/ova/debian-minimal-10.9.0.ova
- https://cloud.tsugliani.fr/ova/debian-minimal-10.10.0.ova

Toolbox:

- https://cloud.tsugliani.fr/ova/debian-toolbox-10.8.0.ova
- https://cloud.tsugliani.fr/ova/debian-toolbox-10.9.0.ova
- https://cloud.tsugliani.fr/ova/debian-toolbox-10.10.0.ova

Build process:

[![asciicast](https://asciinema.org/a/wj7n9czneZs80jg35x9DcoOt0.svg)](https://asciinema.org/a/wj7n9czneZs80jg35x9DcoOt0)

You can also automate this template leveraging ovftool or govc for example:

govc is more practical for this IMO as you can generate a JSON output from the OVA/OVF Properties & then process/leverage this as IaC.

```bash
tsugliani at zMacBook in ~
❯ govc import.spec debian-minimal-10.10.0.ova | jq
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
