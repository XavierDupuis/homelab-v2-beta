#!/bin/bash
# Based on https://mattedwards.org/2024/07/using-cloud-init-with-proxmox-vms/

TEMPLATE_ID=9000
TEMPLATE_NAME="debian-template"
TEMPLATE_DISK_NAME="debian-13-generic-amd64.qcow2"
TEMPLATE_DISK_DOWNLOAD_URL="https://cloud.debian.org/images/cloud/trixie/latest/$TEMPLATE_DISK_NAME"
MEMORY=2048
CORES=2
STORAGE="local-lvm"
BRIDGE="vmbr0"
USERNAME="debian"

cd /var/lib/vz/template/iso/

if [ -f "$TEMPLATE_DISK_NAME" ]; then
    echo "$TEMPLATE_DISK_NAME already exists, skipping download."
else
    echo "Downloading $TEMPLATE_DISK_NAME..."
    wget $TEMPLATE_DISK_DOWNLOAD_URL
fi

# Create VM
qm create $TEMPLATE_ID --name $TEMPLATE_NAME --memory $MEMORY --cores $CORES --net0 virtio,bridge=$BRIDGE
# Import the VM cloud image as a disk to the VM template.
qm importdisk $TEMPLATE_ID $TEMPLATE_DISK_NAME $STORAGE
# Set the disk for the VM to be the disk we just imported in the previous step `vm-9000-disk-0` is the name of the disk that was generated after the import.
qm set $TEMPLATE_ID --scsihw virtio-scsi-pci --scsi0 $STORAGE:vm-$TEMPLATE_ID-disk-0
# Create the cloud-init CD-ROM drive which activates the cloud-init options for the VM.
qm set $TEMPLATE_ID --ide2 $STORAGE:cloudinit
# Define the boot disk and boot order.
qm set $TEMPLATE_ID --boot c --bootdisk scsi0
# Configure a serial console to use as display otherwise we won't see anything in the "Console" view in Proxmox.
qm set $TEMPLATE_ID --serial0 socket --vga serial0
# Enables guest agent so Proxmox can give more info about the VM when running.
qm set $TEMPLATE_ID --agent enabled=1
# By default, have the image use DHCP for obtaining an IP address (we can override this later, per VM).
qm set $TEMPLATE_ID --ipconfig0 ip=dhcp
# Set default cloud-init user
qm set $TEMPLATE_ID --ciuser $USERNAME
# Resize the disk to the desired size, e.g., 4G.
qm resize $TEMPLATE_ID scsi0 4G
# Make the VM a template
qm template $TEMPLATE_ID

echo "Template created successfully with ID $TEMPLATE_ID"