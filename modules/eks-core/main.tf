#Crea un clúster de Kubernetes administrado por AWS (EKS) dentro de tu VPC.
#Y dentro de ese cluster, crea un Node Group administrado por EKS, que son instancias EC2 que se unirán como nodos del cluster.

resource "aws_security_group" "eks_api_sg" {
  name        = "${var.project}-eks-api-sg"
  description = "Permite acceso HTTPS al API server del EKS"
  vpc_id      = var.vpc_id

  ingress {
    description = "Acceso desde mi IP al API server"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip] # tu IP, ejemplo: "181.23.45.67/32"
  }

  egress {
    description = "Salida libre"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project}-eks-api-sg"
    Project = var.project
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.15.2" # verifica que coincida con la versión con la que pruebas

  cluster_name    = "${var.project}-eks1"
  cluster_version = "1.28"
  vpc_id          = var.vpc_id
  #subnet_ids      = concat(var.public_subnets, var.private_subnets)
  subnet_ids = var.private_subnets


  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = false

  eks_managed_node_groups = {
    core_nodes = {
      desired_size                  = 2
      max_size                      = 5
      min_size                      = 2
      instance_types                = [var.eks_node_instance_type]
      key_name                      = var.key_name
      subnet_ids     = var.private_subnets
      #additional_security_group_ids = [aws_security_group.eks_api_sg.id]
    }
  }

  tags = {
    project = var.project
  }
}

resource "time_sleep" "wait_for_eks" {
  depends_on      = [module.eks]
  create_duration = "90s" # o 90s si quieres más margen
}


# =====================================
# Actualiza automáticamente el kubeconfig local
# =====================================
resource "null_resource" "update_kubeconfig" {
  # Dependencia explícita: espera a que el cluster esté creado
  depends_on = [time_sleep.wait_for_eks]
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.aws_region}"
  }
}

#aws eks update-kubeconfig --name thesis-devops-edge-eks --region us-east-1
#terraform apply -target=module.eks


