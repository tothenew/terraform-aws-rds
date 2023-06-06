resource "aws_ssm_parameter" "rds_db_password" {
  count       = var.secret_method ? 1 : 0
  name        = "/${local.project_name_prefix}/rds/${local.current_day}/password"
  description = "RDS Password"
  type        = "SecureString"
  key_id      = var.ssm_kms_key_id
  value       = random_string.rds_db_password.result

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "rds_db_user" {
  count       = var.secret_method ? 1 : 0
  name        = "/${local.project_name_prefix}/rds/${local.current_day}/user"
  description = "RDS User"
  type        = "SecureString"
  key_id      = var.ssm_kms_key_id
  value       = var.master_username
}

resource "aws_ssm_parameter" "rds_endpoint" {
  count       = var.secret_method ? 1 : 0
  name        = "/${local.project_name_prefix}/rds/${local.current_day}/endpoint"
  description = "RDS Endpoint"
  type        = "String"
  value       = var.create_aurora == true ? aws_rds_cluster.rds_cluster[0].endpoint : aws_db_instance.rds_instance[0].endpoint
}

resource "aws_ssm_parameter" "rds_reader_endpoint" {
  count       = var.create_aurora == true && var.secret_method ? 1 : 0
  name        = "/${local.project_name_prefix}/rds/${local.current_day}/reader_endpoint"
  description = "RDS Reader Endpoint"
  type        = "String"
  value       = aws_rds_cluster.rds_cluster[0].reader_endpoint
}
