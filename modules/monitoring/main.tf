resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}
resource "helm_release" "prometheus_stack" {
  name             = "prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = "monitoring"
  create_namespace = false

  values = [
    file("${path.module}/values.yaml")
  ]

  depends_on = [kubernetes_secret.additional_scrape]
}

# Obtener IPs privadas de los nodos edge
data "aws_instances" "edge" {
  filter {
    name   = "tag:Project"
    values = [var.project]
  }

  filter {
    name   = "tag:Name"
    values = ["*edge*"]
  }
}

locals {
  edge_targets = [
    for ip in data.aws_instances.edge.private_ips : "${ip}:9100"
  ]
}

/*
  SE ELIMINA EL BLOQUE data "templatefile" 
  porque se usará la función nativa directamente.
*/

resource "kubernetes_secret" "additional_scrape" {
  metadata {
    name      = "prometheus-additional-scrape"
    namespace = "monitoring"
  }

  data = {
    # ⬇️ USO DE LA FUNCIÓN NATIVA templatefile()
    "additional-scrape-configs.yaml" = base64encode(templatefile("${path.module}/additional-scrape.tpl", {
      targets = local.edge_targets
    }))
  }

  type = "Opaque"
  depends_on = [kubernetes_namespace.monitoring]
}