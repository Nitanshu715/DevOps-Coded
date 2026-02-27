
# 🚀 Strapi Blue-Green Deployment on AWS ECS (Fargate Spot)

---

## 📌 Project Overview

This project demonstrates a production-grade containerized deployment of Strapi CMS on AWS ECS using Fargate Spot, fronted by an Application Load Balancer (ALB) with properly configured health checks and target groups.

The infrastructure was provisioned and managed entirely via AWS CLI (Windows CMD) without relying on CloudWatch for logging configuration.

---

## 🏗️ Architecture

Client → ALB (HTTP :80) → Target Group → ECS Service → Fargate Spot Tasks → Strapi Container (Port 1337)

- Compute: AWS ECS (Fargate Spot)
- Container Registry: Amazon ECR
- Load Balancer: Application Load Balancer (ALB)
- Networking: awsvpc mode
- Deployment Type: Rolling deployment (ECS controller)
- Region: ap-south-1

---

## 📦 Technologies Used

- Docker
- AWS CLI
- Amazon ECS
- Fargate Spot
- Amazon ECR
- Application Load Balancer
- Target Groups
- IAM Roles

---

## 🐳 Docker Image Build & Push

### Step 1: Build Docker Image

```cmd
docker build -t strapi-custom .
```

### Step 2: Authenticate to ECR

```cmd
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com
```

### Step 3: Tag Image

```cmd
docker tag strapi-custom <ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com/strapi-app:latest
```

### Step 4: Push Image

```cmd
docker push <ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com/strapi-app:latest
```

---

## 🧾 ECS Task Definition (Fargate)

```json
{
  "family": "strapi-task",
  "networkMode": "awsvpc",
  "requiresCompatibilities": ["FARGATE"],
  "cpu": "512",
  "memory": "1024",
  "executionRoleArn": "arn:aws:iam::<ACCOUNT_ID>:role/ecsTaskExecutionRole",
  "containerDefinitions": [
    {
      "name": "strapi-container",
      "image": "<ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com/strapi-app:latest",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 1337,
          "protocol": "tcp"
        }
      ],
      "environment": [
        { "name": "NODE_ENV", "value": "production" },
        { "name": "HOST", "value": "0.0.0.0" },
        { "name": "PORT", "value": "1337" }
      ]
    }
  ]
}
```

---

## ⚡ ECS Service Configuration

- Launch Type: FARGATE
- Capacity Provider Strategy: FARGATE_SPOT
- Desired Count: 1
- Network Mode: awsvpc
- Public IP: Enabled
- Subnets: Multiple AZs
- Security Group: Port 1337 allowed from ALB

---

## 🎯 Target Group Configuration

- Target Type: IP
- Protocol: HTTP
- Port: 1337
- Health Check Path: /admin
- Success Codes: 200-399

Health check configuration was updated to handle Strapi’s default 302 redirect behavior.

---

## 🔄 Load Balancer Listener

```cmd
aws elbv2 create-listener ^
--load-balancer-arn <ALB_ARN> ^
--protocol HTTP ^
--port 80 ^
--default-actions Type=forward,TargetGroupArn=<TARGET_GROUP_ARN>
```

---

## 🧠 Key Debugging Challenges Solved

- Docker Hub image pull denied
- GHCR image access failure
- Invalid ECS JSON syntax
- Essential container exited errors
- 302 health check failures
- Target deregistration loops

---

## 📊 Verification Commands

### Check Running Tasks

```cmd
aws ecs list-tasks --cluster strapi-bg-cluster
```

### Describe Service

```cmd
aws ecs describe-services --cluster strapi-bg-cluster --services strapi-bg-service
```

### Check Target Health

```cmd
aws elbv2 describe-target-health --target-group-arn <TARGET_GROUP_ARN>
```

---

## 🌐 Access Application

ALB DNS:

```
http://<your-alb-dns>/admin
```

Successful admin panel access confirms deployment stability.

---

## 🛡️ Production Improvements (Optional)

- Add HTTPS via ACM + 443 listener
- Add Route53 custom domain
- Implement CodeDeploy blue/green strategy
- Add GitHub Actions CI/CD pipeline
- Enable autoscaling policies

---

## 📌 Conclusion

This project demonstrates a complete container lifecycle:

- Build
- Push
- Register
- Deploy
- Load Balance
- Health Monitor
- Debug
- Stabilize

It reflects hands-on experience with AWS container orchestration and production-grade deployment workflows.

---

### 👨‍💻 Author

Nitanshu  
B.Tech CSE (Cloud Computing & Virtualization)

