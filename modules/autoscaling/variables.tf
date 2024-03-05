variable "security_group_ids" {
  description = "List of public security group IDs"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "image_id" {
  description = "ID of the Amazon Machine Image (AMI)"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the target group"
  type        = string
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "launch_template_name" {
  description = "Name of the launch template"
  type        = string
}

variable "associate_public_ip_address" {
  description = "Enable public IP assignment for the EC2 instance"
  type        = bool
}
