output "argocd_url" {
  value       = "http://${helm_release.argocd.name}.argocd.svc.cluster.local"
  description = "URL del servidor ArgoCD"
}
