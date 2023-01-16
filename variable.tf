variable "aws_region" {
  description = "AWS Region for resource"
  type        = string
}

variable "environment" {
  description = "Service Environment, staging,production,uat"
  type        = string
}

variable "aws_access_id" {
  description = "AWS Access ID for Deployment"
  type        = string
}

variable "aws_secret_key_id" {
  description = "AWS Secret Key ID for Deployment"
  type        = string
}

variable "db_identifier" {
  description = "DB Identifier"
  type        = string
}

variable "db_username" {
  description = "DB Username"
  type        = string
}

variable "db_password" {
  description = "DB Password"
  type        = string
}

variable "subnet_ids" {
  description = "List Subnet IDS"
  type        = list(string)
}

variable "vpc_id" {
  description = "AWS VPC ID"
  type        = string
}
