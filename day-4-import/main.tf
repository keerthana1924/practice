provider "aws" {
  
}

resource "aws_instance" "keethu" {
    ami = "ami-055e3d4f0bbeb5878"
    instance_type = "t2.micro"
    key_name = "keerthi"
    availability_zone = "us-west-2c"
    tags = {
        Name="import"
    }
  
}