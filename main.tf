#Tu tesis busca mostrar una arquitectura híbrida Cloud + Edge usando:
#EKS (AWS) para el clúster central (Core).
#K3s (ligero) para los nodos Edge (en borde o simulados con EC2).
#Automatización con Packer + Terraform.
#Por tanto, lo importante no es solo levantar recursos en AWS, sino demostrar una integración coherente entre ambos entornos:
#Cloud centralizado (EKS).
#Edge distribuido (K3s agents).
#utomatización total (infra as code).

module "vpc" {
  source = "./modules/vpc"
  project = var.project
  vpc_cidr = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
}

module "ecr" {
  source = "./modules/ecr"
  repos = ["auth-service","order-service","inventory-service","sync-service","web-dashboard"]
  project = var.project
}

module "eks" {
  source = "./modules/eks-core"
  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.private_subnets
  project = var.project
  eks_node_instance_type = var.eks_node_instance_type
  cluster_name            = "${var.project}-eks"
  cluster_version         = "1.28"
}

module "k3s_master" {
  source = "./modules/k3s-master"

  ami_id              = var.edge_ami_id
  instance_type       = var.edge_instance_type
  vpc_id              = module.vpc.vpc_id
  vpc_public_subnets  = module.vpc.public_subnets
  key_name            = var.key_name
  ssh_private_key_path = var.ssh_private_key_path
  admin_ip            = var.admin_ip
  project             = var.project
}

module "edge_nodes" {
  source = "./modules/ec2-edge-node"
  ami_id = var.edge_ami_id
  edge_count = var.edge_count
  edge_instance_type = var.edge_instance_type
  vpc_public_subnets = module.vpc.public_subnets
  key_name = var.key_name
  project = var.project
  k3s_url   = module.k3s_master.k3s_url
  k3s_token = module.k3s_master.k3s_token
}




#aws ec2 describe-instances --instance-ids i-0e438776f7f2e3f73  --query "Reservations[*].Instances[*].{IP:PublicIpAddress,SubnetId:SubnetId,State:State.Name}"  --output table

#ssh -i "C:/Users/david/Documents/David/Master/8. TFM/Tfm.pem" ubuntu@98.92.201.58