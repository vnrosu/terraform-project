vpc_name = "microservices"

cidr_range = "10.0.0.0/20"

availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]

public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

private_subnets = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]

hash_key = "id"

hash_key_type = "N"

instance_type = "t2.micro"

key_name = "aws key"
