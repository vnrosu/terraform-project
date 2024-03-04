variable "vpc_name" {
  type        = string
  description = "VPC name"
}

variable "cidr_range" {
  type        = string
  description = "CIDR block range used for the VPC"
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

variable "hash_key" {
  type        = string
  description = "hash key (partition key) of the DynamoDB table"
}

variable "hash_key_type" {
  description = "data type of the hash key"
  type        = string
}
