output "existing_log_group_id" {
  description = "The existing log group ID"
  value       = huaweicloud_lts_group.existing.id
}

output "log_group_id" {
  description = "The log group ID (same as existing)"
  value       = module.lts.log_group_id
}

output "log_streams" {
  description = "Map of log streams created in existing group"
  value       = module.lts.log_streams
}

