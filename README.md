# GitHub Actions + Terraform Azure Infrastructure Deployment

## Project Overview

This project automates Azure infrastructure deployment using **Terraform** and **GitHub Actions**.

It provisions infrastructure across three environments:

- Development (Dev)
- Staging (Stage)
- Production (Prod)

Authentication is performed using **GitHub OIDC (OpenID Connect)** with **Microsoft Entra ID App Registration**, eliminating the need to store Azure client secrets.

Terraform state is stored remotely in an Azure Storage Account.

---

# Architecture

Developer
↓
GitHub Repository
↓
GitHub Actions
↓
GitHub Hosted Runner (ubuntu-latest)
↓
Azure Login (OIDC)
↓
Terraform Init
↓
Azure Storage Remote Backend
↓
Terraform Plan
↓
Terraform Apply
↓
Azure Infrastructure

---

# Azure Resources Created

Terraform provisions:

- Resource Group
- Virtual Network (VNet)
- Subnet
- Network Security Group (NSG)
- Public IP
- Network Interface (NIC)
- Ubuntu Linux Virtual Machine

---

# Repository Structure

```
GH-Terraform-Azure-VM
│
├── .github
│   └── workflows
│       ├── terraform-deploy.yml
│       └── terraform-destroy.yml
│
├── terraform
│   ├── providers.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   │
│   ├── environments
│   │   ├── dev.tfvars
│   │   ├── stage.tfvars
│   │   └── prod.tfvars
│   │
│   └── modules
│       └── azure-vm
│           ├── main.tf
│           ├── variables.tf
│           └── outputs.tf
│
└── README.md
```

---

# Prerequisites

Install:

- Git
- Terraform
- Azure CLI
- Visual Studio Code
- GitHub Account
- Azure Subscription

Verify installation:

```
terraform version
az version
git --version
```

---

# Step 1: Clone Repository

```
git clone https://github.com/<username>/GH-Terraform-Azure-VM.git

cd GH-Terraform-Azure-VM
```

---

# Step 2: Login to Azure

```
az login
```

Verify:

```
az account show
```

---

# Step 3: Create Azure App Registration

Azure Portal

Microsoft Entra ID

↓

App registrations

↓

New registration

Example:

```
github-terraform-azure
```

Copy:

- Client ID
- Tenant ID

---

# Step 4: Create Service Principal

```
az ad sp create --id <CLIENT_ID>
```

---

# Step 5: Assign Azure Roles

Assign:

Contributor

Storage Blob Data Contributor

to the Service Principal.

---

# Step 6: Create Storage Account

Create Resource Group

```
rg-terraform-state
```

Create Storage Account

Example

```
ghterraformazurevm14
```

Create Blob Container

```
tfstate
```

---

# Step 7: Configure OIDC

Azure Portal

Microsoft Entra ID

↓

App Registration

↓

Federated Credentials

Create three credentials.

Dev

```
repo:<github_username>/<repository>:environment:dev
```

Stage

```
repo:<github_username>/<repository>:environment:stage
```

Prod

```
repo:<github_username>/<repository>:environment:prod
```

Audience

```
api://AzureADTokenExchange
```

---

# Step 8: GitHub Variables

Repository

Settings

↓

Secrets and Variables

↓

Actions

Variables

Create:

```
AZURE_CLIENT_ID

AZURE_TENANT_ID

AZURE_SUBSCRIPTION_ID
```

Secrets

```
ADMIN_SSH_PUBLIC_KEY
```

---

# Step 9: GitHub Environments

Create environments:

```
dev

stage

prod
```

Configure approvals if required.

---

# Step 10: Terraform Backend

Backend:

```
Resource Group

rg-terraform-state

Storage Account

ghterraformazurevm14

Container

tfstate
```

Separate state files:

```
dev.terraform.tfstate

stage.terraform.tfstate

prod.terraform.tfstate
```

---

# Step 11: Terraform Validation

```
terraform fmt -recursive

terraform init -backend=false

terraform validate
```

---

# Step 12: Push Code

```
git add .

git commit -m "Initial commit"

git push origin main
```

---

# Deployment Workflow

Pipeline executes:

```
Validate

↓

Terraform Plan Dev

↓

Upload Plan

↓

Apply Dev

↓

Approval

↓

Plan Stage

↓

Apply Stage

↓

Approval

↓

Plan Prod

↓

Apply Prod
```

---

# Terraform Commands

Initialize

```
terraform init
```

Validate

```
terraform validate
```

Format

```
terraform fmt
```

Plan

```
terraform plan
```

Apply

```
terraform apply
```

Destroy

```
terraform destroy
```

---

# Destroy Workflow

Run manually.

Choose:

```
dev

stage

prod
```

Type:

```
DESTROY
```

Workflow:

Terraform Init

↓

Terraform Plan Destroy

↓

Terraform Apply Destroy

---

# Common Issues

## Invalid Module Source

Wrong

```
modules/azure-vm
```

Correct

```
./modules/azure-vm
```

---

## Terraform Formatting

Run

```
terraform fmt -recursive
```

---

## OIDC Error

```
AADSTS700213
```

Verify Federated Credential Subject.

---

## Storage Permission

Assign

```
Storage Blob Data Contributor
```

---

## Blob Container Missing

Create

```
tfstate
```

---

## VM SKU Not Available

Change

```
Standard_B1s
```

to

```
Standard_B2s
```

or another available size.

---

## Azure Networking Delay

Added:

```
time_sleep
```

before NIC creation.

---

# Security

- GitHub OIDC Authentication
- No Client Secret
- Azure RBAC
- Remote State
- Manual Approval
- Separate State Files

---

# Technologies

- GitHub Actions
- Terraform
- Azure
- Microsoft Entra ID
- Azure CLI
- Git
- Ubuntu VM

---

# Future Improvements

- Terraform Test Stage
- Security Scanning
- Terraform Cost Estimation
- SonarQube
- Checkov
- Terraform Cloud
- AKS Deployment
- Azure Key Vault Integration

---

# Author

Santhosh B

Cloud & DevOps Engineer
