resource "aws_kms_key" "kms_key" {
  count       = var.storage_encrypted ? 1 : 0
  description = "KMS key for RDS"
  tags        = merge(local.common_tags, tomap({ "Name" : "${local.project_name_prefix}-kms" }))
}