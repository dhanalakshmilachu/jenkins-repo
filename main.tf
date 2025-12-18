provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "jenkins_ec2" {
  ami           = "ami-0fa91bc90632c73c9"   # Ubuntu AMI (Stockholm)
  instance_type = "t2.micro"
  key_name      = "new-key"                  # existing keypair name

  user_data = file("${path.module}/userdata.sh")

  tags = {
    Name = "Jenkins-Terraform-EC2"
  }
}

output "ec2_public_ip" {
  value = aws_instance.jenkins_ec2.public_ip
}

