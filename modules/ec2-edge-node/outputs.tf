output "edge_ips" {
  description = "Direcciones IP públicas de los nodos edge"
  value       = aws_instance.edge[*].public_ip
}

output "edge_private_ips" {
  description = "IPs privadas de los nodos edge"
  value       = aws_instance.edge[*].private_ip
}

output "edge_instance_ids" {
  value = aws_instance.edge[*].id
}

output "edge_instance_ips" {
  value = aws_instance.edge[*].public_ip
}