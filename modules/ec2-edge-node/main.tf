#Crea una o varias instancias EC2 (dependiendo de edge_count).
#Usa una AMI preconfigurada con Docker, K3s y Node Exporter (la que generas con Packer).
#Ejecuta un script de user data que:
#Habilita Docker.
#Si se pasan K3S_URL y K3S_TOKEN, el nodo se une automáticamente al clúster K3s master como agent.
#Esto es clave para tu arquitectura Edge, ya que automatiza la unión al clúster sin pasos manuales.

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

  user_data = templatefile("${path.module}/user-data.sh", {
    K3S_URL   = var.k3s_url
    K3S_TOKEN = var.k3s_token
  })
}

