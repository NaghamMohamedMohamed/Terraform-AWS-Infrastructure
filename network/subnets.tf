resource "aws_subnet" "public" {
  for_each = toset(var.public_subnets)

  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = each.key
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env_name}-public-${each.key}"
  }
}


resource "aws_subnet" "private" {
  for_each = toset(var.private_subnets)

  vpc_id     = aws_vpc.myvpc.id
  cidr_block = each.value
  availability_zone = element(var.azs, index(var.private_subnets, each.value))
  
  tags = {
    Name = "${var.env_name}-private-${each.value}"
  }
}
