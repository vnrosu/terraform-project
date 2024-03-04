variable "cidr_range" {
  type        = string
  description = "CIDR block range used for the VPC"
}

variable "vpc_name" {
  type        = string
  description = "VPC name"
}

variable "availability_zones" {
  type        = list(string)
  description = "availability zones required for the VPC"
}

variable "public_subnets" {
  type        = list(string)
  description = "public subnets CIDR blocks"
}

variable "private_subnets" {
  type        = list(string)
  description = "private subnets CIDR blocks"
}
