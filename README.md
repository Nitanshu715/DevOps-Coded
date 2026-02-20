<p align="center">
  <h1 align="center"> ⚡ DevOps-Coded </h1>
  <h3 align="center">🚀 Cloud Infrastructure • Container Engineering • Secure Deployments</h3>
  <p align="center">
  </p>
</p>

<div align="center">

![AWS](https://img.shields.io/badge/AWS-Cloud%20Architecture-FF9900?style=for-the-badge&logo=amazonaws)
![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?style=for-the-badge&logo=terraform)
![Docker](https://img.shields.io/badge/Container-Docker-2496ED?style=for-the-badge&logo=docker)
![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-336791?style=for-the-badge&logo=postgresql)
![DevOps](https://img.shields.io/badge/Practice-DevOps-0A66C2?style=for-the-badge)

</div>

---

## 🌌 About This Repository

**DevOps-Coded** is a cloud-native engineering portfolio designed around real-world infrastructure design, containerization strategy, and secure deployment architecture.

This repository demonstrates the evolution of backend deployment from local development environments to fully provisioned, reproducible, and secure AWS infrastructure using Infrastructure as Code principles.

It reflects applied engineering — not theoretical configuration.

---

## 🧠 Engineering Vision

The implementations across this repository are built around the following principles:

- Infrastructure as Code (Terraform-driven)
- Immutable container artifacts
- Version-controlled deployments
- Deterministic Docker image tagging
- Secure VPC-based architecture
- IAM least-privilege enforcement
- Database isolation within private network boundaries
- Reproducible, automated infrastructure provisioning

---

## 🏗 Cloud Architecture Model

```
Developer
   ↓
Git Commit
   ↓
Docker Build
   ↓
Versioned Image (Git SHA)
   ↓
Amazon ECR
   ↓
Provisioned AWS Infrastructure (Terraform)
   ↓
EC2 Instance (Docker Runtime)
   ↓
Secure Amazon RDS PostgreSQL (Private Subnet)
```

---

## ☁️ AWS Infrastructure Capabilities

### Networking Architecture

- Custom VPC configuration
- Public and private subnet segmentation
- Internet Gateway and route table configuration
- Security group isolation
- Controlled inbound/outbound traffic rules
- Database layer isolation within VPC

### Compute Layer

- EC2 provisioning via Terraform
- Automated bootstrapping using user data scripts
- IAM instance profile attachment
- Role-based ECR access (no static credentials)

### Database Layer

- Amazon RDS PostgreSQL
- SSL-enforced connections
- No public database access
- Security group-restricted access from compute layer
- Managed storage and automated backups

---

## 🐳 Container Engineering Strategy

### Docker Design Approach

- Optimized Node.js base images
- Production dependency installation
- Clean layer caching strategy
- Environment-driven configuration
- Minimal attack surface container build

### Versioning Strategy

Each deployment image is tagged using Git commit SHA:

```
git rev-parse --short HEAD
docker tag app-image <ECR_URI>:<COMMIT_SHA>
docker push <ECR_URI>:<COMMIT_SHA>
```

This enables:

- Deterministic deployments
- Immutable production artifacts
- Traceable rollback capability
- Deployment reproducibility

---

## 🏗 Infrastructure as Code (Terraform)

The infrastructure layer is provisioned using modular Terraform configurations.

Core components include:

- VPC definitions
- Subnet allocation
- Security groups
- IAM roles and instance profiles
- EC2 provisioning
- RDS provisioning
- Networking dependencies

### Execution Flow

```
terraform init
terraform plan
terraform apply
```

Terraform ensures environment consistency across deployments and eliminates manual provisioning errors.

---

## 🔐 Security Architecture

Security is treated as a foundational requirement, not an afterthought.

### Security Controls Implemented

- No database exposure to 0.0.0.0/0
- EC2-to-RDS restricted communication
- IAM least privilege enforcement
- SSL-required database connections
- Secrets managed via environment configuration
- No hardcoded credentials
- Role-based ECR access

---

## 📦 Repository Structure

```
DevOps-Coded/
│
├── AWS-EC2-Terraform/
├── Containerized-Deployment-EC2/
├── Dockerized-Strapi/
├── RDS-PostgreSQL-Integration/
├── Strapi-Cloud/
├── Strapi-ECS-Fargate-CI-CD/
├── Terraform-Strapi-Cloud/
├── Terraform-Strapi-Infra/
│
└── README.md
```

Each directory represents a focused engineering layer contributing to the overall cloud deployment maturity.

---

## 📈 Engineering Progression

The repository reflects a clear growth curve:

Local Application Execution  
→ Dockerized Application  
→ EC2-based Cloud Deployment  
→ Secure RDS Integration  
→ Infrastructure as Code Automation  
→ Deterministic Image Versioning  
→ Production-Ready Secure Architecture  

---

## 🧩 Real-World Challenges Addressed

- Docker permission conflicts
- ECR authentication workflows
- RDS SSL enforcement errors
- pg_hba.conf encryption enforcement issues
- Security group misconfiguration debugging
- IAM role misbinding
- Terraform state management conflicts
- Cloud networking troubleshooting

These debugging scenarios strengthened practical production engineering capability.

---

## ⚙️ DevOps Competencies Demonstrated

Cloud Networking Architecture  
IAM Security Design  
Containerization Strategy  
Infrastructure as Code  
Secure Database Integration  
Deployment Versioning  
Production Debugging  
System Isolation & Boundary Design  
Cloud Automation Workflows  

---

## 🔮 Future Architecture Evolution

- Full CI/CD pipeline automation
- Load balancer integration
- HTTPS reverse proxy
- ECS-based container orchestration
- Secrets Manager integration
- Blue-Green deployment strategies
- CloudWatch monitoring and alerting
- Horizontal scaling design

---

## 🏁 Closing Statement

DevOps-Coded represents hands-on cloud engineering execution built around secure, reproducible, and production-aligned infrastructure systems.

This repository demonstrates applied DevOps capability through real infrastructure design, secure container deployments, database isolation, and automation-first architecture.

---

<div align="center">

Engineered with Cloud-Native Discipline

</div>


