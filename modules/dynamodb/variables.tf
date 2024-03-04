variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "hash_key" {
  description = "The hash key (partition key) of the DynamoDB table"
  type        = string
}

variable "hash_key_type" {
  description = "The data type of the hash key"
  type        = string
}
