#Creates a VPC
module "network" {
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
  vpc_id = module.network.vpc_id
}

#Creates the dynamodbs required
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
