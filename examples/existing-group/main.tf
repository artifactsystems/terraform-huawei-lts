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
# Existing Log Group (created outside this module)
################################################################################

resource "huaweicloud_lts_group" "existing" {
  group_name  = "${local.name}-existing-group"
  ttl_in_days = 30

  tags = local.tags
}

################################################################################
# LTS Module - Using Existing Group
################################################################################

module "lts" {
  source = "../../"

  create_log_group = false
  log_group_id     = huaweicloud_lts_group.existing.id

  log_streams = [
    {
      name        = "new-stream-1"
      ttl_in_days = 15
    },
    {
      name = "new-stream-2"
    }
  ]

  tags = local.tags
}
