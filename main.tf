provider "aws" {
  region = "eu-north-1"
}

# Security Group to allow SSH and HTTP from anywhere
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Allow SSH and HTTP from anywhere"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # SSH open to all IPs
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # HTTP open to all IPs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance using existing key
resource "aws_instance" "jenkins_ec2" {
  ami             = "ami-0fa91bc90632c73c9"  # Your specified AMI
  instance_type   = "t3.micro"               # Your specified instance type
  key_name        = "new-key"                # Your existing key
  security_groups = [aws_security_group.jenkins_sg.name]

  tags = {
    Name = "Jenkins-Terraform-EC2"
  }
}

# Output the public IP
output "ec2_public_ip" {
  value = aws_instance.jenkins_ec2.public_ip
}

