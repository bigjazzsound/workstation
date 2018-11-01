#!/bin/bash

virsh destroy fedora29
virsh undefine fedora29 --remove-all-storage

virt-install \
    --name fedora29 \
    --ram 8025 \
    --disk path=/home/images/fedora29.qcow2,size=25,bus=virtio \
    --vcpus 6 \
    --os-type linux \
    --location "$HOME/Downloads/Fedora-Workstation-netinst-x86_64-29-1.2.iso" \
    -x 'ks=https://raw.githubusercontent.com/bigjazzsound/workstation/master/ks.cfg'
    # -x 'ks=http://192.168.122.1:8000/ks.cfg' \
