terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-west-2"
}

## get self external IP address ##
data "external" "myipaddr" {
  program = ["bash", "-c", "curl -s 'https://api.ipify.org?format=json'"]
}


## Create a security group with local public IP to grant SSH access ##
## Plus http on ingress
## Plus egress for all
resource aws_security_group "my_security_group_SuperMario" {
  name   = "my_security_group_Super_Mario"
  vpc_id = var.vpc_id

  ingress {
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
    cidr_blocks = [
      "${data.external.myipaddr.result.ip}/32"
    ]
  }
  
  ingress {
    from_port = 80
    to_port = 81
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# resource 
resource "aws_instance" "td_challenge" {
  ami                         = "ami-08b993f76f42c3e2f"
  instance_type               = "t2.micro"
  key_name                    = "AKIAJIOZHCCE65ZPHYAA"
  associate_public_ip_address = true
  subnet_id                   = var.subnet_id
  user_data                   = file("install-docker.sh")
  vpc_security_group_ids      = [aws_security_group.my_security_group_SuperMario.id]
}

