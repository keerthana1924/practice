
# Provider-1 for us-east-1 (Default Provider)
provider "aws" {
}

#Another provider alias 
provider "aws" {
  region = "us-east-1"
  alias = "provider2"
}

resource "aws_s3_bucket" "test" {
  bucket = "devopstestttt"

}
resource "aws_s3_bucket" "test2" {
  bucket = "testdevopssss"
  provider = aws.provider2  #provider.value of alias
  
}
