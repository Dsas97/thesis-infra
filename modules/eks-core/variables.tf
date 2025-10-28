variable "project" { type = string }
variable "vpc_id" { type = string }
variable "subnets" { type = list(string) }
variable "eks_node_instance_type" { type = string }
variable "key_name" { 
    type = string
    default = "" 
}
