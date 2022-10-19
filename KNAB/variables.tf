variable "naming_prefix" {
  type        = string
  description = "Naming prefix for all resources"
  default     = "KNAB"
}


variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "vpc_cider_block" {
  type        = string
  description = "Base CIDR Block for VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_enable_dns_hostname" {
  type        = bool
  description = "Enable DNS hostname in VPC"
  default     = true
}

variable "vpc_subnet_cidr_block" {
  type        = string
  description = "Cidr Block for Subnets"
  default     = "10.0.0.0/24"
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Map public IP on launch"
  default     = true
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance type"
  default     = "t2.micro"
}

variable "company" {
  type        = string
  description = "Company name for resource tagging"
  default     = "KNAB"
}

variable "project" {
  type        = string
  description = "Project name for resource tagging"
}

