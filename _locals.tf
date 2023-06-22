locals {
  project_name_prefix = var.name == "" ? "${terraform.workspace}-${var.database_module}-${random_string.unique_string.result}" : "${var.name}-${var.database_module}-${random_string.unique_string.result}"
  common_tags         = length(var.common_tags) == 0 ? var.default_tags : merge(var.default_tags, var.common_tags)

  default_database_name = var.name == "" ? "${terraform.workspace}${var.database_module}" : "${var.name}${var.database_module}"

  today        = timestamp()
  current_day  = formatdate("YYYYMMDD", local.today)
  current_time = formatdate("hhmmss", local.today)
}