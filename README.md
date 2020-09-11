# xcp-ng_disable-tx-checksum_for_pfsense.sh

This is a simple bash script written to save a bit of time and make the process easier of setting TX checksums to OFF on all Virtual Interfaces (VIFs) of a virtualized pfSense installation on XCP-NG version 8.x.   If one is installing a lot of pfSense VM's on XCP-NG, this might make your installation and configuration process a bit easier.   It was also intended to prevent Copy / Paste errors when manually performing the steps using the 'xe' tools.  It is an automated way of the process described in the XCP-NG documentation, which can be found here:  https://xcp-ng.org/docs/guides.html#pfsense-vm

The script is run with no arguements. 

It will list out all your VMs together with their VM Name and with their UUIDs, in an enumerated list.

Enter the number of the VM that is your pfSense VM you want to select. And hit ENTER.

The script will list all available VIF's associated with that VM you selected.   This gives you a chance to confirm the selection is correct, by comparing to the UUID's of the VM network interfaces shown in Xen Orchestra.  It should not be required to sanity check this, but it is there if you want.  

If it is correct, just hit ENTER and the next and final output will be notifications that each VIF is set to disable TX Checksums.

And that's it.
