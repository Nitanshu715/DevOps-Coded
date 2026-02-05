# 🌍 Terraform Private EC2 Strapi Infrastructure

A production-style Infrastructure as Code (IaC) project deploying a secure, scalable AWS architecture using Terraform. This project provisions a private EC2 instance running Strapi CMS inside Docker, exposed securely through an Application Load Balancer, with full VPC networking and NAT configuration.

---

## 🏗️ Architecture Overview

This project follows real-world cloud architecture best practices:

User → Application Load Balancer (Public Subnets) → Private EC2 (Docker + Strapi) → NAT Gateway → Internet

---

## 🔐 Security Design

- EC2 instance is deployed in a **private subnet**
- Only Load Balancer can reach the application
- SSH access restricted to a single IP using Security Groups
- No public IP attached to the EC2 instance
- Outbound internet access enabled via NAT Gateway

---

## ☁️ AWS Services Used

- Amazon VPC
- Public & Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- EC2 Instance
- Application Load Balancer
- Target Groups & Listeners

---

## 🐳 Application Layer

The EC2 instance bootstraps automatically using `user_data`:

- Installs Docker
- Pulls Strapi Docker image
- Runs Strapi container on port 1337

---

## 📂 Project Structure

provider.tf — AWS provider configuration  
variables.tf — Input variables  
terraform.tfvars — Environment values  
main.tf — Core infrastructure code  
outputs.tf — Output values (Load Balancer DNS)  
user_data.sh — EC2 bootstrap script  

---

## 🚀 Deployment Steps

```bash
terraform init
terraform apply
```

After deployment:

```bash
app_url = <load-balancer-dns>
```

Access Strapi Admin Panel via browser.

---

## ⚙️ Infrastructure Components

### VPC
Custom CIDR block with DNS support enabled.

### Subnets
- Public Subnets (Multi-AZ for Load Balancer)
- Private Subnet (Application Server)

### Routing
Public route table routes to Internet Gateway.  
Private route table routes to NAT Gateway.

### Security Groups
ALB SG allows HTTP from internet.  
EC2 SG allows traffic only from ALB + SSH from user IP.

### EC2 Instance
Runs Strapi inside Docker. Private-only access.

### Load Balancer
Provides public entry point and forwards traffic to EC2.

---

## 📈 Why This Architecture?

- Follows zero-trust network principles
- Separates public and private resources
- Production-grade networking setup
- Infrastructure fully reproducible via code

---

## 🎯 Learning Outcomes

- VPC Design
- Network Segmentation
- NAT vs Internet Gateway
- Load Balancer configuration
- Terraform IaC workflows
- Secure cloud architecture

---

## 🧠 Key Terraform Concepts Used

- Resources
- Variables
- Outputs
- File provisioning
- Dependency management
- Infrastructure lifecycle

---

## 🔄 Future Enhancements

- HTTPS with ACM
- Auto Scaling Group
- RDS Database backend
- Domain + Route53
- CI/CD Pipeline

---

## 📜 License

Educational DevOps Project.

