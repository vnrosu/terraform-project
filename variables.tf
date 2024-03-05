variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "cidr_range" {
  description = "CIDR block range used for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "availability zones required for the VPC"
  type        = list(string)
}

variable "public_subnets" {
  description = "public subnets CIDR blocks"
  type        = list(string)
}

variable "private_subnets" {
  description = "private subnets CIDR blocks"
  type        = list(string)
}

variable "hash_key" {
  description = "hash key (partition key) of the DynamoDB table"
  type        = string
}

variable "hash_key_type" {
  description = "data type of the hash key"
  type        = string
}

variable "instance_type" {
  description = "type of instance"
  type        = string
}

variable "key_name" {
  description = "name of the ssh key"
  type        = string
}

variable "lights_ami_id" {
  type        = string
  description = "AMI ID for lighting instances"
}

variable "heating_ami_id" {
  type        = string
  description = "AMI ID for heating instances"
}

variable "auth_ami_id" {
  type        = string
  description = "AMI ID for authentication instances"
}

variable "status_ami_id" {
  type        = string
  description = "AMI ID for status monitoring instances"
}
