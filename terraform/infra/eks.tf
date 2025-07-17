module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"
  subnet_ids      = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  access_entries = {
    admin = {
      principal_arn = var.eks_admin_user_arn
      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }


  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t3.medium"]
      ami_type       = "AL2_x86_64"
      
      labels = {
        type = "ec2"
      }
      iam_role_additional_policies = {
        ebs = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        lb  = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
      }

      # Ensure proper tagging
      tags = {
        Environment = "dev"
        Terraform   = "true"
        NodeGroup   = "default"
      }
    }
  }

  enable_irsa = true

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }

  cluster_addons = {
    aws-ebs-csi-driver = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    coredns = {
      most_recent = true
    }
  }
}

output "eks_node_security_group" {
  description = "Security Group usado pelos nodes do EKS"
  value       = module.eks.node_security_group_id
}