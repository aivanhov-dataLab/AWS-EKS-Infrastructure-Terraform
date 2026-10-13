
variable "cluster_name" {
  type        = string
  description = "Nom du cluster EKS"
}

variable "kubernetes_version" {
  type        = string
  description = "Version Kubernetes supportée par EKS"
}

variable "vpc_id" {
  type        = string
  description = "ID du VPC existant"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Sous-réseaux privés du cluster"
}

variable "endpoint_public_access" {
  type    = bool
  default = true
}

variable "endpoint_public_access_cidrs" {
  type        = list(string)
  description = "CIDR autorisés à joindre l'API Kubernetes publique"
  default     = []
  validation {
    condition = (
      !var.endpoint_public_access ||
      length(var.endpoint_public_access_cidrs) > 0
    )
    error_message = "Indique au moins un CIDR autorisé lorsque l'accès public est activé."
  }
}

variable "cluster_addons" {
  type        = any
  description = "Configuration des add-ons EKS"
}

variable "node_groups" {
  type        = any
  description = "Configuration des Managed Node Groups"
}

variable "tags" {
  type    = map(string)
  default = {}
}