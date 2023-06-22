resource "aws_iam_role" "aws_role" {
  count                = var.create_role ? 1 : 0
  name                 = "${local.project_name_prefix}-role"
  description          = "Role for RDS"
  max_session_duration = var.role_max_session_duration
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "rds.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF

  tags = merge(local.common_tags, { "Name" = "${local.project_name_prefix}-role" })
}
