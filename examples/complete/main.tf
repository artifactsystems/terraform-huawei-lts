provider "huaweicloud" {
  region = local.region
}

locals {
  name   = "ex-${basename(path.cwd)}"
  region = "tr-west-1"

  tags = {
    Name       = local.name
    Example    = local.name
    GithubRepo = "terraform-huawei-lts"
    GithubOrg  = "artifactsystems"
  }
}

################################################################################
# LTS Module - Complete Example
################################################################################

module "lts" {
  source = "../../"

  group_name            = "${local.name}-logs"
  ttl_in_days           = 90
  enterprise_project_id = null # Set if you have enterprise projects enabled

  log_streams = [
    {
      name        = "application-logs"
      ttl_in_days = 30
      is_favorite = true
      tags = {
        Type = "application"
      }
    },
    {
      name        = "error-logs"
      ttl_in_days = 90
      is_favorite = true
      tags = {
        Type      = "error"
        Alert     = "enabled"
        Retention = "extended"
      }
    },
    {
      name        = "access-logs"
      ttl_in_days = 7
      tags = {
        Type = "access"
      }
    },
    {
      name = "audit-logs"
      # ttl_in_days not specified, will inherit from group (90 days)
      tags = {
        Type       = "audit"
        Compliance = "required"
      }
    }
  ]

  tags = local.tags

  log_group_tags = {
    Purpose = "centralized-logging"
  }

  log_stream_tags = {
    ManagedBy = "terraform"
  }
}
