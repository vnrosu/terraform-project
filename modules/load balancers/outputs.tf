output "public_dns" {
  value = aws_lb.public_load_balancer.dns_name
}

output "private_dns" {
  value = aws_lb.private_load_balancer.dns_name
}
