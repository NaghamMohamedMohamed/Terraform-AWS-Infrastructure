variable "region" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "vpc_cidr"         { default = "10.0.0.0/16" }
variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "env_name" {
  description = "The environment name (dev or prod)"
  type        = string
}

variable "azs" {
  description = "List of Availability Zones for each environment"
  type        = list(string)
}