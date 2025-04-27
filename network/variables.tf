# VPC
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

# Public subnets CIDRs
variable "public_subnets" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

# Private subnets CIDRs
variable "private_subnets" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

# AWS Region
variable "region" {
  description = "AWS Region"
  type        = string
}

# Availability Zones
variable "azs" {
  description = "List of availability zones to use"
  type        = list(string)
}

# Environment name (optional but useful for tagging)
variable "env_name" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}
