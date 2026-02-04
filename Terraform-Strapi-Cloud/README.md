# 🚀 Terraform AWS EC2 Strapi Deployment

## 📌 Project Overview
This project demonstrates a full Infrastructure as Code (IaC) workflow using Terraform to provision cloud infrastructure on AWS and deploy a production-ready Strapi headless CMS application on an EC2 instance.

The project covers:
- Modular Terraform architecture
- Automated SSH key generation
- Secure EC2 provisioning
- Security group configuration
- Public networking setup
- Node.js environment configuration
- Strapi deployment and runtime setup

---

## 🧱 Architecture

User → Internet → AWS VPC → EC2 Instance → Strapi Server (Port 1337)

---

## ⚙️ Tech Stack

| Layer | Technology |
|------|------------|
| Infrastructure | Terraform |
| Cloud Provider | AWS |
| Compute | EC2 |
| OS | Amazon Linux 2023 |
| Runtime | Node.js v20 |
| Application | Strapi v5 |
| Security | AWS Security Groups |
| Networking | Elastic IP |
| SSH | PEM Key generated via Terraform |

---

Terraform-Strapi-Cloud/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── modules/
│   └── ec2/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
└── README.md


---

## 🔐 Security Design

- SSH access limited to port 22
- Application access allowed only on port 1337
- Private key generated securely via TLS provider
- Key stored locally with 0400 permission

---

## 🏗 Terraform Module Responsibilities

### EC2 Module
- Generates RSA SSH key pair
- Creates AWS key pair resource
- Creates security group
- Provisions EC2 instance
- Outputs public IP

---

## 🚀 Deployment Steps

### 1️⃣ Initialize Terraform
terraform init

### 2️⃣ Review Plan
terraform plan

### 3️⃣ Apply Infrastructure
terraform apply

---

## 🌍 Accessing the Server

ssh -i strapi-key.pem ec2-user@<PUBLIC_IP>

---

## 🟢 Install Node.js

sudo yum update -y
curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash -
sudo yum install nodejs -y

---

## 🚀 Deploy Strapi

npx create-strapi-app@latest my-strapi --quickstart

---

## 🌐 Access Admin Panel

http://<PUBLIC_IP>:1337/admin

---

## 📊 Infrastructure Outputs

| Output | Description |
|--------|-------------|
| public_ip | EC2 public address |
| instance_id | Instance identifier |

---

## 🧠 Key Learnings

- Infrastructure automation using Terraform modules
- Secure cloud networking principles
- Handling memory constraints in small instances
- Node.js runtime management
- Production deployment troubleshooting

---

## 🔮 Future Improvements

- Use remote backend (S3 + DynamoDB)
- Add Nginx reverse proxy
- Configure SSL with Let's Encrypt
- Add CI/CD pipeline

---

## 👨‍💻 Author
Cloud & DevOps Project — Infrastructure Automation and Application Deployment

