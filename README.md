# HuaweiCloud LTS Terraform Module

Terraform module which creates LTS (Log Tank Service) log groups and log streams on Huawei Cloud.

## Features

This module supports the following LTS features:

- ✅ Log group creation with configurable TTL (1-365 days)
- ✅ Multiple log streams within a log group
- ✅ Per-stream TTL configuration (inherits from group or custom)
- ✅ Enterprise project support
- ✅ Tag management (group-level and stream-level)
- ✅ Stream favorites support
- ✅ Use existing log group or create new one

## Examples

- [simple](./examples/simple) - Basic log group with a single stream
- [complete](./examples/complete) - Log group with multiple streams and advanced configuration
- [existing-group](./examples/existing-group) - Create streams in an existing log group

## Usage

### Basic Example

```hcl
module "lts" {
  source = "github.com/artifactsystems/terraform-huawei-lts?ref=v1.0.0"

  group_name  = "my-application-logs"
  ttl_in_days = 30

  log_streams = [
    {
      name        = "app-logs"
      ttl_in_days = 30
    },
    {
      name        = "error-logs"
      ttl_in_days = 90
    }
  ]

  tags = {
    Environment = "production"
    Team        = "platform"
  }
}
```

### Using Existing Log Group

```hcl
module "lts" {
  source = "github.com/artifactsystems/terraform-huawei-lts?ref=v1.0.0"

  create_log_group = false
  log_group_id     = "existing-group-id"

  log_streams = [
    {
      name = "new-stream"
    }
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| huaweicloud | >= 1.79.0 |

## Providers

| Name | Version |
|------|---------|
| huaweicloud | >= 1.79.0 |

## Resources

| Name | Type |
|------|------|
| [huaweicloud_lts_group](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/lts_group) | resource |
| [huaweicloud_lts_stream](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/lts_stream) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_log_group | Whether to create the log group | `bool` | `true` | no |
| create_log_stream | Whether to create log streams within the log group | `bool` | `true` | no |
| region | The Huawei Cloud region where resources will be created | `string` | `null` | no |
| tags | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |
| log_group_tags | Additional tags for the log group | `map(string)` | `{}` | no |
| log_stream_tags | Additional tags for all log streams | `map(string)` | `{}` | no |
| group_name | Specifies the log group name. Changing this parameter will create a new resource | `string` | n/a | yes |
| ttl_in_days | Specifies the log expiration time in days. The value is range from 1 to 365 | `number` | n/a | yes |
| enterprise_project_id | Specifies the enterprise project ID to which the log group belongs | `string` | `null` | no |
| log_group_id | The ID of an existing log group to use. If specified, create_log_group will be ignored | `string` | `null` | no |
| log_streams | List of log streams to create within the log group | `list(object)` | `[]` | no |

### log_streams Object

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The log stream name | `string` | n/a | yes |
| ttl_in_days | The log expiration time in days. Valid value is a non-zero integer from -1 to 365, defaults to -1 which means inherit the log group settings | `number` | `null` | no |
| enterprise_project_id | Specifies the enterprise project ID | `string` | `null` | no |
| is_favorite | Specifies whether to favorite the log stream | `bool` | `false` | no |
| tags | Specifies the key/value pairs of the log stream | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| log_group_id | The log group ID |
| log_group_name | The log group name |
| log_group_created_at | The creation time of the log group |
| log_group_ttl_in_days | The log expiration time in days |
| log_streams | Map of log streams created, keyed by stream name |
| log_stream_ids | Map of log stream IDs, keyed by stream name |
| log_stream_names | List of log stream names |

## Contributing

Report issues/questions/feature requests in the [issues](https://github.com/artifactsystems/terraform-huawei-lts/issues/new) section.

Full contributing [guidelines are covered here](.github/CONTRIBUTING.md).
