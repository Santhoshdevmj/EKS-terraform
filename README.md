# vpc-terraform
My own vpc terraform Repo

# AWS EKS Terraform Setup

This Terraform project sets up a complete Amazon EKS (Elastic Kubernetes Service) environment on AWS. It includes provisioning a custom VPC with public and private subnets, and deploying an EKS cluster with managed node groups.

---

## 📁 Project Structure

.
├── README.md # Project documentation
├── main.tf # Entry point for VPC resources
├── variable.tf # Input variables for VPC
├── output.tf # Outputs for VPC
├── eks-main.tf # EKS cluster and node group definitions
├── eks-varibales.tf # Input variables for EKS
├── eks-output.tf # Outputs from EKS resources
├── df-vars.tf # (Optional) Default or shared variables
├── ng-main.tf # Node group provisioning (if separate)

---

## 🧱 Features

- **Custom VPC**
  - 2 Public Subnets (for NAT Gateway, Load Balancers)
  - 2 Private Subnets (for EKS worker nodes)
  - Internet Gateway, Route Tables, NAT Gateway

- **EKS Cluster**
  - AWS-managed Kubernetes cluster
  - Managed node groups
  - 3 desired EC2 nodes (can be configured via variables)
  - IAM roles and policies

- **Modular Terraform**
  - Separation of VPC and EKS resources for clarity
  - Outputs and variables clearly defined
  - Easy to extend or modify

---

## 🚀 Getting Started

### Prerequisites

- Terraform v1.x
- AWS CLI configured with appropriate permissions
- IAM permissions for:
  - VPC, EC2, EKS, IAM, and related resources

### Initialize Terraform
terraform init

Validate Configuration
terraform validate

Plan Infrastructure
terraform plan

Apply Infrastructure

terraform apply
📦 Outputs
VPC ID

Subnet IDs (public/private)

EKS Cluster Name

Node Group Name

EKS Cluster Endpoint

🧪 Notes
You can customize the number of nodes, region, instance type, etc., through the variables defined in variable.tf and eks-varibales.tf.

Ensure the correct AWS region and availability zones are set.

📌 Future Enhancements
Add Helm chart deployment post-cluster creation

Integrate with CI/CD (GitHub Actions / GitLab CI)

Add monitoring (Prometheus + Grafana) and logging (CloudWatch)

Add support for Fargate profiles (serverless pods)

🛡️ Security
EKS IAM roles follow least privilege principle

Node groups run in private subnets for added security

Public access to EKS cluster endpoint can be restricted via security groups or endpoint access settings

📬 Author
Devsanthosh RAJ MJ