module "create_database" {
  source              = "git::https://github.com/tothenew/terraform-aws-rds.git"
  create_rds     = true
  create_aurora = false

  subnet_ids       = ["subnet-999999","subnet-999999"]
  vpc_id           = "vpc-999999"
  vpc_cidr         = ["172.31.0.0/16"]

  publicly_accessible = true
  allocated_storage = 10
  max_allocated_storage = 20
  engine = "mysql"
  engine_version = "5.7"
  instance_class = "db.t2.micro"
  database_name = "mydb"
  username   = "root"
  identifier = "my-first-db"
  apply_immediately = false
  storage_encrypted = false
  multi_az = false
  db_subnet_group_id = "subnet-group"
  deletion_protection = false
  auto_minor_version_upgrade = false
  count_aurora_instances = 1
  serverlessv2_scaling_configuration_max = 1.0
  serverlessv2_scaling_configuration_min = 0.5

  
  create_mysql_user = false
  mysql_users = ["user1","user2"]

  common_tags = {
    "Project"     = "internal",
    "Environment" = "dev"
  }
  environment = "dev"
  project_name_prefix = "rds-module"
}
