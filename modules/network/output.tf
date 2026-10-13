
# VPC
output "vpc_id" {
  description = "ID du VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR principal du VPC"
  value       = module.vpc.vpc_cidr_block
}

# Sous-réseaux
output "public_subnet_ids" {
  description = "IDs des sous-réseaux publics"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "IDs des sous-réseaux privés"
  value       = module.vpc.private_subnets
}

output "public_subnet_cidrs" {
  description = "CIDR des sous-réseaux publics"
  value       = module.vpc.public_subnets_cidr_blocks
}

output "private_subnet_cidrs" {
  description = "CIDR des sous-réseaux privés"
  value       = module.vpc.private_subnets_cidr_blocks
}

# NAT Gateways
output "nat_gateway_ids" {
  description = "IDs des NAT Gateways"
  value       = module.vpc.natgw_ids
}

output "nat_gateway_public_ips" {
  description = "IP publiques des NAT Gateways"
  value       = module.vpc.nat_public_ips
}

# Internet Gateway
output "internet_gateway_id" {
  description = "ID de l'Internet Gateway"
  value       = module.vpc.igw_id
}

# Disponibilité
output "availability_zones" {
  description = "AZ utilisées par le réseau"
  value       = var.availability_zones
}
