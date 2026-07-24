resource "aws_db_subnet_group" "main" {
  name = "jerney-db-subnet-group"
  subnet_ids = var.private_subnet_ids
  tags = {
    Name = "jerney-db-subnet-group"
  }
}

resource "aws_security_group" "rds" {
    name = "jerney-rds-sg"
    vpc_id = var.vpc_id

    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"

        cidr_blocks = [
            "10.0.0.0/16"
        ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"

        cidr_blocks = [
            "0.0.0.0/0"
        ]
    }

    tags = {
        Name = "jerney-rds-sg"
    }
}

resource "aws_db_instance" "postgres" {
  identifier = "jerney-postgres"
  allocated_storage = 20
  engine = "postgres"
  engine_version = "17"
  instance_class = "db.t3.micro"
  db_name = var.db_name
  username = var.db_user
  password = var.db_password
  publicly_accessible = false
  skip_final_snapshot = true
  storage_encrypted = true
  multi_az = false
  backup_retention_period = 7
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]
}