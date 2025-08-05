# k8s-proxmox-iac

# 🔧 Infrastructure-as-Code: Proxmox + Packer + Terraform + Ansible + Kubernetes

This project demonstrates a complete Infrastructure-as-Code (IaC) pipeline to build, configure, and deploy a secure, production-grade Kubernetes cluster on a **self-hosted Proxmox environment**, using:

- 🧱 **Packer** – to create custom Debian-based VM templates
- 🌍 **Terraform** – to deploy and manage Proxmox virtual machines
- ⚙️ **Ansible** – to configure the VMs and bootstrap Kubernetes
- ☸️ **Kubernetes** – to orchestrate containerized apps
- 🚀 **GitHub** – to showcase version-controlled, portable DevOps workflows

---

## 📦 Project Structure

```
.
├── ansible/ # Roles, playbooks, inventory
├── k8s/ # Kubernetes manifests, Helm charts
├── packer/ # Packer templates, preseed.cfg, scripts
├── terraform/ # Terraform code to deploy VMs to Proxmox
├── .github/ # GitHub Actions (CI/CD)
├── .gitignore
└── README.md
```

---

## 🧰 Technologies Used

| Layer                     | Tooling                                       |
|---------------------------|-----------------------------------------------|
| VM image creation         | Packer + Preseed (Debian)                     |
| VM provisioning           | Terraform (Proxmox provider)                  |
| Configuration Mgmt        | Ansible                                       |
| Container orchestration   | Kubernetes (via k8s)                          |
| Secrets & security        | Ansible vaults                                |
| CI/CD                     | GitHub Actions (optional)                     |

---

## 🚀 Workflow Overview

1. **Image build**  
   Use Packer to build a hardened Debian image and prepare it for cloud-init or static SSH provisioning.

2. **Infrastructure deployment**  
   Use Terraform to interact with Proxmox and deploy VMs using the image built in step 1.

3. **Configuration**  
   Use Ansible to:
   - Configure networking, SSH, and system hardening
   - Install Kubernetes components (kubeadm/k3s, kubelet, etc.)
   - Set up Docker, firewalls, node labeling, etc.

4. **Cluster deployment**  
   Deploy your workloads via `kubectl`, Helm charts, or GitOps tools (e.g., ArgoCD/FluxCD).

---

## 🛠️ Requirements

| Tool                                      | Minimum Version           |
|-------------------------------------------|---------------------------|
| [Packer](https://www.packer.io/)          | 1.9+                      |
| [Terraform](https://www.terraform.io/)    | 1.4+                      |
| [Ansible](https://www.ansible.com/)       | 2.12+                     |
| [Proxmox VE](https://www.proxmox.com/)    | 7.x or 8.x                |
| macOS/Linux                               | (development platform)    |


---

## 🔐 Security Highlights

- Secrets and passwords excluded via `.gitignore`
- Ansible vaults and variable encryption (optional)
- Separate Kubernetes namespaces and RBAC (if implemented)

---

## 🛣️ Roadmap

### 🔨 Phase 1: Image & Template Preparation (Packer)
- [*] Create a Debian image using Packer
- [*] Automate disk partitioning using `preseed.cfg`
- [*] Add provisioning scripts (e.g., Docker, SSH)
- [*] Convert the image into a reusable VM template

### ☁️ Phase 2: Infrastructure Provisioning (Proxmox + Terraform)
- [ ] Use Terraform to deploy 3 virtual machines from the template
- [ ] Configure VM specs, networks, and SSH access via cloud-init or static setup

### ⚙️ Phase 3: Cluster Bootstrap with Ansible
- [ ] Create an Ansible inventory based on Terraform outputs
- [ ] Install and configure Kubernetes (k8s) on the VMs
- [ ] Setup control plane and join worker nodes
- [ ] Install core Kubernetes utilities (container runtime, CNI, etc.)

### ☸️ Phase 4: Kubernetes Configuration
- [ ] Organize and version Kubernetes manifests in `k8s/`
- [ ] Deploy essential resources (namespaces, network policies, ingress controllers, etc.)
- [ ] Test cluster functionality with a sample app or pod

### 📦 Future Enhancements (optional)
- [ ] Add GitOps workflow (ArgoCD or FluxCD)
- [ ] Integrate monitoring stack (Prometheus, Grafana)
- [ ] Set up GitHub Actions to validate Terraform, Ansible, and K8s manifests
- [ ] Add CI pipeline to build and deploy app containers automatically

---

## 🧠 Credits

This project was designed and built by **Anthony**, as a self-hosted DevOps lab to showcase cloud-native skills and infrastructure automation.

---

## 🪪 License

MIT — do whatever you want, just don't blame me if it breaks your cluster.

---
