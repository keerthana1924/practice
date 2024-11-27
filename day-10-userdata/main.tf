provider "aws" {
  
}



resource "aws_instance" "test" {
     ami    = "ami-055e3d4f0bbeb5878"
     key_name = "keerthi"
     instance_type = "t2.micro"
     user_data = file("userdata.sh")
     tags = {
       Name ="userdata"
     }


}