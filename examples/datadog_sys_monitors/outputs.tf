output "output" {
  value = {
    datadog_monitors   = module.datadog_sys.output
  }
}