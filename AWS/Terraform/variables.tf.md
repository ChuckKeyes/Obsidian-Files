
terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

variable "aws_profile" {
  description = "Named AWS CLI profile to use (optional)"
  type        = string
  default     = null
}

# Regions
variable "region_af" { default = "af-south-1" }   # Cape Town
variable "region_sa" { default = "sa-east-1" }    # São Paulo
variable "region_us" { default = "us-east-1" }    # N. Virginia

# VPC CIDRs
variable "vpc_cidr_af" { default = "10.214.0.0/16" }
variable "vpc_cidr_sa" { default = "10.215.0.0/16" }
variable "vpc_cidr_us" { default = "10.216.0.0/16" }

# Public Subnet CIDRs
variable "subnet_cidr_af" { default = "10.214.10.0/24" } # Cape Town
variable "subnet_cidr_sa" { default = "10.215.15.0/24" } # São Paulo
variable "subnet_cidr_us" { default = "10.216.20.0/24" } # Virginia

# Network access
variable "allowed_rdp_cidr" {
  description = "Your workstation /32 for RDP (use 0.0.0.0/0 only for testing)"
  type        = string
  default     = "0.0.0.0/0"
}

# Because cross-VPC SG references are not allowed, allow Cape Town HTTP from these CIDRs (placeholder)
variable "af_http_source_cidrs" {
  description = "CIDRs allowed to reach Cape Town Linux on TCP/80 (use TGW/peering + private CIDRs in real setups)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# EC2 key pair name (must exist in each region or create per region)
variable "key_name" {
  description = "EC2 key pair to attach to instances"
  type        = string
  default     = null
}

# Common tags
variable "default_tags" {
  type = map(string)
  default = {
    Project = "AWS-VM-VPC-Lab"
    Owner   = "Chuck Keyes"
    Env     = "lab"
  }
}
