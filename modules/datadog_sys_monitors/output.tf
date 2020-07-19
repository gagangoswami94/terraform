output "output" {
  value ={
    cpu_monitor_id    = datadog_monitor.monitors[0].id
    cpu_monitor_name  = datadog_monitor.monitors[0].name
    disk_monitor_id   = datadog_monitor.monitors[1].id
    disk_monitor_name = datadog_monitor.monitors[1].name  
    load_monitor_id    = datadog_monitor.monitors[2].id
    load_monitor_name  = datadog_monitor.monitors[2].name
    mem_monitor_id   = datadog_monitor.monitors[3].id
    mem_monitor_name = datadog_monitor.monitors[3].name     
  }
}