data "aws_ssm_parameter" "rds_endpoint" {
  depends_on = [
    aws_ssm_parameter.rds_db_address
  ]
  name = "/${var.environment}/${var.identifier}/RDS/ENDPOINT"
}
data "aws_ssm_parameter" "rds_username" {
  depends_on = [
    aws_ssm_parameter.rds_db_address
  ]
  name = "/${var.environment}/${var.identifier}/RDS/USER"
}
data "aws_ssm_parameter" "rds_password" {
  depends_on = [
    aws_ssm_parameter.rds_db_address
  ]
  name = "/${var.environment}/${var.identifier}/RDS/PASSWORD"
}
data "aws_ssm_parameter" "rds_db_name" {
  depends_on = [
    aws_ssm_parameter.rds_db_address
  ]
  name = "/${var.environment}/${var.identifier}/RDS/NAME"
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
  name        = "/${var.environment}/${var.identifier}/RDS/${var.mysql_users[count.index]}/USERNAME"
  description = "${var.mysql_users[count.index]} Username"
  type        = "String"
  value       = mysql_user.app_user[count.index].user

}
resource "aws_ssm_parameter" "app_password" {
  count = var.create_mysql_user ? length(var.mysql_users) : 0
  name        = "/${var.environment}/${var.identifier}/RDS/${var.mysql_users[count.index]}/PASSWORD"
  description = "${var.mysql_users[count.index]} Password"
  type        = "SecureString"
  value       = random_string.app_password[count.index].result

}
