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
}

module "edge_nodes" {
  source = "./modules/ec2-edge-node"
  ami_id = var.edge_ami_id
  edge_count = var.edge_count
  edge_instance_type = var.edge_instance_type
  vpc_public_subnets = module.vpc.public_subnets
  key_name = var.key_name
  project = var.project
}
