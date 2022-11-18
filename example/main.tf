module "create_database" {
  source = "../"
  #source              = "git::https://github.com/tothenew/terraform-aws-rds.git"
  create_rds     = false
  create_aurora = true

  security_groups  = ["sg-99999999999999999"]
  subnet_ids          = ["subnet-99999999999999999","subnet-66666666666666666"]

  publicly_accessible = true
  allocated_storage = 10
  max_allocated_storage = 20
  engine = "aurora-postgresql"
  engine_version = "13.6"
  instance_class = "db.serverless"
  database_name = "mydb"
  username   = "root"
  identifier = "dev-tothenew-database"
  apply_immediately = false
  storage_encrypted = false
  kms_key_arn = "tothenew"
  multi_az = false
  db_subnet_group_id = "tothenew-subnet-group"
  deletion_protection = false
  auto_minor_version_upgrade = false
  count_aurora_instances = 1
  serverlessv2_scaling_configuration_max = 1.0
  serverlessv2_scaling_configuration_min = 0.5

  common_tags = {
    "Project"     = "ToTheNew",
    "Environment" = "dev"
  }
  environment = "dev"
  project_name_prefix = "dev-tothenew"
}
