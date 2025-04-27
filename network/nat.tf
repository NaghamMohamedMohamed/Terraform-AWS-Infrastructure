# Elastic IP for NAT
resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id

  # Attach to the first available public subnet
  subnet_id = values(aws_subnet.public)[0].id

  tags = {
    Name = "${var.env_name}-nat"
  }
}

