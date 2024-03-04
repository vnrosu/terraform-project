data "http" "myipaddr" {
  url = "http://icanhazip.com"
}

#Create incoming http traffic security group
resource "aws_security_group" "http_traffic" {
  name        = "http_traffic"
  description = "Security group for incoming http traffic"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "http_ipv4" {
  security_group_id = aws_security_group.http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
  description       = " allowing all incoming http traffic from any ipv4"
}

resource "aws_vpc_security_group_ingress_rule" "http_ipv6" {
  security_group_id = aws_security_group.http_traffic.id
  cidr_ipv6         = "::/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
  description       = " allowing all incoming http traffic from any ipv6"
}

#Create incoming  traffic security group on port 3000 for our servers
resource "aws_security_group" "server_traffic" {
  name        = "server_traffic"
  description = "Security group for incoming http traffic"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "http_ipv4_3000" {
  security_group_id = aws_security_group.server_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3000
  ip_protocol       = "tcp"
  to_port           = 3000
  description       = " allowing all incoming traffic from any ipv4 on port 3000"
}


resource "aws_vpc_security_group_ingress_rule" "http_ipv6_3000" {
  security_group_id = aws_security_group.server_traffic.id
  cidr_ipv6         = "::/0"
  from_port         = 3000
  ip_protocol       = "tcp"
  to_port           = 3000
  description       = " allowing all incoming traffic from any ipv6 on port 3000"
}


#Create incoming https traffic security group
resource "aws_security_group" "https_traffic" {
  name        = "https_traffic"
  description = "Security group for incoming https traffic"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "https_ipv4" {
  security_group_id = aws_security_group.https_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
  description       = " allowing all incoming https traffic from any ipv4"
}

resource "aws_vpc_security_group_ingress_rule" "https_ipv6" {
  security_group_id = aws_security_group.https_traffic.id
  cidr_ipv6         = "::/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
  description       = " allowing all incoming https traffic from any ipv6"
}

#Create outgoing traffic security group
resource "aws_security_group" "outgoing_traffic" {
  name        = "outgoing_traffic"
  description = "Security group for outgoing traffic"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "outgoing_ipv6" {
  security_group_id = aws_security_group.outgoing_traffic.id

  cidr_ipv6   = "::/0"
  ip_protocol = "-1"
  description = "allowing all outgoing traffic to any ipv4"
}

resource "aws_vpc_security_group_egress_rule" "outgoing_ipv4" {
  security_group_id = aws_security_group.outgoing_traffic.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
  description = "allowing all outgoing traffic to any ipv6"
}

#Create ssh traffic security group
resource "aws_security_group" "ssh" {
  name        = "ssh"
  description = "Security group for incoming ssh"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.ssh.id
  cidr_ipv4         = "${chomp(data.http.myipaddr.response_body)}/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  description       = "allows ssh incoming only from the machine this code is executed on"
}
