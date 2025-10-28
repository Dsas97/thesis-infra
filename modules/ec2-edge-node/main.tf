resource "aws_instance" "edge" {
  count         = var.edge_count
  ami           = var.ami_id
  instance_type = var.edge_instance_type
  subnet_id     = element(var.vpc_public_subnets, count.index % length(var.vpc_public_subnets))
  key_name      = var.key_name

  tags = {
    Name    = "${var.project}-edge-${count.index}"
    Project = var.project
  }

  user_data = file("${path.module}/user-data.sh")
}

output "edge_ips" {
  value = aws_instance.edge[*].public_ip
}
