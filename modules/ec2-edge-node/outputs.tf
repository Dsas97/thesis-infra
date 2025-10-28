output "edge_ips" { value = aws_instance.edge[*].public_ip }
