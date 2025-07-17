output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "rds_endpoint" {
  value = aws_db_instance.devops.endpoint
}

output "rds_db_name" {
  value = aws_db_instance.devops.db_name
}
