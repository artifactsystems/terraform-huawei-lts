output "log_group_id" {
  description = "The log group ID"
  value       = module.lts.log_group_id
}

output "log_group_name" {
  description = "The log group name"
  value       = module.lts.log_group_name
}

output "log_group_created_at" {
  description = "The creation time of the log group"
  value       = module.lts.log_group_created_at
}

output "log_streams" {
  description = "Map of log streams created"
  value       = module.lts.log_streams
}

output "log_stream_ids" {
  description = "Map of log stream IDs"
  value       = module.lts.log_stream_ids
}

output "log_stream_names" {
  description = "List of log stream names"
  value       = module.lts.log_stream_names
}

