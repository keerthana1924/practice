provider "aws" {
  
}


data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["test"] # insert value here
  }
}

resource "aws_instance" "name" {
    ami= "ami-046b5b8111c19b3ac" 
    key_name = "keerthi"
    instance_type ="t2.nano"
    tags = {
      Name="honey"
    }
} 