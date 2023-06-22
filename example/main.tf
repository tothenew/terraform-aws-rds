module "mysql_database" {
  source = "git::https://github.com/tothenew/terraform-aws-rds.git"

  subnet_ids = ["subnet-7c16341b", "subnet-b2b59c9c"]
  vpc_id     = "vpc-855826ff"
}
