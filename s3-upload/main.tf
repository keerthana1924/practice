# Define the AWS provider
provider "aws" {
  region = "us-west-2"  # Specify your desired AWS region
}

# Create an S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-terraform-s3-bucket-example"  # Replace with a unique bucket name
  acl    = "private"                         # Access Control List
}

# Upload a file to the S3 bucket
resource "aws_s3_object" "my_object" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "folder/myfile.txt"  # Path in S3 bucket (can include folders)
  source = "./file.txt"  # Local file path (ensure the file exists locally)
  acl    = "private"                 # Access control for the uploaded object
}



