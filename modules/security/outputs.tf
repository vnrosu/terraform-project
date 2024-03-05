output "security_group_ids" {
  value = [
    aws_security_group.http_traffic.id,
    aws_security_group.https_traffic.id,
    aws_security_group.server_traffic.id,
    aws_security_group.outgoing_traffic.id,
    aws_security_group.ssh.id
  ]
}

output "private_security_group_ids" {
  value = [
    aws_security_group.http_traffic.id,
    aws_security_group.https_traffic.id,
    aws_security_group.server_traffic.id,
    aws_security_group.outgoing_traffic.id,
    aws_security_group.private_ssh.id
  ]
}
