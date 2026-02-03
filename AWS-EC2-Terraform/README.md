# 🚀 AWS EC2 Manual vs Terraform Deployment — Detailed Project Documentation

## 📌 Project Objective

The objective of this project was to gain deep practical understanding of **AWS core infrastructure** and **Infrastructure as Code (IaC)** using **Terraform**.  
Instead of a simple lab execution, this project evolved into a real-world cloud troubleshooting experience where multiple infrastructure failures occurred. Each failure forced us to refer to AWS documentation, Terraform documentation, and cloud networking concepts to successfully build a working deployment.

This project simulates how real DevOps engineers work — infrastructure rarely works on the first try, and systematic debugging becomes the primary skill.

---

## 🌍 Part 1 — Manual EC2 Deployment (AWS Console)

We began by launching an EC2 instance manually through the AWS Console to understand foundational cloud concepts before automation.

### Configuration Used
- AMI: Ubuntu / Amazon Linux
- Instance Type: t2.micro
- Public IP: Enabled
- Key Pair: Created and downloaded
- Security Group: SSH (Port 22) allowed

### Outcome
The instance was successfully launched and SSH connectivity verified. This step helped us understand:
- EC2 provisioning basics
- Role of security groups
- Key-based authentication
- Public vs private IPs

---

## 🤖 Part 2 — Terraform EC2 Deployment (Infrastructure as Code)

Next, we automated the infrastructure using Terraform.

### Terraform Workflow

```bash
terraform init
terraform plan
terraform apply
terraform output
terraform destroy
```

### Terraform Configuration Used

```hcl
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "demo" {
  ami                         = "ami-0f5ee92e2d63afc18"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-090490bd289d93a46"
  associate_public_ip_address = true

  tags = {
    Name = "terraform-ec2-demo"
  }
}
```

---

## ⚠️ Challenges Faced (Real Cloud Failures)

This project did not work on the first attempt. Multiple infrastructure errors occurred, and each one required research and debugging.

### 1️⃣ No Default VPC
Terraform failed to launch EC2 because the AWS account did not have a default VPC.

**Solution:**  
We studied AWS VPC documentation and manually specified a subnet ID in Terraform.

---

### 2️⃣ Region Mismatch
AMI and subnet belonged to a different region than configured.

**Solution:**  
Aligned Terraform provider region with subnet region.

---

### 3️⃣ No Public IP Assigned
Instance launched but had no public IP, making SSH impossible.

**Solution:**  
Added:
```hcl
associate_public_ip_address = true
```

---

### 4️⃣ Missing Internet Connectivity
Even with a public IP, the instance could not connect to the internet.

**Investigation Findings:**
- Route table lacked route to Internet Gateway.

**Solution:**
- Created and attached Internet Gateway
- Added route:
```
0.0.0.0/0 → Internet Gateway
```

---

### 5️⃣ Security Group Blocking SSH
Networking was correct but SSH still failed.

**Solution:**  
Added inbound rule:
```
Port 22 (SSH) → 0.0.0.0/0
```

---

### 6️⃣ SSH Key Access Issue
Key pair file was missing locally.

**Solution:**  
Used **EC2 Instance Connect (browser-based SSH)** to access the instance.

---

## 📚 Role of Documentation

Every issue required reading:
- AWS VPC documentation
- Terraform AWS provider docs
- EC2 networking architecture

Documentation helped us understand:
- How cloud networking layers interact
- Why routes, IGWs, and SGs matter
- How Terraform maps infrastructure to AWS APIs

---

## 🎓 Learning Outcomes

This project helped us understand:

- AWS EC2 provisioning
- Terraform Infrastructure as Code workflow
- VPC networking (subnets, route tables, IGW)
- Security groups and firewall rules
- Public vs private networking
- Systematic cloud troubleshooting
- Real-world DevOps debugging approach

---

## 🏁 Conclusion

This was not just an EC2 lab — it became a complete cloud infrastructure debugging experience.  
Through failures, documentation study, and iterative fixes, we successfully built a fully automated EC2 deployment.

This reflects real cloud engineering workflows where understanding failures is as important as writing code.
```
