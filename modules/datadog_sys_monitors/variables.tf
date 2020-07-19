# variables defining queries for monitors
variable "disk_usage" {
  description     = "Variables for setting up values for disk monitor. Queries will go here."  
  default         = {
    query_free    = "avg:system.disk.free"
    query_total   = "avg:system.disk.total"
  }
  type            = map
}

variable "cpu_usage" {
  description = "Variables for setting up values for cpu monitor. Queries will go here." 
  default     = {
    query     = "avg:system.cpu.idle"
  }
  type        = map 
}

variable "load" {
  description = "Variables for setting up values for load monitor. Queries will go here." 
  default     = {
    query     = "avg:system.load.norm.5"
  }
  type        = map 
}


variable "mem_usage" {
  description     = "Variables for setting up values for mem monitor. Queries will go here."  
  default         = {
    query_used    = "avg:system.mem.used"
    query_total   = "avg:system.mem.total"
  }
  type            = map
}


# Name of monitors as dictionary
variable "monitors_name" {
  description = "Name of monitors.(looping through this dict)"
  default     = ["CPU usage is high on Host: {{host.name}}, ENV: {{host.Environment}}",  "DISK usage is high on Host: {{host.name}}, ENV: {{host.Environment}}",  "Load is high on Host: {{host.name}}, ENV: {{host.Environment}}",  "Memory usage is high on Host: {{host.name}}, ENV: {{host.Environment}}"]
  type        = list(string)  
}

#Monitor type
variable "monitor_type" {
  description = "Defining monitor type"  
  default     = ["query alert", "query alert", "query alert", "query alert"]
  type        = list(string)
}

#Message to add in monitors
variable "monitor_message" {
  description = "Initial message to add in monitor"
  default     = ["CPU usage high: {{value}}", "DISK usage high: {{value}}", "Load is high: {{value}}", "Mem usage high: {{value}}"]  
  type        = list(string)    
}

#Warn thresholds
variable "monitor_warn_thresholds" {
  description = "Warning thresholds sequence wise.(Loop)"
  default     = ["75", "20", "3.0", "70"]
  type        = list(string)  
}

#Critical thresholds
variable "monitor_critical_thresholds" {
  description = "Critical thresholds serial wise.(Loop)"
  default     = ["85", "15", "4.0", "80"]
  type        = list(string)  
}

# Trigger a separate alert for each Host and Environment.
variable "trigger_by" {
  description  = "tags for trigger a separate alert for each Host and Environment "
  default      = "{host,Environment}"
  type         = string
}

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
  description = "No data notification"
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

# To tag monitors
variable "tags" {
  description = "Add values to set tags for monitor."
  default     = []    
  type        = list(string)
}

# Include tags in title
variable "include_tags" {
  description = "Option for setting up tag inclusion in monitor title while triggering."
  default     = true
  type        = bool
}

# Monitor from tag-
variable "from" {
  description = "Datadog Monitor option to evaluate data from."
  default     = {
    tag       = "Environment"
    tag_value = "prod"
  }
  type        = map
}

# Message-Footer for all monitors.
variable "datadog_alert_message" {
  description = "Monitor alert message to add in all monitors."
  default     = <<EOF
Host: {{host.name}}
Host IP: {{host.ip}}
Environment: {{host.Environment}}

{{#is_no_data}}Not receiving data @pagerduty{{/is_no_data}}
{{#is_alert}}@pagerduty{{/is_alert}}
{{#is_warning}}@pagerduty{{/is_warning}}
{{#is_recovery}}@pagerduty{{/is_recovery}}
@slack-alerts
EOF
  type        = string 
}