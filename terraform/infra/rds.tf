resource "aws_db_subnet_group" "devops" {
  name       = "devops-db-subnet-group"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "devops-db-subnet-group"
  }
}

resource "aws_security_group" "rds" {
  name        = "devops-rds-sg"
  description = "Allow access to RDS from EKS"
  vpc_id      = module.vpc.vpc_id

  depends_on = [module.eks]

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [module.eks.node_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-rds-sg"
  }
}

resource "aws_db_instance" "devops" {
  identifier             = "devops-db"
  engine                 = "postgres"
  engine_version         = "17.5"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  username               = var.db_username
  password               = var.db_password
  db_name                = var.db_name
  port                   = 5432
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.devops.name
  skip_final_snapshot    = true

  tags = {
    Name = "devops-db"
  }
}
