resource "aws_db_subnet_group" "this" {
  name       = "${var.env_name}-db-subnet-group"
  subnet_ids = module.network.private_subnet_ids
  tags = {
    Name = "${var.env_name}-db-subnet-group"
  }
}


resource "aws_db_instance" "this" {
  identifier             = "${var.env_name}-rds"
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  username               = "admin"
  password               = "admin12345"
  db_subnet_group_name   = aws_db_subnet_group.this.name
  skip_final_snapshot    = true
  tags = {
    Name = "${var.env_name}-rds"
  }
}
