
variable "vpc_name" {
  description = "Nom du VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "Plage IPv4 globale du VPC"
  type        = string
}

variable "availability_zones" {
  description = "Zones de disponibilité AWS à utiliser"
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "Le réseau doit utiliser au moins deux zones de disponibilité."
  }
}

variable "private_subnet_cidrs" {
  description = "CIDR des sous-réseaux privés, un par AZ"
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_cidrs) >= 2
    error_message = "Définis au moins deux sous-réseaux privés."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR des sous-réseaux publics, un par AZ"
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) >= 2
    error_message = "Définis au moins deux sous-réseaux publics."
  }
}

variable "cluster_name" {
  description = "Nom du cluster EKS associé au réseau"
  type        = string
  default     = ""
}

variable "enable_nat_gateway" {
  description = "Activer les NAT Gateways"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Utiliser un NAT Gateway partagé"
  type        = bool
  default     = false
}

variable "one_nat_gateway_per_az" {
  description = "Créer un NAT Gateway par zone de disponibilité"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags communs aux ressources du réseau"
  type        = map(string)
  default     = {}
}