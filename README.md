AWS EKS Infrastructure with Terraform






Production-inspired AWS Kubernetes infrastructure, fully provisioned and managed with Terraform.

A hands-on DevOps / Cloud Engineering project focused on Infrastructure as Code, AWS networking, Kubernetes, security and observability.

The goal was to design and deploy a reproducible AWS environment for Amazon EKS, while applying practical DevOps and Cloud Engineering principles.

🚀 Project Highlights

☁️ AWS infrastructure managed entirely with Terraform

☸️ Amazon EKS 1.33

🌐 Public/private network architecture across 3 Availability Zones

⚙️ 2 EKS Managed Node Groups

🔐 IAM, Security Groups, KMS and OIDC

👤 EKS Pod Identity

📊 Amazon CloudWatch logging

🧪 Infrastructure and Kubernetes validation

Deployment
77 AWS resources provisioned
0 changed
0 destroyed

EKS Cluster   → ACTIVE
Node Group 1  → ACTIVE
Node Group 2  → ACTIVE

🏗️ Architecture
                              AWS — eu-west-3
                                     │
                                     ▼
                              ┌─────────────┐
                              │     VPC     │
                              └──────┬──────┘
                                     │
                  ┌──────────────────┴──────────────────┐
                  │                                     │
                  ▼                                     ▼
        ┌────────────────────┐               ┌────────────────────┐
        │   PUBLIC SUBNETS   │               │  PRIVATE SUBNETS  │
        │                    │               │                    │
        │ AZ-A │ AZ-B │ AZ-C│               │ AZ-A │ AZ-B │ AZ-C│
        └─────────┬──────────┘               └─────────┬──────────┘
                  │                                     │
                  ▼                                     │
          Internet Gateway                              │
                  │                                     │
               Internet                                 │
                                                        │
                                                 ┌──────▼──────┐
                                                 │ NAT Gateway │
                                                 │     × 3     │
                                                 └──────┬──────┘
                                                        │
                                                        ▼
                                                 ┌──────────────┐
                                                 │  Amazon EKS  │
                                                 │ Kubernetes 1.33
                                                 └──────┬───────┘
                                                        │
                                      ┌─────────────────┴─────────────────┐
                                      │                                   │
                                      ▼                                   ▼
                              Worker Group 1                       Worker Group 2
                              EKS Managed Nodes                    EKS Managed Nodes


Network design: EKS worker nodes are deployed in private subnets across three Availability Zones. NAT Gateways provide controlled outbound connectivity, while the Internet Gateway provides Internet connectivity for the public layer.

🛠️ Technology Stack
Area	Technologies
Cloud	AWS
Infrastructure as Code	Terraform
Kubernetes	Amazon EKS 1.33
Networking	VPC · Subnets · Route Tables · NAT Gateway · Internet Gateway
Security	IAM · Security Groups · KMS · OIDC · EKS Pod Identity
Observability	Amazon CloudWatch
Administration	Linux · AWS CLI · kubectl · Git
☸️ Amazon EKS

Cluster: myapp-eks-cluster
Region: eu-west-3
Kubernetes: 1.33

Managed Node Groups

worker-group-1

worker-group-2

Both node groups reached the ACTIVE state after provisioning.

Managed Add-ons

Amazon VPC CNI

CoreDNS

kube-proxy

EKS Pod Identity Agent

🔐 Security

Security is implemented across multiple layers:

Private subnets for EKS worker nodes

IAM-based access control

EKS Access Entry

Security Groups

AWS KMS

OIDC provider

EKS Pod Identity

EKS Pod Identity provides a mechanism for Kubernetes workloads to access AWS services without embedding static AWS credentials inside containers.

⚙️ Infrastructure as Code

The infrastructure lifecycle is managed through Terraform:

Terraform Configuration
          │
          ▼
terraform init
          │
          ▼
terraform validate
          │
          ▼
terraform plan
          │
          ▼
terraform apply
          │
          ▼
AWS Infrastructure
          │
          ▼
Kubernetes Validation


Deployment result:

Apply complete!

77 resources added
0 changed
0 destroyed


Post-deployment validation:

kubectl get nodes
kubectl get pods -A

📁 Repository Structure
.
├── main.tf
├── providers.tf
├── versions.tf
├── variables.tf
├── outputs.tf
├── modules/
│   ├── vpc/
│   ├── eks/
│   ├── iam/
│   └── security/
├── templates/
├── .gitignore
└── README.md


Sensitive files and credentials should never be committed to the repository.

🎯 Skills Demonstrated

Cloud

AWS · VPC · EKS · IAM · KMS · CloudWatch

Infrastructure as Code

Terraform · Variables · Outputs · State · Resource dependencies

Kubernetes

Amazon EKS · Managed Node Groups · VPC CNI · CoreDNS · kube-proxy

Security

IAM · Network Segmentation · Security Groups · KMS · OIDC · Pod Identity

DevOps

Infrastructure Automation · Git · Validation · Reproducible Deployments · Technical Documentation

🔜 Next Iteration

Planned improvements:

GitHub Actions CI/CD

Dockerized application deployment

Infrastructure security scanning

Prometheus / Grafana monitoring

👨‍💻 About
Scève Aivanhov NGUETSE

Junior DevOps / Cloud Engineer

Mechanical Engineering background with a strong focus on Cloud, DevOps and Infrastructure Automation.

Core technologies:

AWS · Terraform · Kubernetes · Docker · Linux · CI/CD · Cloud Security

This project is part of a practical DevOps portfolio focused on building reproducible, secure and maintainable cloud infrastructure using industry-standard technologies.