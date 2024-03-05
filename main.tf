#Creates a VPC
module "vpc" {
  source             = "./modules/vpc"
  vpc_name           = var.vpc_name
  cidr_range         = var.cidr_range
  availability_zones = var.availability_zones
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets

}

#Creates the security groups needed
module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}

#Creates the 2 dynamodbs required
module "lighting_table" {
  source        = "./modules/dynamodb"
  table_name    = "Lighting"
  hash_key      = var.hash_key
  hash_key_type = var.hash_key_type
}

module "heating_table" {
  source        = "./modules/dynamodb"
  table_name    = "Heating"
  hash_key      = var.hash_key
  hash_key_type = var.hash_key_type
}

#Creates the 4 instances
module "lighting_instance" {
  source             = "./modules/servers"
  instance_type      = var.instance_type
  subnet_id          = module.vpc.public_subnets[0]
  security_group_ids = module.security.security_group_ids
  instance_name      = "lighting"
}


module "heating_instance" {
  source             = "./modules/servers"
  instance_type      = var.instance_type
  subnet_id          = module.vpc.public_subnets[1]
  security_group_ids = module.security.security_group_ids
  instance_name      = "heating"
}

module "status_instance" {
  source             = "./modules/servers"
  instance_type      = var.instance_type
  subnet_id          = module.vpc.public_subnets[2]
  security_group_ids = module.security.security_group_ids
  instance_name      = "status"
}

module "auth_instance" {
  source             = "./modules/servers"
  instance_type      = var.instance_type
  subnet_id          = module.vpc.private_subnets[0]
  security_group_ids = module.security.private_security_group_ids
  instance_name      = "auth"
}


