output "public_dns" {
  value = aws_lb.public_load_balancer.dns_name
}

output "private_dns" {
  value = aws_lb.private_load_balancer.dns_name
}

output "lights_target_group_arn" {
  value = aws_lb_target_group.lights.arn
}

output "heating_target_group_arn" {
  value = aws_lb_target_group.heating.arn
}
output "auth_target_group_arn" {
  value = aws_lb_target_group.auth.arn
}

output "status_target_group_arn" {
  value = aws_lb_target_group.status.arn
}
