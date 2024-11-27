resource "aws_vpc" "keethu-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name= "project-k-vpc"
  }
}

#create public subnet
resource "aws_subnet" "keethu-sb" {
    vpc_id = aws_vpc.keethu-vpc.id
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = true  
    tags = {
      Name= "project-k-subnet"
    }
  
}

#create private subnet
resource "aws_subnet" "keethu-sb-prvt" {
    vpc_id = aws_vpc.keethu-vpc.id
    cidr_block = "10.0.1.0/24"
    tags = {
      Name= "project-k- prvt-subnet"
    }
  
}


#create internet gateway
resource "aws_internet_gateway" "keethu-ig" {
    vpc_id = aws_vpc.keethu-vpc.id
    tags = {
      Name= "ig"
    }
  
}

#create elastic ip
resource "aws_eip" "keethu-eip" {
  vpc = true
}

#create nat gateway
resource "aws_nat_gateway" "keethu-nat" {
 allocation_id = aws_eip.keethu-eip.id
  subnet_id     = aws_subnet.keethu-sb.id
  tags = {
    Name = "keethu-nat"
  }
}

#creation of routr table for prvt routing
resource "aws_route_table" "keethu-private-route" {
  vpc_id = aws_vpc.keethu-vpc.id
  tags = {
    Name = "project-k-private-rt"
  }

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.keethu-nat.id
  }
}

#creation of subnet associations to prvt
resource "aws_route_table_association" "private-subnet-association" {
  route_table_id = aws_route_table.keethu-private-route.id
  subnet_id      = aws_subnet.keethu-sb-prvt.id
}

#create route table and edit routes fo public
resource "aws_route_table" "keethu-route" {
    vpc_id = aws_vpc.keethu-vpc.id
    tags = {
      Name= "project-k-rt"
    }
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.keethu-ig.id
}
  
}

#create subnet associations for public
resource "aws_route_table_association" "keethu" {
    route_table_id = aws_route_table.keethu-route.id
    subnet_id = aws_subnet.keethu-sb.id


}

#create security groups
resource "aws_security_group" "keethu-sg" {
    name = "allow all traffic"
    vpc_id = aws_vpc.keethu-vpc.id
    tags = {
      Name= "sg-project-k"
    }
ingress{
    description = "inbound traffic"
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
}   
egress{
    description = "outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}   
}

#key pair creation
resource "aws_key_pair" "name" {
    key_name = "devops"
    public_key = file("~/.ssh/id_ed25519.pub") #here you need to define public key file path

  
}

#instance creation
resource "aws_instance" "dev" {
  ami                    = "ami-055e3d4f0bbeb5878"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.keethu-sg.id]
  key_name               = aws_key_pair.name.key_name
  subnet_id = aws_subnet.keethu-sb.id
  tags = {
    Name="keerthi"
  }

connection {
    type        = "ssh"
    user        = "ec2-user"  # Replace with the appropriate username for your EC2 instance
    # private_key = file("C:/Users/veerababu/.ssh/id_rsa")
    private_key = file("~/.ssh/id_ed25519")  #private key path
    host        = self.public_ip
  }
  # local execution procee 
 provisioner "local-exec" {
    command = "touch file500"
   
 }
  # File provisioner to copy a file from local to the remote EC2 instance
  provisioner "file" {
    source      = "file10"  # Replace with the path to your local file
    destination = "/home/ec2-user/file10"  # Replace with the path on the remote instance
  }
  # remote execution process 
  provisioner "remote-exec" {
    inline = [
"touch file200",
"echo hello from aws >> file200",
]
 }
}
