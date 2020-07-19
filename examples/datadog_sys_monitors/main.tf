module "datadog_sys" {
  source = "../../modules/nclouds_tf_datadog_sys_monitors"
  require_full_window = var.require_full_window
  renotify_interval   = var.renotify_interval
  no_data_timeframe   = var.no_data_timeframe
  notify_no_data      = var.notify_no_data
  new_host_delay      = var.new_host_delay
  notify_audit        = var.notify_audit
  include_tags        = var.include_tags  
}