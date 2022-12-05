resource "aws_security_group" "rds_db" {
  name   = "rds-${var.environment}-${var.database_name}"
  vpc_id = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "rds-${var.environment}-${var.database_name}"
  }
}

resource "aws_security_group_rule" "ingress_rule" {
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  cidr_blocks       = var.vpc_cidr
  security_group_id = aws_security_group.rds_db.id
}

resource "aws_security_group_rule" "egress_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.rds_db.id
  cidr_blocks       = ["0.0.0.0/0"]
}