terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.49.0"
    }
  }

  backend "s3" {
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_id
  secret_key = var.aws_secret_key_id
}

module "db" {
  source                              = "terraform-aws-modules/rds/aws"
  identifier                          = var.db_identifier
  engine                              = "postgres"
  engine_version                      = "13.7"
  instance_class                      = "db.t3.medium"
  allocated_storage                   = 5
  performance_insights_enabled        = true
  db_name                             = var.db_identifier
  username                            = var.db_username
  password                            = var.db_password
  multi_az                            = true
  port                                = "5432"
  create_random_password              = false
  iam_database_authentication_enabled = false
  publicly_accessible                 = true

  vpc_security_group_ids = ["${aws_security_group.demodb_security.id}"]

  # maintenance_window = "Mon:00:00-Mon:03:00"
  # backup_window      = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  monitoring_interval    = "30"
  monitoring_role_name   = "${var.db_identifier}-monitoring-rule"
  create_monitoring_role = true

  tags = {
    Owner       = "user"
    Environment = var.environment
  }

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = var.subnet_ids

  # DB parameter group
  family = "postgres13"

  # DB option group
  major_engine_version = "13"

  # Database Deletion Protection
  deletion_protection = false

  # parameters = [
  #   {
  #     name = "character_set_client"
  #     value = "utf8mb4"
  #   },
  #   {
  #     name = "character_set_server"
  #     value = "utf8mb4"
  #   }
  # ]
}

resource "aws_security_group" "demodb_security" {
  name   = "${var.db_identifier}_security"
  vpc_id = var.vpc_id


  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["54.153.191.241/32"]
    description = "Open VPN"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Internet"
  }
}
