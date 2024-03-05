vpc_name = "microservices"

cidr_range = "10.0.0.0/20"

availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]

public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

private_subnets = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]

hash_key = "id"

hash_key_type = "N"

instance_type = "t2.micro"

key_name = "aws key"

lights_ami_id = "ami-080d302c4d9682c9e"

heating_ami_id = "ami-0d4e50e145da85d61"

status_ami_id = "ami-024a42572fb7b5412"

auth_ami_id = "ami-099f71fafeedcc526"
