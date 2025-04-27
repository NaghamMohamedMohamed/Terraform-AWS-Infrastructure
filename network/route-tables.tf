# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.env_name}-public-rt"
  }
}

# Associate public subnets
resource "aws_route_table_association" "public_assoc" {
  for_each = aws_subnet.public


  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}



resource "aws_route_table" "private" {
  for_each = aws_subnet.private

  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.env_name}-private-rt-${each.key}"
  }
}


resource "aws_route_table_association" "private_assoc" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}


