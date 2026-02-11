terraform {
  required_providers {
    aws   = { source = "hashicorp/aws" }
    tls   = { source = "hashicorp/tls" }
    local = { source = "hashicorp/local" }
  }
}

# 🔍 Get existing subnet
data "aws_subnet" "selected" {
  id = "subnet-011503439ebce1239"
}

# 🔑 KEY
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated" {
  key_name   = var.key_name
  public_key = tls_private_key.this.public_key_openssh
}

resource "local_file" "pem_file" {
  content         = tls_private_key.this.private_key_pem
  filename        = "${var.key_name}.pem"
  file_permission = "0400"
}

# 🔥 SECURITY GROUP in SAME VPC
resource "aws_security_group" "strapi_sg" {
  name   = "strapi-sg"
  vpc_id = data.aws_subnet.selected.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 🖥️ EC2
resource "aws_instance" "strapi_server" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.generated.key_name

  subnet_id = data.aws_subnet.selected.id

  vpc_security_group_ids = [aws_security_group.strapi_sg.id]

  associate_public_ip_address = true

  tags = {
    Name = "Strapi-Terraform-Server"
  }
}
