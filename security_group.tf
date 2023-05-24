resource "aws_security_group" "security_group" {
  count  = var.create_security_group ? 1 : 0
  name   = "${local.project_name_prefix}-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = length(var.sg_allow_inbound_cidrs) == 0 ? [for s in data.aws_subnet.target : s.cidr_block] : var.sg_allow_inbound_cidrs
  }

  tags = merge(local.common_tags, tomap({ "Name" : "${local.project_name_prefix}-sg" }))
}
