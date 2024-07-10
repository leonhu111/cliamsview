terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.57.0"
    }
  }
  required_version = ">= 1.9.2"
}

provider "aws" {
  region = "ap-southeast-2"
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type          = "t2.micro"
  //key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  subnet_id              = aws_subnet.main.id

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
