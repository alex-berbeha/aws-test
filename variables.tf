variable "region" {
  description = "AWS region"
  default     = "us-east-1"
  type        = string
}

variable "main_vpc_cidr" {
  description = "CIDR block for main VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for public CIDR"
  type        = string
}