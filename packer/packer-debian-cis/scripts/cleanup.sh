#!/bin/bash
set -eux

# Ensure we're running as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root or with sudo."
  exit 1
fi

# Clean APT cache
apt-get clean
rm -rf /var/lib/apt/lists/*

# Clean DHCP leases
rm -f /var/lib/dhcp/* || true
rm -f /var/lib/dhcp3/* || true

# Reset machine-id (important for cloning)
truncate -s 0 /etc/machine-id
rm -f /var/lib/dbus/machine-id || true
ln -sf /etc/machine-id /var/lib/dbus/machine-id

# Clear Cloud-Init state
cloud-init clean --logs --seed || true

# Remove persistent net rules (handled by cloud-init or systemd)
rm -f /etc/udev/rules.d/70-persistent-net.rules

# Remove SSH host keys (regenerated on first boot by Cloud-Init)
rm -f /etc/ssh/ssh_host_* || true

# Reset hostname (cloud-init will set it)
echo "debian" > /etc/hostname
hostnamectl set-hostname debian

# Clean temp directories
rm -rf /tmp/*
rm -rf /var/tmp/*

# Log files cleanup
find /var/log -type f -exec truncate -s 0 {} \;

# remove shell history 
unset HISTFILE
rm -f /root/.bash_history
rm -f /home/packer/.bash_history

echo "✅ VM cleanup complete. Ready for template conversion."
