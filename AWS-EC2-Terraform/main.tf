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
