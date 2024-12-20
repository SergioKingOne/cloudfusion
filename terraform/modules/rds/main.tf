resource "aws_db_subnet_group" "main" {
  name       = "wanderlog-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "wanderlog-db-subnet-group"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow PostgreSQL traffic from ECS tasks"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = var.security_group_ids
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

resource "aws_db_instance" "default" {
  identifier                 = "wanderlog-db"
  engine                     = "postgres"
  engine_version             = "16.3"
  instance_class             = "db.t3.micro"
  allocated_storage          = 20
  storage_type               = "gp2"
  username                   = "dbmaster"
  password                   = var.db_password
  parameter_group_name       = "default.postgres16"
  skip_final_snapshot        = true
  publicly_accessible        = false
  vpc_security_group_ids     = [aws_security_group.rds_sg.id]
  db_subnet_group_name       = aws_db_subnet_group.main.name
  multi_az                   = false
  auto_minor_version_upgrade = true
  backup_retention_period    = 7

  provisioner "local-exec" {
    command = "PGPASSWORD=${var.db_password} psql -h ${self.endpoint} -U ${var.db_username} -d ${var.db_name} -f ../app/src/db/schema.sql"
  }

  tags = {
    Name = "wanderlog-db"
  }
}
