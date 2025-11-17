output "grafana_dashboard_url" {
  value       = "http://${helm_release.prometheus_stack.name}.monitoring.svc.cluster.local"
  description = "URL interna del dashboard de Grafana"
}

output "grafana_admin_password" {
  value       = var.grafana_admin_password
  sensitive   = true
}

output "prometheus_url" {
  value       = "http://${helm_release.prometheus_stack.name}-prometheus.monitoring.svc.cluster.local"
  description = "URL interna del dashboard de Prometheus"
}
