# resource "null_resource" "write_kubeconfig" {
#   # Dependencia explícita: espera a que el cluster esté creado
#   depends_on = [time_sleep.wait_for_eks]
#   provisioner "local-exec" {
#     command = "aws eks update-kubeconfig --name ${var.cluster_name} --region ${var.aws_region}"
#   }
# }


# Despliegue de ArgoCD con Helm
resource "helm_release" "argocd" {
  #depends_on = [null_resource.write_kubeconfig]
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }
  set {
    name  = "controller.resources.requests.cpu"
    value = "100m"
  }
  set {
    name  = "controller.resources.requests.memory"
    value = "256Mi"
  }

  set {
    name  = "server.resources.requests.cpu"
    value = "100m"
  }
  set {
    name  = "server.resources.requests.memory"
    value = "256Mi"
  }

  set {
    name  = "repoServer.resources.requests.cpu"
    value = "100m"
  }
  set {
    name  = "repoServer.resources.requests.memory"
    value = "256Mi"
  }

  set {
    name  = "dex.resources.requests.cpu"
    value = "50m"
  }
  set {
    name  = "dex.resources.requests.memory"
    value = "128Mi"
  }
}
