# terraform-aws-rds

[![Lint Status](https://github.com/tothenew/terraform-aws-template/workflows/Lint/badge.svg)](https://github.com/tothenew/terraform-aws-template/actions)
[![LICENSE](https://img.shields.io/github/license/tothenew/terraform-aws-template)](https://github.com/tothenew/terraform-aws-template/blob/master/LICENSE)

This is the RDS module which will create the RDS Aurora of MySql or Postgres.
The following resources will be created:
- MySql Aurora Cluster
- Subnet Group
- Instance Parameter Group
- Cluster Parameter Group

## Usages
```
module "mysql_database" {
  source = "git::https://github.com/tothenew/terraform-aws-rds.git"

  subnet_ids = ["subnet-7c16341b", "subnet-b2b59c9c"]
  vpc_id     = "vpc-855826ff"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Authors

Module managed by [TO THE NEW Pvt. Ltd.](https://github.com/tothenew)

## License

Apache 2 Licensed. See [LICENSE](https://github.com/tothenew/terraform-aws-template/blob/main/LICENSE) for full details.