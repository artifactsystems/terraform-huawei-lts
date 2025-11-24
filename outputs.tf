################################################################################
# Log Group
################################################################################

output "log_group_id" {
  description = "The log group ID"
  value       = try(huaweicloud_lts_group.this[0].id, var.log_group_id)
}

output "log_group_name" {
  description = "The log group name"
  value       = try(huaweicloud_lts_group.this[0].group_name, null)
}

output "log_group_created_at" {
  description = "The creation time of the log group"
  value       = try(huaweicloud_lts_group.this[0].created_at, null)
}

output "log_group_ttl_in_days" {
  description = "The log expiration time in days"
  value       = try(huaweicloud_lts_group.this[0].ttl_in_days, null)
}

################################################################################
# Log Streams
################################################################################

output "log_streams" {
  description = "Map of log streams created, keyed by stream name"
  value = {
    for name, stream in huaweicloud_lts_stream.this : name => {
      id           = stream.id
      name         = stream.stream_name
      group_id     = stream.group_id
      filter_count = stream.filter_count
      created_at   = stream.created_at
    }
  }
}

output "log_stream_ids" {
  description = "Map of log stream IDs, keyed by stream name"
  value = {
    for name, stream in huaweicloud_lts_stream.this : name => stream.id
  }
}

output "log_stream_names" {
  description = "List of log stream names"
  value       = [for stream in huaweicloud_lts_stream.this : stream.stream_name]
}

