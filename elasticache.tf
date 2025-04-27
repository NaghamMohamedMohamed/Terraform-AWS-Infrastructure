resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.env_name}-elasticache-subnet-group"
  subnet_ids = module.network.private_subnet_ids
}

resource "aws_elasticache_cluster" "this" {
  cluster_id           = "${var.env_name}-redis"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  subnet_group_name    = aws_elasticache_subnet_group.this.name
  engine_version       = "6.x"
  tags = {
    Name = "${var.env_name}-redis"
  }
}
