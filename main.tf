resource "random_string" "rds_db_password" {
  length  = 34
  special = false
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = var.db_subnet_group_id
  subnet_ids = var.subnet_ids
  tags = {
    Name = var.db_subnet_group_id
  }
}

resource "aws_db_instance" "rds_db" {
  count                           = var.create_rds && !var.create_aurora ? 1 : 0
  publicly_accessible             = var.publicly_accessible
  allocated_storage               = var.allocated_storage
  max_allocated_storage           = var.max_allocated_storage
  storage_type                    = var.storage_type
  iops                            = var.iops
  engine                          = var.engine
  engine_version                  = var.engine_version
  snapshot_identifier             = var.snapshot_identifier != "" ? var.snapshot_identifier : null
  identifier                      = var.identifier == "" ? "${var.project_name_prefix}" : var.identifier
  instance_class                  = var.instance_class
  db_name                         = var.database_name
  backup_retention_period         = var.retention
  username                        = var.username
  password                        = random_string.rds_db_password.result
  db_subnet_group_name            = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids          = [aws_security_group.rds_db.id]
  apply_immediately               = var.apply_immediately
  kms_key_id                      = var.kms_key_arn
  multi_az                        = var.multi_az
  storage_encrypted               = var.storage_encrypted
  deletion_protection             = var.deletion_protection
  maintenance_window              = var.maintenance_window
  backup_window                   = var.backup_window
  skip_final_snapshot             = var.skip_final_snapshot
  final_snapshot_identifier       = var.final_snapshot_identifier == "" ? "${var.project_name_prefix}-final-snapshot" : var.final_snapshot_identifier
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade

}

resource "aws_rds_cluster" "aurora_cluster" {
  count                               = !var.create_rds && var.create_aurora ? 1 : 0
  cluster_identifier                  = var.identifier == "" ? "${var.project_name_prefix}" : var.identifier
  engine                              = var.engine
  engine_version                      = var.engine_version
  database_name                       = var.database_name
  master_username                     = var.username
  master_password                     = random_string.rds_db_password.result
  snapshot_identifier                 = var.snapshot_identifier != "" ? var.snapshot_identifier : null
  backup_retention_period             = var.retention
  db_subnet_group_name                = aws_db_subnet_group.rds_subnet_group.name
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  final_snapshot_identifier       = var.final_snapshot_identifier == "" ? "${var.project_name_prefix}-final-snapshot" : var.final_snapshot_identifier
  skip_final_snapshot             = var.skip_final_snapshot
  vpc_security_group_ids              = [aws_security_group.rds_db.id]
  apply_immediately                   = var.apply_immediately
#   serverlessv2_scaling_configuration {
#     max_capacity = var.serverlessv2_scaling_configuration_max
#     min_capacity = var.serverlessv2_scaling_configuration_min
#   }
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count                   = var.create_aurora == true ? var.count_aurora_instances : 0
  identifier              = var.identifier == "" ? "${var.project_name_prefix}-${count.index}" : "${var.identifier}-${count.index}"
  cluster_identifier      = aws_rds_cluster.aurora_cluster[0].id
  instance_class          = var.instance_class
  engine                  = aws_rds_cluster.aurora_cluster[0].engine
  engine_version          = aws_rds_cluster.aurora_cluster[0].engine_version
  publicly_accessible     = var.publicly_accessible
}
