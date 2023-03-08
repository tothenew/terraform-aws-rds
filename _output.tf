output "endpoint" {
  value = var.create_rds == true ? aws_db_instance.rds_db[0].endpoint : aws_rds_cluster.aurora_cluster[0].endpoint
}

output "identifier" {
  value = var.create_rds == true ? aws_db_instance.rds_db[0].identifier : aws_rds_cluster.aurora_cluster[0].cluster_identifier
}

output "username" {
  value = var.create_rds == true ? aws_db_instance.rds_db[0].username : aws_rds_cluster.aurora_cluster[0].master_username
}

output "password" {
  value = var.create_rds == true ? aws_db_instance.rds_db[0].password : aws_rds_cluster.aurora_cluster[0].master_password
  sensitive = true
}

output "port" {
  value = var.create_rds == true ? aws_db_instance.rds_db[0].port : aws_rds_cluster.aurora_cluster[0].port
  sensitive = true
}