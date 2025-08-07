# 🧱 Terraform Kubernetes Cluster on Proxmox

This project provisions a Kubernetes cluster on a Proxmox server using [Telmate's Proxmox Terraform provider (v3.0.2-rc03)](https://github.com/Telmate/terraform-provider-proxmox). It automates the creation of:

- `k8s-master` nodes (control plane)
- `k8s-worker` nodes (data plane)
- Cloud-Init-based initialization with SSH access and static IP configuration

---

## 📁 Project Structure

```
.
├── main.tf # Terraform resources and Proxmox VM definitions
├── variables.tf # Declared variables for reusable configuration
├── terraform.tfvars # (optional) Variable values for your local environment
└── README.md # You're here!
```

---

## 📦 Requirements

- Terraform v1.5+
- Proxmox VE (tested on 7.x or later)
- Proxmox API token with sufficient permissions
- A **Debian 12 VM template** in Proxmox with:
  - QEMU Guest Agent installed
  - Cloud-Init enabled
  - Storage on `local-lvm` or appropriate pool

---

## 🔧 Configuration

Create a `terraform.tfvars` file or export environment variables for the following:

```
pm_api_url          = "https://your-proxmox-host:8006/api2/json"
pm_api_token_id     = "terraform@pve!terraform-token"
pm_api_token_secret = "your_api_token_secret"
pm_node_1           = "pmox-s01"

#   Edit for the number of nodes, you can scale up by increasing those values.
k8s_master_nb       = 1
k8s_worker_nb       = 3

cloudinit_username              = "debian"
cloudinit_password              = "your_secure_password"
cloudinit_ssh_pub               = "ssh-rsa AAAA..."
cloudinit_searchdomain          = "yourdomain.local"
cloudinit_dns                   = "192.168.1.1"
cloudinit_subnet                = "192.168.1.0/24"
cloudinit_net_first_ip_master   = 100
cloudinit_net_first_ip_worker   = 200

#   Optional, second network interface for network storage on fiber connection
eneable_data_network            = false
cloudinit_subnet_data           = "192.168.2.0/24"
cloudinit_gateway_data          = "192.168.2.1"
```

The first network connection must be named vmbr0 and the second one must be named vmbr1

---

🖥️ Resources Created

🔹 Master Nodes

- Named k8s-master-1 to k8s-master-N
- 2 vCPU, 4 GB RAM, 32 GB disk
- Cloud-Init configured
- QEMU Agent enabled
- Static IP via ipconfig0

🔸 Worker Nodes

- Named k8s-worker-1 to k8s-worker-N
- 2 vCPU, 3 GB RAM, 32 GB disk
- Cloud-Init configured
- Agent enabled
- Static IP via ipconfig0

---

🚀 Usage

✅ Initialize Terraform

```
terraform init
```

📝 Preview Plan

```
terraform plan -out plan
```

⚙️ Apply Configuration

```
terraform apply plan
```

🧨 Destroy Cluster

```
terraform destroy
```

---

🛡️ Security Notes

- Cloud-Init credentials are marked as sensitive in Terraform.
- Use environment variables or .tfvars files with .gitignore to avoid committing secrets.

---

🤝 License

MIT — free to use and modify.

---

🙋‍♂️ Support

If you encounter issues with the provider itself, check:

- https://github.com/Telmate/terraform-provider-proxmox/issues

For questions about this repo or ideas to extend it, feel free to open an issue or submit a pull request.

---

Happy provisioning! 🚀
