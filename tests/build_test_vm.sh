#!/bin/bash

virsh destroy fedora28
virsh undefine fedora28 --remove-all-storage

virt-install \
    --name fedora28 \
    --ram 8025 \
    --disk path=/home/images/fedora28.qcow2,size=25 \
    --vcpus 6 \
    --os-type linux \
    --os-variant fedora28 \
    --location "$HOME/Downloads/Fedora-Everything-netinst-x86_64-28-1.1.iso" \
    -x 'ks=http://192.168.122.1:8000/ks.cfg' \
    # -x 'ks=https://raw.githubusercontent.com/bigjazzsound/workstation/master/ks.cfg'
