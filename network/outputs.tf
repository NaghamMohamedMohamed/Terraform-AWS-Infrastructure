# Output VPC ID
output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.myvpc.id
}

# Output Public Subnets IDs
output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [for subnet in aws_subnet.public : subnet.id]
}

# Output Private Subnets IDs
output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [for subnet in aws_subnet.private : subnet.id]
}

# Output Internet Gateway ID
# output "internet_gateway_id" {
#   description = "ID of the Internet Gateway"
#   value       = aws_internet_gateway.igw.id
# }
