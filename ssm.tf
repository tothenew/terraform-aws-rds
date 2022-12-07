resource "aws_ssm_parameter" "rds_db_password" {
  count       = var.secret_method == "ssm" ? 1 : 0
  name        = "/${var.environment}/RDS/PASSWORD"
  description = "RDS Password"
  type        = "SecureString"
  key_id      = var.ssm_kms_key_id
  value       = random_string.rds_db_password.result

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "rds_db_user" {
  count       = var.secret_method == "ssm" ? 1 : 0
  name        = "/${var.environment}/RDS/USER"
  description = "RDS User"
  type        = "SecureString"
  key_id      = var.ssm_kms_key_id
  value       = var.create_rds == true ? aws_db_instance.rds_db[0].username : aws_rds_cluster.aurora_cluster[0].master_username
}

resource "aws_ssm_parameter" "rds_endpoint" {
  count       = var.secret_method == "ssm" ? 1 : 0
  name        = "/${var.environment}/RDS/ENDPOINT"
  description = "RDS Endpoint"
  type        = "String"
  value       = var.create_rds == true ? aws_db_instance.rds_db[0].endpoint : aws_rds_cluster.aurora_cluster[0].endpoint
}


resource "aws_ssm_parameter" "rds_reader_endpoint" {
  count       = var.create_aurora == true && var.secret_method == "ssm" ? 1 : 0
  name        = "/${var.environment}/RDS/READER_ENDPOINT"
  description = "RDS Reader Endpoint"
  type        = "String"
  value       = aws_rds_cluster.aurora_cluster[0].reader_endpoint
}

resource "aws_ssm_parameter" "rds_db_address" {
  count       = var.secret_method == "ssm" ? 1 : 0
  name        = "/${var.environment}/RDS/HOST"
  description = "RDS Hostname"
  type        = "String"
  value       = var.create_rds == true ? aws_db_instance.rds_db[0].address : aws_rds_cluster.aurora_cluster[0].endpoint
}

resource "aws_ssm_parameter" "rds_db_name" {
  count       = var.database_name == "" ? 0 : 1
  name        = "/${var.environment}/RDS/NAME"
  description = "RDS DB Name"
  type        = "String"
  value       = var.create_rds == true ? aws_db_instance.rds_db[0].db_name : aws_rds_cluster.aurora_cluster[0].database_name
}
