AWS EKS Infrastructure with Terraform






Production-inspired AWS infrastructure for Amazon EKS, fully provisioned with Terraform.

A hands-on DevOps project focused on Infrastructure as Code, cloud networking, Kubernetes, security and observability.

The objective was to design and deploy a reproducible AWS environment suitable for hosting Kubernetes workloads while applying DevOps and Cloud Engineering practices.

🚀 Project Highlights

☁️ AWS infrastructure fully managed with Terraform

☸️ Amazon EKS Kubernetes cluster

🌐 Public/private subnet architecture across 3 Availability Zones

🔐 IAM, Security Groups, KMS and OIDC

👤 EKS Pod Identity

📊 CloudWatch logging

⚙️ 2 EKS Managed Node Groups

🧪 Infrastructure validation with Terraform and kubectl

Deployment result
77 AWS resources provisioned
0 changed
0 destroyed

EKS Cluster        → ACTIVE
Node Group 1       → ACTIVE
Node Group 2       → ACTIVE

🏗️ Architecture
                         AWS / eu-west-3
                               │
                              VPC
                               │
             ┌─────────────────┴─────────────────┐
             │                                   │
      Public Subnets                       Private Subnets
        AZ-A / AZ-B / AZ-C                  AZ-A / AZ-B / AZ-C
             │                                   │
       Internet Gateway                    NAT Gateways
                                                 │
                                                 ▼
                                           Amazon EKS
                                                 │
                              ┌──────────────────┴──────────────────┐
                              │                                     │
                       Managed Nodes                         Managed Nodes
                       Worker Group 1                         Worker Group 2


Worker nodes are deployed in private subnets, with controlled outbound connectivity through NAT Gateways.

🛠️ Technologies
Area	Technologies
Cloud	AWS
Infrastructure as Code	Terraform
Container orchestration	Kubernetes / Amazon EKS
Networking	VPC, Subnets, Route Tables, NAT Gateway, Internet Gateway
Security	IAM, Security Groups, KMS, OIDC, EKS Pod Identity
Observability	Amazon CloudWatch
Administration	Linux, AWS CLI, kubectl
☸️ EKS Configuration

Kubernetes: 1.33
Region: eu-west-3

Managed add-ons:

Amazon VPC CNI

CoreDNS

kube-proxy

EKS Pod Identity Agent

Two EKS Managed Node Groups are used to provide the Kubernetes worker infrastructure.

🔐 Security

Security is implemented across several layers:

Private subnets for EKS worker nodes

IAM-based AWS permissions

EKS Access Entry

Security Groups

AWS KMS

OIDC provider

EKS Pod Identity

The architecture avoids the need for static AWS credentials inside Kubernetes workloads.

⚙️ Terraform Workflow
terraform init
       ↓
terraform validate
       ↓
terraform plan
       ↓
terraform apply
       ↓
AWS Infrastructure
       ↓
kubectl validation


Example validation:

kubectl get nodes
kubectl get pods -A

📁 Project Structure
.
├── main.tf
├── providers.tf
├── versions.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── modules/
│   ├── vpc/
│   ├── eks/
│   ├── iam/
│   └── security/
├── templates/
├── .gitignore
└── README.md

🎯 Skills Demonstrated

Cloud: AWS · VPC · EKS · IAM · KMS · CloudWatch

IaC: Terraform · Variables · Outputs · State · Resource dependencies

Kubernetes: EKS · Managed Node Groups · VPC CNI · CoreDNS · kube-proxy

DevOps: Automation · Version-controlled infrastructure · Validation · Reproducible deployments

Security: IAM · Network segmentation · Security Groups · OIDC · Pod Identity

🔜 Next Steps

The next iteration of the project will extend the infrastructure with:

CI/CD using GitHub Actions

Dockerized application deployment

Container registry

Terraform security scanning

Prometheus / Grafana

Remote Terraform state

Environment separation (dev, staging, production)

👨‍💻 About

Scève Aivanhov NGUETSE

Junior DevOps / Cloud Engineer

Interested in:

AWS · Terraform · Kubernetes · Docker · Linux · CI/CD · Cloud Security

This project is part of a practical DevOps portfolio demonstrating the ability to design, provision and validate cloud infrastructure using Infrastructure as Code.