module "mysql_database" {
  source = "git::https://github.com/tothenew/terraform-aws-rds.git"

  subnet_ids = ["subnet-043d59b3957d4", "subnet-093641ce3f549"]
  vpc_id     = "vpc-0c7ca42512bbb"
}
