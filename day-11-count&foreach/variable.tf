resource "aws_instance" "count" {
    ami = var.ami
    instance_type = var.type
    key_name = var.key
    #count = 4
    #count = length(var.sandboxes)
    for_each = toset(var.sandboxes)
    tags = {
     # Name="keethu-${count.index}"
    # Name=var.sandboxes[count.index]
    Name=each.value
    }
  
}

variable "ami" {
    type = string
    default = "ami-055e3d4f0bbeb5878"
  
}

variable "type" {
    type = string
    default = "t2.micro"

}

variable "key" {
    type = string
    default = "keerthi"
  
}

variable "sandboxes" {
    type = list(string)
    default = [ "honey","keerthi","rohi","oiuysdfgh" ]
  
}

