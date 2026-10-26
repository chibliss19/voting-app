data "aws_vpc" "default" { default = true }
data "aws_subnets" "default" {
  filter { name = "vpc-id"; values = [data.aws_vpc.default.id] }
  filter { name = "availability-zone"; values = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"] }
}
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"
  cluster_name    = var.cluster_name
  cluster_version = "1.30"
  cluster_endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true
  vpc_id     = data.aws_vpc.default.id
  subnet_ids = data.aws_subnets.default.ids
  eks_managed_node_groups = {
    default_nodes = { min_size = 2, max_size = 3, desired_size = 2, instance_types = ["t3.medium"] }
  }
}
