data "aws_subnet" "target" {
  for_each = toset(var.subnet_ids)
  id       = each.value
}