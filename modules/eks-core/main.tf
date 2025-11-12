#Crea un clúster de Kubernetes administrado por AWS (EKS) dentro de tu VPC.
#Y dentro de ese cluster, crea un Node Group administrado por EKS, que son instancias EC2 que se unirán como nodos del cluster.

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.15.2" # verifica que coincida con la versión con la que pruebas

  cluster_name      = "${var.project}-eks"
  cluster_version   = "1.28"
  vpc_id            = var.vpc_id
  subnet_ids        = var.subnets

  eks_managed_node_groups = {
    core_nodes = {
      desired_size   = 2
      max_size       = 3
      min_size       = 1
      instance_types = [var.eks_node_instance_type]
      key_name       = var.key_name
    }
  }

  tags = {
    project = var.project
  }
}

# =====================================
# Actualiza automáticamente el kubeconfig local
# =====================================
resource "null_resource" "update_kubeconfig" {
  # Dependencia explícita: espera a que el cluster esté creado
  depends_on = [module.eks]

  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.aws_region}"
  }
}