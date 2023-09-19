# Access Grant

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_storj"></a> [storj](#requirement\_storj) | 0.0.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_storj"></a> [storj](#provider\_storj) | 0.0.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [storj_access_grant.this](https://registry.terraform.io/providers/storj/storj/0.0.1/docs/resources/access_grant) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_grant"></a> [access\_grant](#input\_access\_grant) | The root access grant that we should derive the new access grant from. | `string` | n/a | yes |
| <a name="input_bucket"></a> [bucket](#input\_bucket) | The list of buckets and associated prefixes the derived access grant should allow access to. | <pre>set(object({<br>    name  = string<br>    paths = set(string)<br>  }))</pre> | n/a | yes |
| <a name="input_allow_delete"></a> [allow\_delete](#input\_allow\_delete) | Allow deletes to occur when using the derived grant. | `bool` | `false` | no |
| <a name="input_allow_download"></a> [allow\_download](#input\_allow\_download) | Allow downloads to occur when using the derived grant. | `bool` | `false` | no |
| <a name="input_allow_list"></a> [allow\_list](#input\_allow\_list) | Allow list operations to occur when using the derived grant. | `bool` | `false` | no |
| <a name="input_allow_upload"></a> [allow\_upload](#input\_allow\_upload) | Allow uploads to occur when using the derived grant. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_derived_access_grant"></a> [derived\_access\_grant](#output\_derived\_access\_grant) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
