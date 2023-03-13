locals {
  project = "${var.project}"
  identifier = "${var.identifier}-${random_string.unique_string.result}"
  today   = timestamp()
  current_day        = formatdate("YYYYMMDD", local.today)
  current_time       = formatdate("hhmmss", local.today)
}