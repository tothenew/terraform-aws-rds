provider "mysql" {
  endpoint = var.create_aurora == true ? aws_rds_cluster.rds_cluster[0].endpoint : aws_db_instance.rds_instance[0].endpoint
  username = var.master_username
  password = var.create_username_password ? random_string.rds_db_password[0].result : var.master_password
}

resource "random_string" "app_password" {
  count   = length(var.mysql_users) > 0 ? length(var.mysql_users) : 0
  length  = 16
  special = false
}

resource "mysql_user" "app_user" {
  count              = length(var.mysql_users) > 0 ? length(var.mysql_users) : 0
  user               = var.mysql_users[count.index]
  host               = "%"
  plaintext_password = random_string.app_password[count.index].result
  depends_on         = [aws_db_instance.rds_instance, aws_rds_cluster_instance.rds_cluster_instance]
}

resource "mysql_grant" "app_user" {
  count      = length(var.mysql_users) > 0 ? length(var.mysql_users) : 0
  user       = mysql_user.app_user[count.index].user
  host       = mysql_user.app_user[count.index].host
  database   = var.database_name == "" ? local.default_database_name : var.database_name
  privileges = ["SELECT", "UPDATE", "INSERT", "DELETE", "CREATE", "ALTER", "REFERENCES"]
}

resource "aws_ssm_parameter" "app_username" {
  count       = length(var.mysql_users) > 0 ? length(var.mysql_users) : 0
  name        = "/${local.project_name_prefix}/rds/${local.current_day}/app/${var.mysql_users[count.index]}/username"
  description = "${var.mysql_users[count.index]} Username"
  type        = "String"
  value       = mysql_user.app_user[count.index].user

}
resource "aws_ssm_parameter" "app_password" {
  count       = length(var.mysql_users) > 0 ? length(var.mysql_users) : 0
  name        = "/${local.project_name_prefix}/rds/${local.current_day}/app/${var.mysql_users[count.index]}/password"
  description = "${var.mysql_users[count.index]} Password"
  type        = "SecureString"
  value       = random_string.app_password[count.index].result
}
