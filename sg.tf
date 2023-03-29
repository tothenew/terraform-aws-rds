resource "aws_security_group" "rds_db" {
  name   = "${var.environment}-${local.identifier}-rds-sg"
  vpc_id = var.vpc_id
  
  ingress {
    from_port        = var.port
    to_port          = var.port
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "${var.environment}-${local.identifier}-rds-sg"
  }
}
