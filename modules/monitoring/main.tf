# ------------------------------
# Namespace para Prometheus/Grafana
# ------------------------------
#resource "kubernetes_namespace" "monitoring" {
  #metadata {
    #name = "monitoring"
  #}
#}

# ------------------------------
# Prometheus + Grafana mediante Helm
# ------------------------------
resource "helm_release" "prometheus_stack" {
  name       = "prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = "monitoring"
  create_namespace = true  # ya creamos el namespace arriba

  set {
    name  = "grafana.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "prometheus.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "grafana.adminPassword"
    value = var.grafana_admin_password
  }

  #depends_on = [kubernetes_namespace.monitoring]
}

# ------------------------------
# Node Exporter (opcional, ya viene con kube-prometheus-stack)
# ------------------------------
resource "helm_release" "node_exporter" {
  name       = "node-exporter"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-node-exporter"
  namespace  = "monitoring"
  create_namespace = true

  #depends_on = [kubernetes_namespace.monitoring]
}



# module.monitoring.helm_release.prometheus_stack: Still creating... [06m20s elapsed]
# module.monitoring.helm_release.prometheus_stack: Still creating... [06m30s elapsed]
# module.monitoring.helm_release.prometheus_stack: Still creating... [06m40s elapsed]
# ╷
# │ Warning: Helm release "" was created but has a failed status. Use the `helm` command to investigate the error, correct it, then run Terraform again.
# │
# │   with module.monitoring.helm_release.prometheus_stack,
# │   on modules\monitoring\main.tf line 13, in resource "helm_release" "prometheus_stack":
# │   13: resource "helm_release" "prometheus_stack" {
# │
# ╵
# ╷
# │ Error: context deadline exceeded
# │
# │   with module.monitoring.helm_release.prometheus_stack,
# │   on modules\monitoring\main.tf line 13, in resource "helm_release" "prometheus_stack":
# │   13: resource "helm_release" "prometheus_stack" {