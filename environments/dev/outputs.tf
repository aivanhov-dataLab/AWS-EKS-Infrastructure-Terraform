
# ---------- Cluster EKS ----------

output "eks_cluster_name" {
  description = "Nom du cluster Kubernetes"
  value       = module.eks.cluster_name
}

output "eks_cluster_arn" {
  description = "ARN du cluster Kubernetes"
  value       = module.eks.cluster_arn
}

output "eks_cluster_endpoint" {
  description = "Endpoint DNS de l'API Kubernetes"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_oidc_issuer_url" {
  description = "Issuer OIDC du cluster"
  value       = module.eks.cluster_oidc_issuer_url
}

# ---------- Réseau ----------

output "vpc_id" {
  description = "ID du VPC"
  value       = module.network.vpc_id
}

output "vpc_cidr_block" {
  description = "Plage IPv4 du VPC"
  value       = module.network.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "IDs des sous-réseaux publics"
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs des sous-réseaux privés utilisés par EKS"
  value       = module.network.private_subnet_ids
}

output "public_subnet_cidrs" {
  description = "Plages IPv4 des sous-réseaux publics"
  value       = module.network.public_subnet_cidrs
}

output "private_subnet_cidrs" {
  description = "Plages IPv4 des sous-réseaux privés"
  value       = module.network.private_subnet_cidrs
}

# ---------- IP publiques ----------

output "nat_gateway_public_ips" {
  description = "Adresses IP publiques des passerelles NAT"
  value       = module.network.nat_gateway_public_ips
}

# ---------- Configuration kubectl ----------

output "kubectl_config_command" {
  description = "Commande pour configurer kubectl"
  value = format(
    "aws eks update-kubeconfig --region %s --name %s",
    var.aws_region,
    module.eks.cluster_name
  )
}
