resource "random_string" "unique_string" {
  length  = 6
  special = false
  upper   = false
}

resource "random_string" "rds_db_password" {
  count   = var.create_username_password ? 1 : 0
  length  = 16
  special = false
}

resource "aws_db_subnet_group" "subnet_group" {
  count      = var.create_subnet_group ? 1 : 0
  name       = "${local.project_name_prefix}-sg"
  subnet_ids = var.subnet_ids
  tags       = merge(local.common_tags, tomap({ "Name" : "${local.project_name_prefix}-sg" }))
}

resource "aws_rds_cluster_parameter_group" "cluster_parameter_group" {
  count  = var.create_cluster_parameter_group && var.create_aurora ? 1 : 0
  name   = "${local.project_name_prefix}-cluster-pg"
  family = var.parameter_family
  tags   = merge(local.common_tags, tomap({ "Name" : "${local.project_name_prefix}-cluster-pg" }))
}

resource "aws_db_parameter_group" "parameter_group" {
  count  = var.create_db_parameter_group ? 1 : 0
  name   = "${local.project_name_prefix}-pg"
  family = var.parameter_family
  tags   = merge(local.common_tags, tomap({ "Name" : "${local.project_name_prefix}-pg" }))
}

resource "aws_rds_cluster" "rds_cluster" {
  count                               = var.create_aurora ? 1 : 0
  cluster_identifier                  = local.project_name_prefix
  engine                              = var.engine
  engine_version                      = var.engine_version
  availability_zones                  = var.availability_zones
  database_name                       = var.database_name == "" ? local.default_database_name : var.database_name
  master_username                     = var.master_username
  master_password                     = var.create_username_password ? random_string.rds_db_password[0].result : var.master_password
  backup_retention_period             = var.backup_retention_period
  deletion_protection                 = var.deletion_protection
  db_subnet_group_name                = var.create_subnet_group ? aws_db_subnet_group.subnet_group[0].name : var.subnet_group_name
  iam_roles                           = var.create_role ? [aws_iam_role.aws_role[0].arn] : var.role_arn
  vpc_security_group_ids              = var.create_security_group ? [aws_security_group.security_group[0].id] : var.security_group_ids
  skip_final_snapshot                 = var.skip_final_snapshot
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  storage_encrypted                   = var.storage_encrypted
  kms_key_id                          = var.storage_encrypted ? aws_kms_key.kms_key[0].arn : null
  preferred_backup_window             = var.preferred_backup_window
  preferred_maintenance_window        = var.maintenance_window
  db_cluster_parameter_group_name     = var.create_cluster_parameter_group ? aws_rds_cluster_parameter_group.cluster_parameter_group[0].name : var.cluster_parameter_group_name
  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports
  port                                = var.port
  apply_immediately                   = var.apply_immediately
  tags                                = merge(local.common_tags, tomap({ "Name" : local.project_name_prefix }))
}

resource "aws_rds_cluster_instance" "rds_cluster_instance" {
  count                        = var.create_aurora ? 1 : 0
  identifier                   = local.project_name_prefix
  cluster_identifier           = aws_rds_cluster.rds_cluster[0].cluster_identifier
  engine                       = aws_rds_cluster.rds_cluster[0].engine
  engine_version               = aws_rds_cluster.rds_cluster[0].engine_version
  db_subnet_group_name         = aws_rds_cluster.rds_cluster[0].db_subnet_group_name
  db_parameter_group_name      = var.create_db_parameter_group ? aws_db_parameter_group.parameter_group[0].name : var.db_parameter_group_name
  instance_class               = var.instance_class
  preferred_maintenance_window = var.maintenance_window
  apply_immediately            = var.apply_immediately
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  publicly_accessible          = var.publicly_accessible
  tags                         = merge(local.common_tags, tomap({ "Name" : local.project_name_prefix }))
}

resource "aws_rds_cluster_instance" "read_replica" {
  count                           = var.create_aurora && var.read_replica ? 1 : 0
  identifier                      = "${local.project_name_prefix}-read-replica"
  cluster_identifier              = aws_rds_cluster.rds_cluster[0].cluster_identifier
  engine                          = var.engine
  engine_version                  = var.engine_version
  instance_class                  = var.instance_class
  publicly_accessible             = var.publicly_accessible
  db_subnet_group_name            = aws_rds_cluster.rds_cluster[0].db_subnet_group_name
  db_parameter_group_name         = var.create_db_parameter_group ? aws_db_parameter_group.parameter_group[0].name : var.db_parameter_group_name
  preferred_maintenance_window    = var.maintenance_window
  apply_immediately               = var.apply_immediately
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  tags                            = merge(local.common_tags, tomap({ "Name" : "${local.project_name_prefix}-read-replica" }))
}


resource "aws_db_instance" "rds_instance" {
  count                      = var.create_aurora ? 0 : 1
  publicly_accessible        = var.publicly_accessible
  allocated_storage          = var.allocated_storage
  max_allocated_storage      = var.max_allocated_storage
  storage_type               = var.storage_type
  engine                     = var.engine
  engine_version             = var.engine_version
  identifier                 = local.project_name_prefix
  instance_class             = var.instance_class
  db_name                    = var.database_name == "" ? local.default_database_name : var.database_name
  backup_retention_period    = var.backup_retention_period
  username                   = var.master_username
  password                   = var.create_username_password ? random_string.rds_db_password[0].result : var.master_password
  db_subnet_group_name       = var.create_subnet_group ? aws_db_subnet_group.subnet_group[0].name : var.subnet_group_name
  vpc_security_group_ids     = var.create_security_group ? [aws_security_group.security_group[0].id] : var.security_group_ids
  apply_immediately          = var.apply_immediately
  storage_encrypted          = var.storage_encrypted
  kms_key_id                 = var.storage_encrypted ? aws_kms_key.kms_key[0].arn : null
  deletion_protection        = var.deletion_protection
  maintenance_window         = var.maintenance_window
  backup_window              = var.preferred_backup_window
  skip_final_snapshot        = var.skip_final_snapshot
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  parameter_group_name       = var.create_db_parameter_group ? aws_db_parameter_group.parameter_group[0].name : var.db_parameter_group_name
  multi_az                   = var.multi_az
}

resource "aws_db_instance" "read_replica" {
  count                      = var.create_aurora == false && var.read_replica == true ? 1 : 0
  publicly_accessible        = var.publicly_accessible
  allocated_storage          = var.allocated_storage
  max_allocated_storage      = var.max_allocated_storage
  storage_type               = var.storage_type
  engine                     = var.engine
  engine_version             = var.engine_version
  identifier                 = "${local.project_name_prefix}-read-replica"
  instance_class             = var.instance_class
  db_subnet_group_name       = var.create_subnet_group ? aws_db_subnet_group.subnet_group[0].name : var.subnet_group_name
  vpc_security_group_ids     = var.create_security_group ? [aws_security_group.security_group[0].id] : var.security_group_ids
  apply_immediately          = var.apply_immediately
  storage_encrypted          = var.storage_encrypted
  kms_key_id                 = var.storage_encrypted ? aws_kms_key.kms_key[0].arn : null
  deletion_protection        = var.deletion_protection
  maintenance_window         = var.maintenance_window
  backup_window              = var.preferred_backup_window
  skip_final_snapshot        = var.skip_final_snapshot
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  parameter_group_name       = var.create_db_parameter_group ? aws_db_parameter_group.parameter_group[0].name : var.db_parameter_group_name

  multi_az                   = var.multi_az
  replicate_source_db        = aws_db_instance.rds_instance[0].arn

  tags = {
    Name = "${local.project_name_prefix}-read-replica"
  }
}
