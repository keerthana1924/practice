provider "aws" {
  
}
locals {
  region = "us-west-2"
  environment = "dev"
  instance_type = "t2.micro"
  ami = "ami-055e3d4f0bbeb5878"
  key_name ="keerthi"
  Name = "locals"
}

resource "aws_instance" "example" {
  ami           = local.ami # Amazon Linux 2 AMI
  instance_type = local.instance_type
  key_name = local.key_name

  tags = {
    Name        = local.Name
    Environment = local.environment
  }
}