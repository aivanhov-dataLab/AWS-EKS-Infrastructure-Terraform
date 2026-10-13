variable "project_name" {
  type    = string
  default = "myapp"
}

variable "environment" {}

variable "aws_region" {}

variable "kubernetes_version" {}

variable "vpc_cidr" {}

variable "availability_zones" {}

variable "private_subnet_cidrs" {}

variable "public_subnet_cidrs" {}

variable "enable_nat_gateway" {}

variable "single_nat_gateway" {}

variable "one_nat_gateway_per_az" {}

variable "endpoint_public_access" {}

variable "endpoint_public_access_cidrs" {}

variable "node_groups" {}