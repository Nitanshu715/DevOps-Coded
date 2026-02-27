# 🚀 ECS Fargate Spot Deployment via AWS CLI (Windows CMD)

<p align="center">
  <img src="https://img.shields.io/badge/AWS-ECS-orange?style=for-the-badge&logo=amazonaws"/>
  <img src="https://img.shields.io/badge/Compute-Fargate%20Spot-blue?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Deployment-CLI%20Only-success?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Logging-Disabled-red?style=for-the-badge"/>
</p>

---

## 🧠 Project Summary

This project demonstrates a **production-grade container deployment** on **Amazon ECS** using the **FARGATE_SPOT capacity provider**, fully provisioned via **AWS CLI on Windows CMD**.

No AWS Console.  
No CloudWatch Logging.  
No Managed UI shortcuts.  

Pure infrastructure orchestration using CLI automation.

---

# 🏗 Architecture Overview

```text
+------------------------+
|   ECS Cluster          |
|  (FARGATE + SPOT)      |
+-----------+------------+
            |
            v
+------------------------+
| ECS Service (Replica)  |
| Capacity: FARGATE_SPOT |
+-----------+------------+
            |
            v
+------------------------+
| ECS Task Definition    |
| nginx container        |
| awsvpc networking      |
+-----------+------------+
            |
            v
+------------------------+
| Elastic Network        |
| Interface (ENI)        |
| Public IP Assigned     |
+------------------------+
```

---

# ⚙️ Infrastructure Configuration

## 1️⃣ Cluster Configuration

```cmd
aws ecs create-cluster --cluster-name my-fargate-spot-cluster
```

Attach Capacity Providers:

```cmd
aws ecs put-cluster-capacity-providers ^
--cluster my-fargate-spot-cluster ^
--capacity-providers FARGATE FARGATE_SPOT ^
--default-capacity-provider-strategy capacityProvider=FARGATE_SPOT,weight=1
```

### Technical Notes

- `FARGATE_SPOT` provides discounted compute.
- `weight=1` ensures full scheduling preference.
- `base=0` prevents fallback to regular Fargate.
- `launchType` remains `FARGATE` while compute source is Spot.

---

## 2️⃣ Task Definition (Fargate Compatible)

### Configuration

| Parameter | Value |
|------------|--------|
| Network Mode | awsvpc |
| CPU | 256 |
| Memory | 512 |
| Image | nginx |
| Logging | Disabled |

### task-def.json

```json
{
  "family": "my-spot-task",
  "networkMode": "awsvpc",
  "requiresCompatibilities": ["FARGATE"],
  "cpu": "256",
  "memory": "512",
  "executionRoleArn": "arn:aws:iam::<ACCOUNT_ID>:role/ecsTaskExecutionRole",
  "containerDefinitions": [
    {
      "name": "my-container",
      "image": "nginx",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "protocol": "tcp"
        }
      ]
    }
  ]
}
```

### Register Task

```cmd
aws ecs register-task-definition --cli-input-json file://task-def.json
```

> 🔴 No `logConfiguration` block included → CloudWatch intentionally disabled.

---

## 3️⃣ Service Creation (FARGATE_SPOT)

```cmd
aws ecs create-service ^
--cluster my-fargate-spot-cluster ^
--service-name my-spot-service ^
--task-definition my-spot-task ^
--desired-count 1 ^
--capacity-provider-strategy capacityProvider=FARGATE_SPOT,weight=1 ^
--network-configuration "awsvpcConfiguration={subnets=[subnet-XXXXXXXX],assignPublicIp=ENABLED}"
```

### Key Technical Behavior

- Each task receives a dedicated ENI.
- Public IP assigned via subnet configuration.
- Replica scheduling strategy.
- No Load Balancer attached.
- Default security group behavior applied.

---

# 🔍 Runtime Verification

## Confirm Service Uses Spot

```cmd
aws ecs describe-services --cluster my-fargate-spot-cluster --services my-spot-service
```

Look for:

```json
"capacityProviderStrategy": [
  {
    "capacityProvider": "FARGATE_SPOT"
  }
]
```

## Confirm Task Running

```cmd
aws ecs describe-tasks --cluster my-fargate-spot-cluster --tasks <TASK_ARN>
```

Verify:

```json
"capacityProviderName": "FARGATE_SPOT",
"lastStatus": "RUNNING"
```

---

# 🌐 Networking Deep Dive

Using `awsvpc` mode:

- Dedicated ENI per task
- Private IPv4 assigned
- Public IP attached (if enabled)
- Security group inherited from subnet defaults

Retrieve ENI:

```cmd
aws ec2 describe-network-interfaces --network-interface-ids <ENI_ID>
```

---

# 💰 Cost Optimization Strategy

### Why Fargate Spot?

- Significant compute discount
- Ideal for fault-tolerant workloads
- Excellent for dev/test environments

### Trade-Off

- Tasks may be interrupted
- Not suitable for critical persistent workloads

---

# 🧹 Cleanup Procedure

```cmd
aws ecs update-service --cluster my-fargate-spot-cluster --service my-spot-service --desired-count 0

aws ecs delete-service --cluster my-fargate-spot-cluster --service my-spot-service --force

aws ecs delete-cluster --cluster my-fargate-spot-cluster
```

---

# 🧩 Skills Demonstrated

- Advanced ECS Configuration
- Capacity Provider Strategy Engineering
- Spot Compute Optimization
- CLI-Based Infrastructure Automation
- Container Networking (ENI / awsvpc)
- IAM Role Integration
- Infrastructure Debugging via JSON Analysis
- Production-Style Deployment Without Console

---

# 🏁 Conclusion

This implementation showcases real-world cloud engineering capability by orchestrating a complete ECS deployment pipeline using Fargate Spot via Windows CLI.

The deployment reflects strong understanding of:

- Scheduler mechanics
- Compute abstraction layers
- Cost-aware architecture
- Network interface allocation
- Service orchestration patterns

---

<p align="center">
Built with AWS CLI • Engineered with Precision • Optimized for Cost
</p>


