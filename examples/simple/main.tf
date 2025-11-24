provider "huaweicloud" {
  region = local.region
}

locals {
  name   = "simple-lts"
  region = "tr-west-1"

  tags = {
    Name    = local.name
    Example = local.name
  }
}

################################################################################
# LTS Module - Simple Example
################################################################################

module "lts" {
  source = "../../"

  group_name  = "${local.name}-logs"
  ttl_in_days = 30

  log_streams = [
    {
      name = "application-logs"
    }
  ]

  tags = local.tags
}

