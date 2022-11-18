output "endpoint" {
  value = var.create_rds == true ? aws_db_instance.rds_db[0].endpoint : aws_rds_cluster.aurora_cluster[0].endpoint
}

output "identifier" {
  value = var.create_rds == true ? aws_db_instance.rds_db[0].identifier : aws_rds_cluster.aurora_cluster[0].cluster_identifier
}