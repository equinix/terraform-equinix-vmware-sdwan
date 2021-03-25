# Equinix Network Edge example: VMWare VeloCloud SD-WAN edge device

This example shows how to create redundant VMWare VeloCloud SD-WAN edge devices
on Platform Equinix using Equinix VMWare SD-WAN Terraform module and
Equinix Terraform provider.

In addition to pair of VMWare SD-WAN devices, following resources are being created
in this example:

* two ACL templates, one for each of the device

The devices are created in self managed, bring your own license modes.
Remaining parameters include:

* medium hardware platform (8CPU cores, 16GB of memory)
* VeloCloud-4 software package
* device activation keys
* SD-WAN controllers IP addresses
* 100 Mbps of additional internet bandwidth on each device
