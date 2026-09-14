provider "aws" {
  region     = "eu-west-3"
  secret_key = var.cle_secret
  access_key = var.cle_access
}


data "aws_availability_zones" "azs" {}

module "myapp-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.7.2"

  name            = "myapp-vpc"
  cidr            = var.cidr_blocks
  private_subnets = var.private_subnet_cidr_blocks
  public_subnets  = var.public_subnet_cidr_blocks
  //azs = ["eu-west-3a","eu-west-3b","eu-west-3c"]
  azs = data.aws_availability_zones.azs.names

  enable_nat_gateway     = true
  single_nat_gateway     = false
  enable_dns_hostnames   = true
  one_nat_gateway_per_az = true

  tags = {
    "kubernetes.io/clusters/myapp-eks-cluster" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/clusters/myapp-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                   = 1
  }

  private_subnet_tags = {
    "kubernetes.io/clusters/myapp-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"          = 1
  }
}