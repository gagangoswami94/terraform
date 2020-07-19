#locals defining final queries to be used in monitors
locals {
  monitors_queries = ["avg(last_5m):100 - ${var.cpu_usage["query"]}{${var.from["tag"]}:${var.from["tag_value"]}} by ${var.trigger_by} > ${local.thresholds["cpu_critical_threshold"]}",  "avg(last_5m):( ${var.disk_usage["query_free"]}{${var.from["tag"]}:${var.from["tag_value"]},!device:devtmpfs,!device:tmpfs}  by {host,device} * 100 / ${var.disk_usage["query_total"]}{${var.from["tag"]}:${var.from["tag_value"]},!device:devtmpfs,!device:tmpfs} by {host,device} ) <= ${local.thresholds["disk_critical_threshold"]}",  "avg(last_5m):${var.load["query"]}{${var.from["tag"]}:${var.from["tag_value"]}} by ${var.trigger_by} > ${local.thresholds["load_critical_threshold"]}",  "avg(last_5m):( ${var.mem_usage["query_used"]}{${var.from["tag"]}:${var.from["tag_value"]}}  by ${var.trigger_by} * 100 / ${var.mem_usage["query_total"]}{${var.from["tag"]}:${var.from["tag_value"]}} by ${var.trigger_by}) > ${local.thresholds["mem_critical_threshold"]}"]
}

locals {
  thresholds = {
    cpu_critical_threshold  = var.monitor_critical_thresholds[0]
    disk_critical_threshold = var.monitor_critical_thresholds[1]
    load_critical_threshold = var.monitor_critical_thresholds[2]
    mem_critical_threshold  = var.monitor_critical_thresholds[3]
  }
}

# Monitors
resource "datadog_monitor" "monitors" {
  count               = length(var.monitors_name)
  require_full_window = var.require_full_window
  renotify_interval   = var.renotify_interval
  no_data_timeframe   = var.no_data_timeframe
  notify_no_data      = var.notify_no_data
  new_host_delay      = var.new_host_delay
  notify_audit        = var.notify_audit
  include_tags        = var.include_tags
  thresholds          = {
    warning           = var.monitor_warn_thresholds[count.index]
    critical          = var.monitor_critical_thresholds[count.index]
  }
  message             = "${var.monitor_message[count.index]}-\n ${var.datadog_alert_message}"
  query               = local.monitors_queries[count.index]
  type                = var.monitor_type[count.index]
  tags                = var.tags
  name                = var.monitors_name[count.index]  
    
}