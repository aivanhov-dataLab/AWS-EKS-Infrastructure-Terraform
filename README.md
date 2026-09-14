# AWS EKS Infrastructure with Terraform

![Terraform](https://img.shields.io/badge/Terraform-IaC-844FBA?logo=terraform\&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-Cloud-232F3E?logo=amazonaws\&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-EKS-326CE5?logo=kubernetes\&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-Administration-FCC624?logo=linux\&logoColor=black)

Infrastructure **AWS entièrement provisionnée avec Terraform**, destinée à fournir une plateforme Kubernetes basée sur **Amazon EKS**, avec une architecture réseau séparant les ressources publiques et privées.

Le projet met l'accent sur les principes **Infrastructure as Code (IaC)**, la segmentation réseau, la gestion des accès AWS/Kubernetes, la sécurité et l'observabilité.

---

## 📌 Table of Contents

* [Project Overview](#-project-overview)
* [Architecture](#-architecture)
* [Infrastructure Deployed](#-infrastructure-deployed)
* [Network Architecture](#-network-architecture)
* [Amazon EKS](#-amazon-eks)
* [Security](#-security)
* [Observability](#-observability)
* [Terraform](#-terraform)
* [Deployment](#-deployment)
* [Validation](#-validation)
* [Project Structure](#-project-structure)
* [Skills Demonstrated](#-skills-demonstrated)
* [Future Improvements](#-future-improvements)
* [Lessons Learned](#-lessons-learned)

---

# 🚀 Project Overview

The objective of this project is to design and provision a production-inspired AWS Kubernetes infrastructure using **Terraform**.

The infrastructure includes:

* A dedicated AWS VPC
* Public and private subnets distributed across multiple Availability Zones
* Internet Gateway
* NAT Gateways
* Route tables and routing rules
* Security Groups
* Amazon EKS cluster
* Two EKS managed node groups
* IAM roles and policies
* KMS encryption
* OIDC provider
* EKS managed add-ons
* CloudWatch logging
* EKS Pod Identity Agent

The infrastructure is provisioned using Terraform following an **Infrastructure as Code** approach.

---

# 🏗 Architecture

```text
                              AWS
                               │
                               ▼
                        ┌─────────────┐
                        │     VPC     │
                        │             │
                        │  eu-west-3  │
                        └──────┬──────┘
                               │
              ┌────────────────┴────────────────┐
              │                                 │
              ▼                                 ▼
       Public Subnets                    Private Subnets
       ┌──────────────┐                  ┌──────────────┐
       │ Public AZ-A  │                  │ Private AZ-A │
       │ Public AZ-B  │                  │ Private AZ-B │
       │ Public AZ-C  │                  │ Private AZ-C │
       └──────┬───────┘                  └──────┬───────┘
              │                                 │
              ▼                                 ▼
     ┌─────────────────┐                 ┌───────────────┐
     │ Internet Gateway│                 │ NAT Gateways   │
     └─────────────────┘                 └───────┬───────┘
                                                 │
                                                 ▼
                                      ┌────────────────────┐
                                      │    Amazon EKS      │
                                      │   Kubernetes 1.33  │
                                      └─────────┬──────────┘
                                                │
                                  ┌─────────────┴─────────────┐
                                  │                           │
                                  ▼                           ▼
                         ┌─────────────────┐       ┌─────────────────┐
                         │ Worker Group 1  │       │ Worker Group 2  │
                         │ Managed Nodes   │       │ Managed Nodes   │
                         └─────────────────┘       └─────────────────┘
```

---

# ☁️ Infrastructure Deployed

The Terraform deployment successfully provisioned **77 AWS resources** with:

```text
77 added
0 changed
0 destroyed
```

### Infrastructure summary

| Component           | Configuration     |
| ------------------- | ----------------- |
| Cloud Provider      | AWS               |
| Region              | `eu-west-3`       |
| Environment         | `development`     |
| Infrastructure Tool | Terraform         |
| Kubernetes Platform | Amazon EKS        |
| Kubernetes Version  | 1.33              |
| VPC                 | 1                 |
| Public Subnets      | 3                 |
| Private Subnets     | 3                 |
| NAT Gateways        | 3                 |
| Managed Node Groups | 2                 |
| Encryption          | AWS KMS           |
| Logging             | Amazon CloudWatch |
| OIDC                | Enabled           |
| EKS Pod Identity    | Enabled           |

The EKS cluster and both managed node groups reached the `ACTIVE` state after deployment.

---

# 🌐 Network Architecture

The infrastructure uses a dedicated VPC with a separation between **public** and **private** network zones.

### Public layer

The public layer contains:

* Public subnets
* Internet Gateway
* NAT Gateway infrastructure
* Public route tables

### Private layer

The private layer contains:

* Private subnets
* Private route tables
* NAT-based outbound connectivity
* EKS worker nodes

Three Elastic IP addresses were provisioned for the NAT Gateway infrastructure.

This architecture allows the Kubernetes worker nodes to remain in private subnets while retaining controlled outbound connectivity.

---

# ☸️ Amazon EKS

The Kubernetes control plane is provided by **Amazon EKS**.

```text
Cluster
└── myapp-eks-cluster
    ├── Kubernetes 1.33
    ├── Worker Group 1
    └── Worker Group 2
```

The cluster was successfully created and reached:

```text
Status: ACTIVE
Version: 1.33
Region: eu-west-3
```

## Managed Node Groups

Two managed node groups are configured:

* `worker-group-1`
* `worker-group-2`

Both node groups reached the `ACTIVE` state after provisioning.

Using EKS Managed Node Groups allows AWS to handle several aspects of the underlying worker-node lifecycle while Terraform manages the infrastructure configuration.

---

# 🧩 EKS Add-ons

The cluster uses AWS-managed Kubernetes add-ons:

| Add-on                 | Version                |
| ---------------------- | ---------------------- |
| Amazon VPC CNI         | `v1.23.1-eksbuild.1`   |
| CoreDNS                | `v1.13.2-eksbuild.24`  |
| kube-proxy             | `v1.33.10-eksbuild.25` |
| EKS Pod Identity Agent | `v1.4.0-eksbuild.2`    |

These components provide networking, service discovery, Kubernetes network proxying and pod identity capabilities.

---

# 🔐 Security

Security was considered at multiple layers of the infrastructure.

## IAM

Terraform provisions and associates the IAM permissions required by:

* EKS cluster
* EKS worker nodes
* Kubernetes access
* AWS services used by the infrastructure

The deployment also configures an **EKS Access Entry** and associates the `AmazonEKSClusterAdminPolicy`.

---

## Security Groups

Dedicated Security Groups and rules are configured for the EKS cluster and worker nodes.

The Terraform deployment created the corresponding EKS security infrastructure and rules before provisioning the cluster and worker nodes.

The objective is to control communication between:

```text
Internet
   │
   ▼
AWS Network
   │
   ▼
EKS Control Plane
   │
   ▼
Worker Nodes
```

---

## 🔑 KMS

An AWS KMS key is provisioned as part of the infrastructure for encryption-related requirements.

The Terraform output confirms the creation of the KMS key and its associated policy configuration.

---

## 🔗 OIDC

An OIDC provider is configured for the EKS environment.

This provides the foundation for integrating Kubernetes workloads with AWS IAM through identity-based mechanisms.

---

## 👤 EKS Pod Identity

The **EKS Pod Identity Agent** is enabled as an EKS add-on.

This provides a mechanism for Kubernetes workloads to obtain AWS permissions without relying on static AWS credentials inside containers.

---

# 📊 Observability

Amazon CloudWatch logging is integrated into the infrastructure.

A dedicated CloudWatch log group is created for the EKS environment.

This provides a foundation for monitoring and troubleshooting the Kubernetes environment.

---

# ⚙️ Terraform

Terraform is used to manage the complete infrastructure lifecycle.

The project follows the Infrastructure as Code workflow:

```text
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
Validation
```

The final deployment was successfully completed with:

```text
Apply complete!
Resources: 77 added, 0 changed, 0 destroyed.
```

---

# 🚀 Deployment

## Prerequisites

The following tools are required:

* Terraform
* Git
* AWS account
* AWS credentials configured securely
* Access to an AWS region supporting Amazon EKS

> AWS credentials and sensitive configuration values must **never be committed to Git**.

---

## 1. Clone the repository

```bash
git clone https://github.com/aivanhov-dataLab/AWS-EKS-Infrastructure-Terraform.git

```

---

## 2. Initialize Terraform

```bash
terraform init
```

---

## 3. Validate the configuration

```bash
terraform validate
```

---

## 4. Review the execution plan

```bash
terraform plan
```

Always review the plan before applying infrastructure changes.

---

## 5. Deploy the infrastructure

```bash
terraform apply
```

Confirm the deployment when prompted.

---

## 6. Verify the deployment

After Terraform completes, verify the infrastructure from the AWS Console and/or Kubernetes tooling.

For example:

```bash
kubectl get nodes
```

```bash
kubectl get pods -A
```

```bash
kubectl get namespaces
```

> These commands are intended for post-deployment validation of the EKS environment.

---

# 🧪 Validation

The Terraform deployment was validated through the final infrastructure state.

Expected result:

```text
EKS Cluster       → ACTIVE
Worker Group 1    → ACTIVE
Worker Group 2    → ACTIVE
Terraform         → 77 resources created
```

The deployment output confirms that no resources required modification or destruction during the final apply:

```text
77 added
0 changed
0 destroyed
```

---

# 📁 Project Structure

The project is organized around Terraform infrastructure components.

A typical structure is:

```text
.
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── providers.tf
├── versions.tf
├── modules/
│   ├── vpc/
│   ├── eks/
│   ├── iam/
│   └── security/
├── templates/
├── .gitignore
└── README.md
```

> Adapt this tree to the exact structure of the repository if your actual files/modules differ.

---

# 🧠 Skills Demonstrated

This project demonstrates practical experience in:

### Infrastructure as Code

* Terraform
* Declarative infrastructure
* Resource dependencies
* Variables and outputs
* Terraform state management
* Infrastructure lifecycle management

### AWS

* Amazon VPC
* Subnets
* Route Tables
* Internet Gateway
* NAT Gateway
* Elastic IP
* IAM
* Security Groups
* KMS
* CloudWatch
* Amazon EKS

### Kubernetes

* Amazon EKS
* Managed Node Groups
* Kubernetes networking
* VPC CNI
* CoreDNS
* kube-proxy
* EKS Pod Identity

### Security

* Network segmentation
* IAM permissions
* Security Groups
* KMS encryption
* OIDC
* EKS access management

### DevOps

* Infrastructure automation
* Reproducible deployments
* Infrastructure validation
* Cloud infrastructure documentation
* Version-controlled infrastructure

---

# 📈 Project Methodology

The project follows a structured DevOps workflow:

```text
1. Infrastructure Design
          ↓
2. Terraform Implementation
          ↓
3. Configuration Validation
          ↓
4. Terraform Plan
          ↓
5. Infrastructure Provisioning
          ↓
6. Deployment Validation
          ↓
7. Documentation
```

The main objective is to make infrastructure **reproducible, version-controlled and maintainable**.

---

# 🔮 Future Improvements

The current infrastructure provides the foundation for a more complete DevOps platform.

Planned improvements include:

## CI/CD

Integration with:

* GitHub Actions or Jenkins
* Automated Terraform validation
* Terraform plan on Pull Requests
* Automated deployment workflows

## Kubernetes Application Deployment

Deploy a containerized application on EKS:

```text
Git
 │
 ▼
CI/CD
 │
 ▼
Docker Image
 │
 ▼
Container Registry
 │
 ▼
Amazon EKS
 │
 ├── Deployment
 ├── Service
 ├── ConfigMap
 └── Secret
```

## Infrastructure Security

Potential additions:

* Terraform security scanning
* Checkov
* tfsec
* IAM least-privilege improvements
* Secret management
* Policy validation

## Terraform State

Future improvements could include:

* Remote Terraform backend
* Amazon S3 state storage
* State locking
* Separate environments

For example:

```text
environments/
├── dev/
├── staging/
└── production/
```

## Monitoring

Potential integration with:

* Prometheus
* Grafana
* CloudWatch dashboards
* Kubernetes metrics

## Cost Optimization

The infrastructure can also be improved through:

* Right-sizing worker nodes
* NAT Gateway cost analysis
* Resource lifecycle management
* Automated cleanup
* Environment-specific provisioning

---

# 📚 Lessons Learned

This project provided practical experience with the dependencies involved in deploying a Kubernetes platform on AWS.

A successful EKS deployment requires coordination between several infrastructure layers:

```text
Networking
    │
    ├── VPC
    ├── Subnets
    ├── Routing
    └── NAT
         │
         ▼
Security
    │
    ├── IAM
    ├── Security Groups
    └── KMS
         │
         ▼
Amazon EKS
    │
    ├── Control Plane
    ├── Add-ons
    └── Node Groups
         │
         ▼
Observability
    │
    └── CloudWatch
```

The project also highlights the importance of validating infrastructure incrementally rather than treating `terraform apply` as the only validation step.

---

# 📌 Current Status

**Infrastructure deployment: ✅ Completed**

```text
AWS Region          : eu-west-3
Environment         : development
EKS                 : ACTIVE
Kubernetes          : 1.33
Managed Node Groups : 2
VPC                 : 1
Public Subnets      : 3
Private Subnets     : 3
NAT Gateways        : 3
KMS                 : Enabled
OIDC                : Configured
CloudWatch          : Configured
EKS Pod Identity    : Enabled
Terraform Resources : 77
```

The infrastructure has been successfully provisioned and validated at the Terraform/AWS infrastructure level.

---

# 👨‍💻 Author

**Scève Aivanhov NGUETSE**

Mechanical Engineer | DevOps / Cloud Engineer

Areas of interest:

* Cloud Infrastructure
* Infrastructure as Code
* Kubernetes
* AWS
* Terraform
* Linux
* Automation
* DevOps

---

# ⭐ Project Objective

This project is part of a practical DevOps/Cloud portfolio focused on building **realistic, reproducible and secure cloud infrastructure using industry-standard technologies**.

The next stage is to build upon this EKS foundation by integrating application deployment, CI/CD, security automation, monitoring and cost optimization.
