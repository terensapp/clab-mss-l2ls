#!/bin/bash
# Copy this script to the tool server and execute. It'll self install & run at reboot
# Make sure this script is properly installed
if grep -q act-clab.sh /etc/rc.local; then
  echo "Startup script is properly installed"
else
  sudo cp $0 /usr/sbin/act-clab.sh
  sudo chmod +x /usr/sbin/act-clab.sh
  sudo echo "bash -c /usr/sbin/act-clab.sh" >> /etc/rc.local
fi

# Load MSR module to prevent "show boot-config" error
if lsmod | grep -q msr; then
  echo "MSR is enabled. Proceeding to setup bridges"
else
  /sbin/modprobe msr
  echo "msr" >> /etc/modules
fi

# Setup bridges to connect ACT ZTX and FW to the Spines
sudo ip link add name br-ztx-spine1 type bridge
sudo ip link set br-ztx-spine1 up
sudo ip link set et1 up
sudo ip link set et1 master br-ztx-spine1
sudo ip link add name br-ztx-spine2 type bridge
sudo ip link set br-ztx-spine2 up
sudo ip link set et2 up
sudo ip link set et2 master br-ztx-spine2
sudo ip link add name br-fw-spine1 type bridge
sudo ip link set br-fw-spine1 up
sudo ip link set et3 up
sudo ip link set et3 master br-fw-spine1
sudo ip link add name br-fw-spine2 type bridge
sudo ip link set br-fw-spine2 up
sudo ip link set et4 up
sudo ip link set et4 master br-fw-spine2
sudo echo "0x4000" > /sys/class/net/br-ztx-spine1/bridge/group_fwd_mask
sudo echo "0x4000" > /sys/class/net/br-ztx-spine2/bridge/group_fwd_mask
sudo echo "0x4000" > /sys/class/net/br-fw-spine1/bridge/group_fwd_mask
sudo echo "0x4000" > /sys/class/net/br-fw-spine2/bridge/group_fwd_mask
