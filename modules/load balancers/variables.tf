variable "vpc_id" {
  description = "Main VPC ID"
  type        = string
}

variable "public_security_group_ids" {
  description = "List of public security group IDs"
  type        = list(string)
}

variable "private_security_group_ids" {
  description = "List of private security group IDs"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "status_instance_id" {
  description = "Status instance ID"
  type        = string
}

variable "lighting_instance_id" {
  description = "Lights instance ID"
  type        = string
}

variable "heating_instance_id" {
  description = "Heating instance ID"
  type        = string
}

variable "auth_instance_id" {
  description = "Authentication instance ID"
  type        = string
}
