variable "publicly_accessible" {
  description = "(Optional) Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
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
  default     = "gp2"
}

variable "iops" {
  type        = number
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of io1"
  default     = null
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type    = string
  default = ""
}

variable "instance_class" {
  type = string
}

variable "database_name" {
  description = "Database Name"
  type        = string
  default     = "mydb"
}

variable "retention" {
  type        = number
  description = "Snapshot retention period in days"
  default = 30
}

variable "username" {
  type        = string
  description = "DB User"
}

variable "apply_immediately" {
  type        = bool
  default     = false
  description = "Apply changes immediately or wait for the maintainance window"
}

variable "subnet_ids" {
  description = "The VPC Subnet IDs to launch in"
  type        = list(string)
}

variable "kms_key_arn" {
  type        = string
  default     = ""
  description = "KMS Key ARN to use a CMK instead of default shared key, when storage_encrypted is true"
}

variable "storage_encrypted" {
  type        = bool
  description = "Enables storage encryption"
  default = false
}

variable "multi_az" {
  description = "Deploy multi-az instance database"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true."
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  default     = false
}

variable "maintenance_window" {
  type        = string
  description = "(RDS Only) The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  default     = "Sun:04:00-Sun:05:00"
}

variable "backup_window" {
  description = "(RDS Only) The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
  default     = "03:00-03:30"
}

variable "iam_database_authentication_enabled" {
  type    = bool
  default = false
}

variable "create_aurora" {
  type        = bool
  description = "If you want to create Aurora MySQL or PostgreSQL enable this check"
  default     = true
}

variable "create_rds" {
  type        = bool
  description = "If you want to create rds MySQL or PostgreSQL enable this check"
  default     = true
}

variable "project" {
  description = "A string value to describe prefix of all the resources"
  type        = string
  default = ""
}

variable "identifier" {
  type        = string
  default     = "database"
  description = "Optional identifier for DB. If not passed, {environment}-{name} will be used"
}

variable "snapshot_identifier" {
  type        = string
  default     = ""
  description = "Pass a snapshot identifier for the database to be created from this snapshot"
}

variable "final_snapshot_identifier" {
  type        = string
  default     = ""
  description = "Pass the final snapshot identifier for the final snapshot to be created after the database is destroyed."
}

variable "count_aurora_instances" {
  description = "Number of Aurora Instances"
  type        = number
  default     = "1"
}

variable "serverlessv2_scaling_configuration_max" {
  description = "Number of Aurora Instances"
  type        = number
  default     = "1.0"
}

variable "serverlessv2_scaling_configuration_min" {
  description = "Number of Aurora Instances"
  type        = number
  default     = "0.5"
}

variable "db_subnet_group_id" {
  description = "RDS Subnet Group Name"
  type        = string
  default = ""
}

variable "skip_final_snapshot" {
  type        = bool
  default     = true
}

variable "secret_method" {
  description = "Use ssm for SSM parameters store which is the default option, or secretsmanager for AWS Secrets Manager"
  type        = string
  default     = "ssm"
}

variable "ssm_kms_key_id" {
  type        = string
  default     = ""
  description = "KMS Key Id to use a CMK instead of default shared key for SSM parameters"
}

variable environment {
  type        = string
  default     = "dev"
  description = "description"
}

variable "common_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
  default = {}
}

variable "port" {
  type = number
  default = 3306
  description = "Port number for this DB (usually 3306 for MySQL and 5432 for Postgres)"
}

variable "vpc_cidr" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "mysql_users" {
  type = list(string)
  default = [""]
}

variable "create_mysql_user" {
  type        = bool
  description = "If you want to create rds MySQL or PostgreSQL enable this check"
  default     = false
}

variable "family" {
  type        = string
  description = "Parameter group family"
  default     = ""
}

variable "parameter_group_name" {
  type        = string
  default     = ""
}

variable "create_db_parameter_group" {
  type      = bool
  default   = false
}

variable "create_cluster_parameter_group" {
  type      = bool
  default   = false
}