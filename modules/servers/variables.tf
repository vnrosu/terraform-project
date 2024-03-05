
variable "subnet_id" {
  description = "subnet ID"
  type        = string
}

variable "security_group_ids" {
  description = "list of security group IDs"
  type        = list(string)
}

variable "instance_type" {
  description = "type of instace"
  type        = string
}

variable "instance_name" {
  description = "name of the instance"
  type        = string
}
variable "key_name" {
  type        = string
  description = "name of the ssh key"
}
