# Default provider (one region for all instances)
provider "aws" {
  region = "us-west-2"  # Change this to your desired region
}

# Variable for sandbox configurations
variable "sandboxes_config" {
  type = map(object({
    ami           = string
    instance_type = string
    name          = string
  }))
  default = {
    honey     = { ami = "ami-055e3d4f0bbeb5878", instance_type = "t2.micro", name = "honey-server"}
    keerthi   = { ami = "ami-055e3d4f0bbeb5878", instance_type = "t2.micro", name = "keerthi-server"}
    rohi      = { ami = "ami-055e3d4f0bbeb5878", instance_type = "t2.nano", name = "rohi-server" }
    oiuysdfgh = { ami = "ami-055e3d4f0bbeb5878", instance_type = "t2.nano", name = "special-server" }
  }
}

# Variable for key pair
variable "key" {
  type    = string
  default = "keerthi"
}

# EC2 instances resource
resource "aws_instance" "instances" {
  for_each = var.sandboxes_config

  ami           = each.value.ami
  instance_type = each.value.instance_type
  key_name      = var.key
  tags = {
    Name = each.value.name
  }
}
