################################################################################
# General
################################################################################

variable "create_log_group" {
  description = "Whether to create the log group"
  type        = bool
  default     = true
}

variable "create_log_stream" {
  description = "Whether to create log streams within the log group"
  type        = bool
  default     = true
}

variable "region" {
  description = "(Optional, ForceNew) Specifies the region in which to create the log group/stream resources. If omitted, the provider-level region will be used. Changing this parameter will create a new resource"
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "log_group_tags" {
  description = "Additional tags for the log group"
  type        = map(string)
  default     = {}
}

variable "log_stream_tags" {
  description = "Additional tags for all log streams"
  type        = map(string)
  default     = {}
}

################################################################################
# Log Group
################################################################################

variable "group_name" {
  description = "(Required when create_log_group=true, Optional otherwise, ForceNew) Specifies the log group name. Changing this parameter will create a new resource"
  type        = string
  default     = null
}

variable "ttl_in_days" {
  description = "(Required when create_log_group=true, Optional otherwise) Specifies the log expiration time in days. The value is range from 1 to 365"
  type        = number
  default     = null
  validation {
    condition     = var.ttl_in_days == null || (var.ttl_in_days >= 1 && var.ttl_in_days <= 365)
    error_message = "ttl_in_days must be between 1 and 365"
  }
}

variable "enterprise_project_id" {
  description = "(Optional, ForceNew) Specifies the enterprise project ID to which the log group belongs. Changing this parameter will create a new resource. This parameter is valid only when the enterprise project function is enabled, if omitted, default enterprise project will be used"
  type        = string
  default     = null
}

variable "log_group_id" {
  description = "The ID of an existing log group to use. If specified, create_log_group will be ignored and log streams will be created in this group"
  type        = string
  default     = null
}

################################################################################
# Log Streams
################################################################################

variable "log_streams" {
  description = <<-EOF
    List of log streams to create within the log group. Each stream can have its own configuration.

    Example:
    [
      {
        name  = "application-logs"
        ttl_in_days = 30
        is_favorite = true
      },
      {
        name  = "error-logs"
        ttl_in_days = 90
      },
      {
        name = "inherit-logs"
        # ttl_in_days not specified, will inherit from group (default -1)
      }
    ]
  EOF
  type = list(object({
    name                  = string
    ttl_in_days           = optional(number, null)
    enterprise_project_id = optional(string, null)
    is_favorite           = optional(bool, false)
    tags                  = optional(map(string), {})
  }))
  default = []
}

