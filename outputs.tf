output "public_dns" {
  value = module.load-balancers.public_dns
}

output "private_dns" {
  value = module.load-balancers.private_dns
}
