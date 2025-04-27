# Security Group for Bastion EC2
resource "aws_security_group" "bastion_sg" {
  name        = "${var.env_name}-bastion-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env_name}-bastion-sg"
  }
}

# Security Group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "${var.env_name}-rds-sg"
  description = "Allow MySQL Access"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env_name}-rds-sg"
  }
}

# Security Group for Elasticache
resource "aws_security_group" "elasticache_sg" {
  name        = "${var.env_name}-elasticache-sg"
  description = "Allow Redis Access"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # private access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env_name}-redis-sg"
  }
}
