output "log_group_id" {
  description = "The log group ID"
  value       = module.lts.log_group_id
}

output "log_group_name" {
  description = "The log group name"
  value       = module.lts.log_group_name
}

output "log_streams" {
  description = "Map of log streams"
  value       = module.lts.log_streams
}

