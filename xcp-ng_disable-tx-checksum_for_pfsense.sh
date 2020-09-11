#!/bin/bash
#
# Written by Kevin McPeake, Copyright 2020
# Version 1.0
# Simple script to make disabling TX Checksums on pfSense VMs
# Handy if your pfSense has lots of interfaces and/or you are re-installing XCP-NG / pfSense VM's frequently
#

declare -a array_vm_names
array_vm_names=(`xe vm-list | grep name-label | gawk -F\  '{ print $4 }'`)

declare -a array_vm_uuids
array_vm_uuids=(`xe vm-list | grep uuid | gawk -F\  '{ print $5 }'`)

VM_NAMES=`echo "${#array_vm_names[@]}"`
VM_UUIDS=`echo "${#array_vm_uuids[@]}"`

clear


for n in $(seq $VM_NAMES); do
	echo ""
	echo $((n-1))". "${array_vm_names["$((n-1))"]}" = "${array_vm_uuids["$((n-1))"]}
done


echo ""

echo "Enter the Index Number of the VM that is your pfSense Firewall"

read ans
clear
echo ""
echo "You selected the host:		"${array_vm_names[$ans]}
echo "This UUID will be used:		"${array_vm_uuids[$ans]}
echo "Hit ENTER to proceed or CONTROL-C to cancel."
echo ""
read ok

xe vif-list vm-uuid=${array_vm_uuids[$ans]}

echo ""
echo "If this is correct, hit ENTER again to Disable TX Checksum Offload.  Or CNTL-C to abort."
echo ""

read ok

declare -a array_vm_vifs
array_vm_vifs=(`xe vif-list vm-uuid=${array_vm_uuids[$ans]} | grep "^uuid" | gawk -F\  '{ print $5 }'`)

VM_VIFS=`echo "${#array_vm_vifs[@]}"`

for n in $(seq $VM_VIFS); do
        echo ""
        echo "Disabling TX Checksum Offload on VIF #"$((n-1))";  UUID="${array_vm_vifs["$((n-1))"]}
        xe vif-param-set uuid=${array_vm_vifs["$((n-1))"]} other-config:ethtool-tx="off"
done

echo ""
echo "Finished.  Please completely shutdown (not just a reboot) your pfSense VM, and then restart it for changes to take effect."
echo "NOTE: No other changes inside pfSense are needed. Doing so may negatively impact performance." 
