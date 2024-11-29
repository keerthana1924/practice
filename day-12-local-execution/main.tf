provider "aws" {
  region = "us-west-2"  # Update with your desired region
}

resource "aws_db_instance" "rds" {
  identifier              = "my-db-instance"
  allocated_storage       = 20
  instance_class          = "db.t3.micro"
  engine                  = "mysql"
  engine_version          = "8.0"
  db_name                 = "mydatabase"
  username                = "admin"
  password                = "password123"
  publicly_accessible     = false
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
}

resource "aws_security_group" "rds_sg" {
  name = "rds-security-group"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # For testing only. Adjust for production.
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = ["subnet-054ddafd23a60a87a", "subnet-076e7f03bd08d95fb"]
}

resource "null_resource" "db_initializer" {
  depends_on = [aws_db_instance.rds]

  provisioner "local-exec" {
    command = <<EOT
    mysql -h ${aws_db_instance.rds.address} \
          -u ${aws_db_instance.rds.username} \
          -p${aws_db_instance.rds.password} \
          --port 3306 \
          -e "source ./mysql.sql"
    EOT
  }

  triggers = {
    db_instance_id = aws_db_instance.rds.id
  }
}
