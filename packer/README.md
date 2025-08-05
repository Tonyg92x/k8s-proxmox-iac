# Proxmox Debian 12 VM Template with Packer

This project uses [Packer](https://www.packer.io/) to automatically build a **Debian 12.11.0** virtual machine template on a **Proxmox VE** server. The resulting VM is preconfigured with:

- LVM partitioning
- Cloud-Init support
- SSH access
- A minimal cleanup script to prepare for templating

---

## 🧰 Project Structure

```
packer/
├── packer.pkr.hcl # Main Packer configuration
├── http/
│ └── preseed.cfg # Debian automated installation preseed file
├── scripts/
│ └── cleanup.sh # Cleanup script executed before template conversion
```

---

## ✅ Requirements

- Proxmox VE with an accessible API endpoint
- Packer ≥ 1.8
- A Debian ISO available on your Proxmox node
- A valid PVE API token or user/password
- `qemu-guest-agent` installed and enabled on the Proxmox host

---

## 🔧 Variables

The Packer build expects the following variables, defined in the `packer.pkr.hcl`:

| Variable              | Description                       | Required |
|-----------------------|-----------------------------------|----------|
| `proxmox_url`         | Proxmox API URL                   | ✅       |
| `proxmox_username`    | Proxmox username or token ID      | ✅       |
| `proxmox_password`    | Password or API token secret      | ✅       |
| `storage_pool`        | Proxmox storage pool name         | ✅       |
| `ssh_password`        | Temporary SSH password for Packer | ✅       |
| `vm_name`             | Name of the VM                    | ❌       |
| `disk_size`           | Size of the VM disk               | ❌       |

---

## 🚀 Build Instructions

1. **Clone the repo and enter the directory:**

   ```bash
   git clone https://github.com/your-user/packer-proxmox-debian12-template.git
   cd packer
   ```

2. Initialize Packer plugins:

    ```
    packer init .
    ```

3. Build the template:

    ```
    packer build \
        -var "proxmox_url=https://proxmox.local:8006/api2/json" \
        -var "proxmox_username=root@pam" \
        -var "proxmox_password=yourpassword" \
        -var "storage_pool=local-lvm" \
        -var "ssh_password=packer" \
        .
    ```

4. Result

    - A new VM will be created in Proxmox
    - It will install Debian 12 automatically
    - Run cleanup
    - Be converted to a Cloud-Init-ready template

---

## 📦 Features

    - Automated unattended installation using preseed.cfg
    - Preconfigured for Cloud-Init (hostname, networking, SSH keys)
    - Optional shell provisioners for customization
    - Prepared for large-scale deployment via templates

---

##  💡 Tips

    - Ensure the ISO (debian-12.11.0-amd64-netinst.iso) is available in the specified storage (e.g., pmox-nas:iso)
    - For API token authentication, use:
        - proxmox_username = "user@pam!token_id"
        - proxmox_password = "token_secret"

---

##  📁 License

    MIT — use freely and adapt as needed.

---
