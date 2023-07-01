
# data "aws_elasticache_subnet_group" "subnet_group" {
#   name       = "redis-demo"
# }
resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = "redis-demo"
  replication_group_description = "Redis cluster for Hashicorp ElastiCache example"
 engine_version                 = "4.0.10"
  node_type            = "cache.r5.large"
  port                 = 6379
  parameter_group_name = "default.redis4.0"
 security_group_ids= [""]
#   snapshot_retention_limit = 5
#   snapshot_window          = "00:00-05:00"
 
  # subnet_group_name = data.aws_elasticache_subnet_group.subnet_group.name
 
  automatic_failover_enabled = true
 
  cluster_mode {
    replicas_per_node_group = 1
    num_node_groups         = 1
  }
}