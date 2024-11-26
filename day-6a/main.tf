resource "aws_instance" "name" {
  ami = var.ami
  key_name = var.key
  instance_type = var.type
  tags = {
    Name= "ec2-dev"
  }
}
