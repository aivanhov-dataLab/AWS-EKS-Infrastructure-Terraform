provider "kubernetes" {
  host  = module.eks.cluster_endpoint
  token = data.aws_eks_cluster_auth.myapp-cluster.token
  cluster_ca_certificate = base64decode(
    data.aws_eks_cluster.myapp-cluster.certificate_authority[0].data
  )
}

data "aws_eks_cluster_auth" "myapp-cluster" {
  name       = module.eks.cluster_name
  depends_on = [module.eks]
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.25.0"

  name               = "myapp-eks-cluster"
  kubernetes_version = "1.33"

  vpc_id     = module.myapp-vpc.vpc_id
  subnet_ids = module.myapp-vpc.private_subnets

  # API Kubernetes accessible depuis Internet
  endpoint_public_access  = true
  endpoint_private_access = true

  # Donne à l'identité AWS qui exécute Terraform
  # les droits administrateur dans le cluster Kubernetes.
  enable_cluster_creator_admin_permissions = true

  # Addons EKS
  addons = {
    coredns = {}

    kube-proxy = {}

    vpc-cni = {
      before_compute = true
    }

    eks-pod-identity-agent = {
      before_compute = true
    }
  }

  eks_managed_node_groups = {
    worker-group-1 = {
      instance_types = ["t3.micro"]

      min_size     = 1
      max_size     = 3
      desired_size = 2

      # Pour IPv4, le module peut attacher la policy CNI
      # au rôle des nodes.
      iam_role_attach_cni_policy = true
    }

    worker-group-2 = {
      instance_types = ["t3.micro"]

      min_size     = 1
      max_size     = 2
      desired_size = 1

      iam_role_attach_cni_policy = true
    }
  }

  tags = {
    environment = "development"
    application = "myapp"
  }
}
