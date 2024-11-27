resource "aws_instance" "test" {
     ami    = "ami-055e3d4f0bbeb5878"
     key_name = "keerthi"
     instance_type = "t2.micro"


}


resource "aws_s3_bucket" "name" {
    bucket = "keerthikeerthi9876"
    
  
}



#terraform apply -target=aws_s3_bucket.name
#terraform destroy -target=aws_s3_bucket.name