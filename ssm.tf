#resource "aws_ssm_parameter" "rds_db_password" {
#  count       = var.secret_method == "ssm" ? 1 : 0
#  name        = var.project == "" ? "/${var.environment}/${local.identifier}/${local.current_day}/rds/password" : "/${var.environment}/${var.project}/${local.identifier}/${local.current_day}/rds/password"
#  description = "RDS Password"
#  type        = "SecureString"
#  key_id      = var.ssm_kms_key_id
#  value       = random_string.rds_db_password.result
#
#  lifecycle {
#    ignore_changes = [value]
#  }
#}
#
#resource "aws_ssm_parameter" "rds_db_user" {
#  count       = var.secret_method == "ssm" ? 1 : 0
#  name        = var.project == "" ? "/${var.environment}/${local.identifier}/${local.current_day}/rds/user" : "/${var.environment}/${var.project}/${local.identifier}/${local.current_day}/rds/user"
#  description = "RDS User"
#  type        = "SecureString"
#  key_id      = var.ssm_kms_key_id
#  value       = var.create_rds == true ? aws_db_instance.rds_db[0].username : aws_rds_cluster.aurora_cluster[0].master_username
#}
#
#resource "aws_ssm_parameter" "rds_endpoint" {
#  count       = var.secret_method == "ssm" ? 1 : 0
#  name        = var.project == "" ? "/${var.environment}/${local.identifier}/${local.current_day}/rds/endpoint" : "/${var.environment}/${var.project}/${local.identifier}/${local.current_day}/rds/endpoint"
#  description = "RDS Endpoint"
#  type        = "String"
#  value       = var.create_rds == true ? aws_db_instance.rds_db[0].endpoint : aws_rds_cluster.aurora_cluster[0].endpoint
#}
#
#
#resource "aws_ssm_parameter" "rds_reader_endpoint" {
#  count       = var.create_aurora == true && var.secret_method == "ssm" ? 1 : 0
#  name        = var.project == "" ? "/${var.environment}/${local.identifier}/${local.current_day}/rds/reader_endpoint" : "/${var.environment}/${var.project}/${local.identifier}/${local.current_day}/rds/reader_endpoint"
#  description = "RDS Reader Endpoint"
#  type        = "String"
#  value       = aws_rds_cluster.aurora_cluster[0].reader_endpoint
#}
#
#resource "aws_ssm_parameter" "rds_db_address" {
#  count       = var.secret_method == "ssm" ? 1 : 0
#  name        = var.project == "" ? "/${var.environment}/${local.identifier}/${local.current_day}/rds/host" : "/${var.environment}/${var.project}/${local.identifier}/${local.current_day}/rds/host"
#  description = "RDS Hostname"
#  type        = "String"
#  value       = var.create_rds == true ? aws_db_instance.rds_db[0].address : aws_rds_cluster.aurora_cluster[0].endpoint
#}
#
#resource "aws_ssm_parameter" "rds_db_name" {
#  count       = var.database_name == "" ? 0 : 1
#  name        = var.project == "" ? "/${var.environment}/${local.identifier}/${local.current_day}/rds/name" : "/${var.environment}/${var.project}/${local.identifier}/${local.current_day}/rds/name"
#  description = "RDS DB Name"
#  type        = "String"
#  value       = var.create_rds == true ? aws_db_instance.rds_db[0].db_name : aws_rds_cluster.aurora_cluster[0].database_name
#}
#
