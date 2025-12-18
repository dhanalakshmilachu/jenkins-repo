provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "jenkins_ec2" {
  ami           = "ami-0fa91bc90632c73c9"   # Ubuntu AMI (Stockholm)
  instance_type = "t3.micro"
  key_name      = "new-key"                  # existing keypair name

  user_data = file("${path.module}/userdata.sh")

  tags = {
    Name = "Jenkins-Terraform-EC2"
  }
}
resource "aws_security_group" "sg_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound"

  ingress {
    from_port   = 80
    to_port     = 80
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

output "ec2_public_ip" {
  value = aws_instance.jenkins_ec2.public_ip
}

