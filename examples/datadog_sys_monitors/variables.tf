# renotify interval
variable "renotify_interval" {
  description = "Interval for renotification if monitor is in triggered state."
  default     = 90
  type        = number
}

# New Host Delay
variable "new_host_delay" {
  description = "Delay evaluation for new host."
  default     = 300
  type        = number
}

# No data timeframe
variable "no_data_timeframe" {
  description = "Timeframe for no dfata notification."
  default     = 20
  type        = number
}

# No data notification
variable "notify_no_data" {
  description = "No data notification."
  default     = true
  type        = bool
}

# Audit notification
variable "notify_audit" {
  description = "Set true to get notification on monitor modification."
  default     = false
  type        = bool
}

# Full window evaluation
variable "require_full_window" {
  description = "Option for setting full window evaluation for datadog monitor."
  default     = true
  type        = bool
}

# Include tags in monitor title while triggering
variable "include_tags" {
  description = "Option for setting up tag inclusion in monitor title while triggering."
  default     = true
  type        = bool
}

variable "datadog_api_key" {
  description = "variable declaration for datadog api key"
  default     = ""
  type        = string
}

variable "datadog_app_key" {
  description = "variable declaration for datadog app key"
  default     = ""
  type        = string  
}