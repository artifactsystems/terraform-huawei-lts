locals {
  create_log_group  = var.create_log_group
  create_log_stream = var.create_log_stream && length(var.log_streams) > 0

  # Log group ID - use provided or created
  log_group_id = try(huaweicloud_lts_group.this[0].id, var.log_group_id)
}

################################################################################
# Log Group
################################################################################

resource "huaweicloud_lts_group" "this" {
  count = local.create_log_group ? 1 : 0

  region                = var.region
  group_name            = var.group_name
  ttl_in_days           = var.ttl_in_days
  enterprise_project_id = var.enterprise_project_id

  tags = merge(
    var.tags,
    var.log_group_tags,
    { "Name" = var.group_name },
  )
}

################################################################################
# Log Streams
################################################################################

resource "huaweicloud_lts_stream" "this" {
  for_each = local.create_log_stream ? { for stream in var.log_streams : stream.name => stream } : {}

  region                = var.region
  group_id              = local.log_group_id
  stream_name           = each.value.name
  ttl_in_days           = try(each.value.ttl_in_days, null)
  enterprise_project_id = try(each.value.enterprise_project_id, var.enterprise_project_id)
  is_favorite           = try(each.value.is_favorite, false)

  tags = merge(
    var.tags,
    try(each.value.tags, {}),
    var.log_stream_tags,
    { "Name" = each.value.name },
  )
}

