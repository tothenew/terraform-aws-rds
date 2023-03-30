module "create_database" {
  source              = "git::https://github.com/tothenew/terraform-aws-rds.git"
  create_rds     = false
  create_aurora = true

  subnet_ids       = ["subnet-999999","subnet-999999"]
  vpc_id           = "vpc-999999"
  vpc_cidr         = ["172.31.0.0/16"]

  publicly_accessible = true
  allocated_storage = 10
  max_allocated_storage = 20
  engine = "aurora-mysql"
  engine_version = "8.0.mysql_aurora.3.02.0"
  instance_class = "db.serverless"
  database_name = "mydb"
  username   = "root"
  identifier = "final-test"
  apply_immediately = false
  storage_encrypted = false
  multi_az = false
  db_subnet_group_id = "subnet-group"
  deletion_protection = false
  auto_minor_version_upgrade = false
  count_aurora_instances = 1
  serverlessv2_scaling_configuration_max = 1.0
  serverlessv2_scaling_configuration_min = 0.5

  environment = "dev"
  project = "project-1"
  create_cluster_parameter_group = true
  family = "aurora-mysql8.0"
  create_mysql_user = true
  mysql_users = ["user1","user2"]
}