module "mysql_database" {
  source = "git::https://github.com/narenderttn/terraform-aws-rds.git"

  subnet_ids = ["subnet-043d59b3957d49e1d", "subnet-093641ce3f549831e"]
  vpc_id     = "vpc-0c7ca42512bbbb3df"
}
