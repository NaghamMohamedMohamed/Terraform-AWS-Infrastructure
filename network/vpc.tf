resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.env_name}-vpc"
  }
}
