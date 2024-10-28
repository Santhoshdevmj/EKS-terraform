variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets_cidr" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.5.0/24"]
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my-firs-tf-vpc"
}

variable "eks_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my-demo-tf-cluster"
}
