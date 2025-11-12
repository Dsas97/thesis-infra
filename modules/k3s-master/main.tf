# =====================================
# Módulo: k3s-master
# Despliega una instancia EC2 con K3s Server
# =====================================

resource "aws_security_group" "k3s_master_sg" {
  name        = "${var.project}-k3s-master-sg"
  description = "Permite acceso SSH y trafico K3s desde los nodos edge"
  vpc_id      = var.vpc_id

  # SSH desde tu IP local
  ingress {
    description = "SSH acceso admin"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]
    cidr_blocks = [var.admin_ip] # ejemplo: "181.x.x.x/32"
  }

  # Tráfico K3s API desde los nodos edge (puerto 6443)
  ingress {
    description = "K3s API server"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Salida libre"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project}-k3s-master-sg"
    Project = var.project
  }
}

# =====================================
# Instancia EC2 (K3s Master)
# =====================================

resource "aws_instance" "k3s_master" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = element(var.vpc_public_subnets, 0)
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.k3s_master_sg.id]
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/user-data.sh", {
    PROJECT = var.project
  })

  tags = {
    Name    = "${var.project}-k3s-master"
    Project = var.project
    Role    = "k3s-master"
  }
}

# =====================================
# Obtener dinámicamente el token K3s
# =====================================

# Esperar a que la instancia esté lista
data "aws_instance" "master_data" {
  depends_on  = [aws_instance.k3s_master]
  instance_id = aws_instance.k3s_master.id
}

# Ejecutar comando remoto para leer el token real
resource "null_resource" "get_k3s_token" {
  depends_on = [aws_instance.k3s_master]

  connection {
    type        = "ssh"
    host        = aws_instance.k3s_master.public_ip
    user        = "ubuntu"
    private_key = file(var.ssh_private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "echo '[INFO] Esperando a que K3s genere el token...'",
      # Esperar hasta 5 minutos, comprobando cada 10 segundos
      "for i in {1..30}; do if [ -f /var/lib/rancher/k3s/server/node-token ]; then echo '[INFO] Token encontrado'; break; else echo '[INFO] Aún no disponible, reintentando...'; sleep 10; fi; done",
      "sudo cat /var/lib/rancher/k3s/server/node-token > /tmp/k3s_token.txt",
      "echo '[INFO] Token guardado correctamente en /tmp/k3s_token.txt'"
    ]
  }
}

