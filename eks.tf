# Create an EKS cluster
module "eks" {
 source  = "terraform-aws-modules/eks/aws"
 version = "~> 20.31"

 cluster_name    = "yap-eks-cluster"
 cluster_version = "1.31"

 cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

 # Optional
 cluster_endpoint_public_access = true

 # Optional: Adds the current caller identity as an administrator via cluster access entry
 enable_cluster_creator_admin_permissions = true

 eks_managed_node_groups = {
   example = {
     ami_type       = "AL2023_x86_64_STANDARD"
     instance_types = ["t2.micro"]
     min_size       = 3
     max_size       = 5
     desired_size   = 3
   }
 }

 vpc_id     = data.aws_vpc.selected.id
 subnet_ids = data.aws_subnets.private.ids

 tags = {
   Environment = "dev"
   Terraform   = "true"
 }
}