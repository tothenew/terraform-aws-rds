

#resource "aws_db_subnet_group" "rds_subnet_group" {
#  name       = "${var.environment}-${local.identifier}-subnet_group"
#  subnet_ids = var.subnet_ids
#  tags = {
#    Name = "${var.environment}-${local.identifier}-subnet_group"
#  }
#}

#resource "aws_db_instance" "rds_db" {
#  count                      = var.create_rds && !var.create_aurora ? 1 : 0
#  publicly_accessible        = var.publicly_accessible
#  allocated_storage          = var.allocated_storage
#  max_allocated_storage      = var.max_allocated_storage
#  storage_type               = var.storage_type
#  iops                       = var.iops
#  engine                     = var.engine
#  engine_version             = var.engine_version
#  snapshot_identifier        = var.snapshot_identifier != "" ? var.snapshot_identifier : null
#  identifier                 = "${var.environment}-${local.identifier}"
#  instance_class             = var.instance_class
#  db_name                    = var.database_name
#  backup_retention_period    = var.retention
#  username                   = var.username
#  password                   = random_string.rds_db_password.result
#  db_subnet_group_name       = aws_db_subnet_group.rds_subnet_group.name
#  vpc_security_group_ids     = [aws_security_group.security_group.id]
#  apply_immediately          = var.apply_immediately
#  multi_az                   = var.multi_az
#  storage_encrypted          = var.storage_encrypted
#  deletion_protection        = var.deletion_protection
#  maintenance_window         = var.maintenance_window
#  backup_window              = var.backup_window
#  skip_final_snapshot        = var.skip_final_snapshot
#  final_snapshot_identifier  = var.final_snapshot_identifier == "" ? "${var.environment}-${local.identifier}-final-snapshot" : var.final_snapshot_identifier
#  auto_minor_version_upgrade = var.auto_minor_version_upgrade
#  parameter_group_name       = var.create_db_parameter_group == true ? aws_db_parameter_group.rds_custom_db_pg[count.index].name : ""
#
#}

#resource "aws_rds_cluster" "aurora_cluster" {
#  count                               = !var.create_rds && var.create_aurora ? 1 : 0
#  cluster_identifier                  = "${var.environment}-${local.identifier}"
#  engine                              = var.engine
#  engine_version                      = var.engine_version
#  database_name                       = var.database_name
#  master_username                     = var.username
#  master_password                     = random_string.rds_db_password.result
#  snapshot_identifier                 = var.snapshot_identifier != "" ? var.snapshot_identifier : null
#  backup_retention_period             = var.retention
#  db_subnet_group_name                = aws_db_subnet_group.rds_subnet_group.name
#  iam_database_authentication_enabled = var.iam_database_authentication_enabled
#  final_snapshot_identifier           = var.final_snapshot_identifier == "" ? "${var.environment}-${local.identifier}-final-snapshot" : var.final_snapshot_identifier
#  skip_final_snapshot                 = var.skip_final_snapshot
#  vpc_security_group_ids              = [aws_security_group.security_group.id]
#  apply_immediately                   = var.apply_immediately
#  serverlessv2_scaling_configuration {
#    max_capacity = var.serverlessv2_scaling_configuration_max
#    min_capacity = var.serverlessv2_scaling_configuration_min
#  }
#  db_cluster_parameter_group_name = var.create_cluster_parameter_group == true ? aws_rds_cluster_parameter_group.custom_cluster_pg[count.index].name : ""
#}
#
#resource "aws_rds_cluster_instance" "cluster_instances" {
#  count               = var.create_aurora == true ? var.count_aurora_instances : 0
#  identifier          = "${var.environment}-${local.identifier}-${count.index}"
#  cluster_identifier  = aws_rds_cluster.aurora_cluster[0].id
#  instance_class      = var.instance_class
#  engine              = aws_rds_cluster.aurora_cluster[0].engine
#  engine_version      = aws_rds_cluster.aurora_cluster[0].engine_version
#  publicly_accessible = var.publicly_accessible
#}
#
#resource "aws_rds_cluster_parameter_group" "custom_cluster_pg" {
#  count = var.create_cluster_parameter_group ? 1 : 0
#
#  name        = var.parameter_group_name == "" ? "${var.environment}-${local.identifier}-cluster-parameter-group" : var.parameter_group_name
#  description = "RDS ${var.environment}-${local.identifier} cluster parameter group"
#  family      = var.family
#  lifecycle {
#    create_before_destroy = true
#  }
#}
#
#resource "aws_db_parameter_group" "rds_custom_db_pg" {
#  count = var.create_db_parameter_group ? 1 : 0
#
#  name        = var.parameter_group_name == "" ? "${var.environment}-${local.identifier}-parameter-group" : var.parameter_group_name
#  description = "RDS ${var.environment}-${local.identifier} parameter group"
#  family      = var.family
#
#  lifecycle {
#    create_before_destroy = true
#  }
#}