variable "name" {
  type        = string
  description = "A string value to describe prefix of all the resources"
  default     = ""
}

variable "create_aurora" {
  type        = bool
  description = "If you want to create Aurora MySQL or PostgreSQL enable this check"
  default     = true
}

variable "database_module" {
  type        = string
  description = "A string value to create the mysql or postgresql"
  default     = "mysql"
}

variable "default_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
  default = {
    "Scope" : "RDS"
    "CreatedBy" : "Terraform"
  }
}

variable "common_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
  default     = {}
}

variable "create_subnet_group" {
  type        = bool
  description = ""
  default     = true
}

variable "subnet_group_name" {
  type        = string
  description = ""
  default     = ""
}

variable "create_db_parameter_group" {
  type        = bool
  description = ""
  default     = true
}

variable "db_parameter_group_name" {
  type        = string
  description = ""
  default     = ""
}

variable "create_cluster_parameter_group" {
  type        = bool
  description = ""
  default     = true
}

variable "cluster_parameter_group_name" {
  type        = string
  description = ""
  default     = ""
}

variable "create_security_group" {
  type        = bool
  description = ""
  default     = true
}

variable "sg_allow_inbound_cidrs" {
  type        = list(string)
  description = ""
  default     = []
}

variable "vpc_id" {
  type        = string
  description = ""
}

variable "port" {
  type        = number
  description = "Port number for this DB (usually 3306 for MySQL and 5432 for Postgres)"
  default     = 3306
}

variable "security_group_ids" {
  type        = list(string)
  description = ""
  default     = []
}

variable "create_role" {
  type        = bool
  description = ""
  default     = true
}

variable "role_arn" {
  type        = list(string)
  description = ""
  default     = []
}

variable "subnet_ids" {
  description = "The VPC Subnet IDs to launch in"
  type        = list(string)
}

variable "parameter_family" {
  type        = string
  description = "The family of the DB parameter group for mysql(aurora-mysql5.7) or postgresql(aurora-postgresql15)"
  default     = "aurora-mysql5.7"
}

variable "engine" {
  type        = string
  description = "The name of the database engine to be used for this DB cluster for mysql(aurora-mysql, mysql) or postgresql(aurora-postgresql, postgresql)"
  default     = "aurora-mysql"
}

variable "engine_version" {
  type        = string
  description = "The name of the database engine to be used for this DB cluster for mysql(5.7.mysql_aurora.2.10.2, 5.7) or postgresql(13.6)"
  default     = "5.7.mysql_aurora.2.11.2"
}

variable "availability_zones" {
  type    = list(string)
  default = []
}

variable "database_name" {
  description = "Database Name"
  type        = string
  default     = ""
}

variable "create_username_password" {
  type        = bool
  description = ""
  default     = true
}

variable "master_username" {
  type        = string
  description = ""
  default     = "root"
}

variable "master_password" {
  type        = string
  description = ""
  default     = ""
}

variable "backup_retention_period" {
  type    = number
  default = 7
}

variable "preferred_backup_window" {
  type        = string
  description = ""
  default     = "22:00-23:00"
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  default     = false
}

variable "maintenance_window" {
  type        = string
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  default     = "Sun:21:00-Sun:22:00"
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true."
  type        = bool
  default     = true
}

variable "instance_class" {
  type        = string
  description = ""
  default     = "db.t3.medium"
}

variable "copy_tags_to_snapshot" {
  type        = bool
  description = "Copy all Cluster tags to snapshots."
  default     = true
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  description = "Set of log types to export to cloudwatch. The following log types are supported: audit, error, general, slowquery"
  default     = ["error", "slowquery"]
}

variable "role_max_session_duration" {
  type        = number
  description = ""
  default     = 3600
}

variable "publicly_accessible" {
  description = "(Optional) Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  type        = bool
  description = ""
  default     = true
}

variable "iam_database_authentication_enabled" {
  type    = bool
  default = false
}

variable "apply_immediately" {
  type        = bool
  default     = true
  description = "Apply changes immediately or wait for the maintainance window"
}

variable "kms_key_arn" {
  type        = string
  default     = ""
  description = "KMS Key ARN to use a CMK instead of default shared key, when storage_encrypted is true"
}

variable "allocated_storage" {
  type        = number
  description = "Storage size in GB"
  default     = 10
}

variable "max_allocated_storage" {
  type        = number
  description = "Argument higher than the allocated_storage to enable Storage Autoscaling, size in GB. 0 to disable Storage Autoscaling"
  default     = 20
}

variable "storage_type" {
  type        = string
  description = "The instance storage type"
  default     = "gp3"
}

variable "storage_encrypted" {
  type        = bool
  description = "Enables storage encryption"
  default     = true
}

variable "secret_method" {
  description = "Use ssm for SSM parameters store which is the default option, or secretsmanager for AWS Secrets Manager"
  type        = bool
  default     = false
}

variable "ssm_kms_key_id" {
  type        = string
  default     = ""
  description = "KMS Key Id to use a CMK instead of default shared key for SSM parameters"
}

#variable "username" {
#  type        = string
#  description = "DB User"
#}
#
#variable "create_rds" {
#  type        = bool
#  description = "If you want to create rds MySQL or PostgreSQL enable this check"
#  default     = true
#}
#
#variable "project" {
#  description = "A string value to describe prefix of all the resources"
#  type        = string
#  default     = ""
#}
#
#variable "identifier" {
#  type        = string
#  default     = "database"
#  description = "Optional identifier for DB. If not passed, {environment}-{name} will be used"
#}
#
#variable "snapshot_identifier" {
#  type        = string
#  default     = ""
#  description = "Pass a snapshot identifier for the database to be created from this snapshot"
#}
#
#variable "final_snapshot_identifier" {
#  type        = string
#  default     = ""
#  description = "Pass the final snapshot identifier for the final snapshot to be created after the database is destroyed."
#}
#
#variable "count_aurora_instances" {
#  description = "Number of Aurora Instances"
#  type        = number
#  default     = "1"
#}
#
#variable "serverlessv2_scaling_configuration_max" {
#  description = "Number of Aurora Instances"
#  type        = number
#  default     = "1.0"
#}
#
#variable "serverlessv2_scaling_configuration_min" {
#  description = "Number of Aurora Instances"
#  type        = number
#  default     = "0.5"
#}
#
#variable "db_subnet_group_id" {
#  description = "RDS Subnet Group Name"
#  type        = string
#  default     = ""
#}
#

#

#
#variable "environment" {
#  type        = string
#  default     = "dev"
#  description = "description"
#}
#
#variable "mysql_users" {
#  type = list(string)
#  default = [""]
#}
