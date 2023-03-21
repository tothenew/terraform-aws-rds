data "aws_ssm_parameter" "rds_endpoint" {
  depends_on = [
    aws_ssm_parameter.rds_db_address
  ]
  name = var.project == "" ? "/${var.environment}/${local.identifier}/${local.current_day}/rds/endpoint" : "/${var.environment}/${var.project}/${local.identifier}/${local.current_day}/rds/endpoint"
}
data "aws_ssm_parameter" "rds_username" {
  depends_on = [
    aws_ssm_parameter.rds_db_address
  ]
  name = var.project == "" ? "/${var.environment}/${local.identifier}/${local.current_day}/rds/user" : "/${var.environment}/${var.project}/${local.identifier}/${local.current_day}/rds/user"
}
data "aws_ssm_parameter" "rds_password" {
  depends_on = [
    aws_ssm_parameter.rds_db_address
  ]
  name = var.project == "" ? "/${var.environment}/${local.identifier}/${local.current_day}/rds/password" : "/${var.environment}/${var.project}/${local.identifier}/${local.current_day}/rds/password"
}
data "aws_ssm_parameter" "rds_db_name" {
  depends_on = [
    aws_ssm_parameter.rds_db_address
  ]
  name = var.project == "" ? "/${var.environment}/${local.identifier}/${local.current_day}/rds/name" : "/${var.environment}/${var.project}/${local.identifier}/${local.current_day}/rds/name"
}

provider "mysql" {
  endpoint = "${data.aws_ssm_parameter.rds_endpoint.value}"
  username = "${data.aws_ssm_parameter.rds_username.value}"
  password = "${data.aws_ssm_parameter.rds_password.value}"
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
  database   = data.aws_ssm_parameter.rds_db_name.value
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