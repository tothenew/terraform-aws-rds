provider "mysql" {
  endpoint = var.create_rds == true ? aws_db_instance.rds_db[0].endpoint : "${aws_rds_cluster.aurora_cluster[0].endpoint
  username = var.create_rds == true ? aws_db_instance.rds_db[0].username : "${aws_rds_cluster.aurora_cluster[0].master_username
  password = random_string.rds_db_password.result
}

# Create RDS App users

resource "random_string" "app_password" {
  count = var.create_mysql_user ? length(var.mysql_users) : 0
  length  = 34
  special = false
}
resource "mysql_user" "app_user" {
  count = var.create_mysql_user ? length(var.mysql_users) : 0
  user               = var.mysql_users[count.index]
  host               = "%"
  plaintext_password = random_string.app_password[count.index].result
}

resource "mysql_grant" "app_user" {
  count = var.create_mysql_user ? length(var.mysql_users) : 0
  user       = mysql_user.app_user[count.index].user
  host       = mysql_user.app_user[count.index].host
  database   = var.create_rds == true ? aws_db_instance.rds_db[0].db_name : aws_rds_cluster.aurora_cluster[0].database_name
  privileges = ["SELECT", "UPDATE", "INSERT", "DELETE", "CREATE", "ALTER", "REFERENCES"]
}

resource "aws_ssm_parameter" "app_username" {
  count = var.create_mysql_user ? length(var.mysql_users) : 0
  name        = var.project == "" ? "/${var.environment}/${local.identifier}/${local.current_day}/rds/${var.mysql_users[count.index]}/username" : "/${var.environment}/${var.project}/${local.identifier}/${local.current_day}/rds/${var.mysql_users[count.index]}/username"
  description = "${var.mysql_users[count.index]} Username"
  type        = "String"
  value       = mysql_user.app_user[count.index].user

}
resource "aws_ssm_parameter" "app_password" {
  count = var.create_mysql_user ? length(var.mysql_users) : 0
  name        = var.project == "" ? "/${var.environment}/${local.identifier}/${local.current_day}/rds/${var.mysql_users[count.index]}/password" : "/${var.environment}/${var.project}/${local.identifier}/${local.current_day}/rds/${var.mysql_users[count.index]}/password"
  description = "${var.mysql_users[count.index]} Password"
  type        = "SecureString"
  value       = random_string.app_password[count.index].result

}
