
# 🚀 Strapi Cloud-Native Deployment on AWS ECS Fargate

<div align="center">

![AWS](https://img.shields.io/badge/AWS-ECS_Fargate-FF9900?style=for-the-badge&logo=amazonaws)
![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?style=for-the-badge&logo=terraform)
![Docker](https://img.shields.io/badge/Container-Docker-2496ED?style=for-the-badge&logo=docker)
![Strapi](https://img.shields.io/badge/CMS-Strapi-4945FF?style=for-the-badge&logo=strapi)
![CloudWatch](https://img.shields.io/badge/Monitoring-CloudWatch-FF4F8B?style=for-the-badge&logo=amazonaws)

</div>

---

## 📌 Project Overview

This project demonstrates a **production-grade, cloud-native deployment** of a Strapi CMS application using:

- 🐳 Docker for containerization  
- ☁️ Amazon ECS (Fargate) for serverless container orchestration  
- 🏗 Terraform for Infrastructure as Code  
- 📊 Amazon CloudWatch for monitoring & observability  
- 🔐 IAM roles and secure networking configuration  
- 📦 Amazon ECR for container registry  

This repository represents a real-world DevOps implementation of scalable cloud infrastructure.

---

## 🏗 Architecture Overview

```
Developer → Docker Build → Amazon ECR → ECS Task Definition → ECS Service (Fargate)
                                                          ↓
                                                   CloudWatch Logs
                                                          ↓
                                              CloudWatch Dashboard Metrics
```

### Components:

- Custom VPC
- Public Subnet
- Internet Gateway
- Route Tables
- Security Group
- ECS Cluster
- ECS Task Definition
- ECS Service (Fargate)
- ECR Repository
- CloudWatch Log Group
- CloudWatch Dashboard

---

## ⚙️ Tech Stack

| Layer | Technology |
|-------|------------|
| Application | Strapi CMS |
| Runtime | Node.js 22 |
| Container | Docker |
| Registry | Amazon ECR |
| Orchestration | Amazon ECS Fargate |
| Infrastructure | Terraform |
| Monitoring | Amazon CloudWatch |
| Version Control | GitHub |

---

## 📁 Project Structure

```
strapi-app/
│
├── config/
├── src/
├── public/
├── types/
│
├── terraform/
│   ├── provider.tf
│   ├── network.tf
│   ├── ecs.tf
│   ├── ecr.tf
│   ├── cloudwatch.tf
│
├── Dockerfile
├── .dockerignore
├── .gitignore
├── package.json
├── tsconfig.json
└── README.md
```

---

## 🐳 Docker Configuration

### Dockerfile

```dockerfile
FROM node:22

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

EXPOSE 1337

CMD ["npm", "run", "start"]
```

---

## 🏗 Infrastructure as Code (Terraform)

### Provider Configuration

```hcl
provider "aws" {
  region = "us-east-1"
}
```

### ECS Cluster

```hcl
resource "aws_ecs_cluster" "strapi_cluster" {
  name = "strapi-cluster"
}
```

### ECS Task Definition

```hcl
resource "aws_ecs_task_definition" "strapi_task" {
  family                   = "strapi-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
}
```

---

## 📊 Monitoring & Observability

### CloudWatch Log Group

```
/ecs/strapi
```

### Dashboard Metrics

- CPU Utilization
- Memory Utilization
- Running Task Count
- Network In (RxBytes)
- Network Out (TxBytes)

---

## 🚀 Deployment Workflow

### 1️⃣ Build Docker Image

```bash
docker build -t strapi-repo .
```

### 2️⃣ Push to ECR

```bash
docker tag strapi-repo:latest <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/strapi-repo:latest
docker push <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/strapi-repo:latest
```

### 3️⃣ Provision Infrastructure

```bash
terraform init
terraform apply
```

---

## 🔐 Security Considerations

- `.env` excluded from Git
- Terraform state excluded
- IAM least privilege applied
- Security groups restrict inbound traffic
- Public IP only assigned at task level

---

## 📈 Scalability

- Serverless Fargate compute
- Stateless container architecture
- Horizontal scaling via desired_count
- Future-ready for ALB integration

---

## 🔄 CI/CD (Extendable)

Future enhancement supports:

- GitHub Actions pipeline
- Automated Docker build
- Automatic ECR push
- ECS force deployment
- Zero manual intervention

---

## 🌍 Access Application

After deployment:

```
http://<Public-IP>:1337
```

---

## 🎯 Key Learning Outcomes

- Infrastructure as Code principles
- Container orchestration
- Production deployment strategies
- Observability best practices
- Cloud-native architecture design

---

## 🏁 Conclusion

This repository represents a complete end-to-end cloud deployment lifecycle of a modern CMS using AWS best practices, Terraform automation, and containerized microservice architecture.

---

<div align="center">

**Built with Cloud Engineering & DevOps Principles**

</div>

