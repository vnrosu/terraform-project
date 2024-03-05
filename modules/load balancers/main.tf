# Create  External Application Load Balancer
resource "aws_lb" "public_load_balancer" {
  name               = "public-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.public_security_group_ids
  subnets            = var.public_subnet_ids
}

# Create  Internal Application Load Balancer
resource "aws_lb" "private_load_balancer" {
  name               = "private-load-balancer"
  internal           = true
  load_balancer_type = "application"
  security_groups    = var.private_security_group_ids
  subnets            = var.private_subnet_ids
}

# Create Target Groups
resource "aws_lb_target_group" "status" {
  name     = "status-target-group"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path                = "/api/status/health"
    protocol            = "HTTP"
    interval            = 20
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group" "lights" {
  name     = "lights-target-group"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path                = "/api/lights"
    protocol            = "HTTP"
    interval            = 20
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group" "heating" {
  name     = "heating-target-group"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path                = "/api/heating"
    protocol            = "HTTP"
    interval            = 20
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group" "auth" {
  name     = "auth-target-group"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path                = "/api/auth"
    protocol            = "HTTP"
    interval            = 20
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}


# Attach instances to Target Groups
resource "aws_lb_target_group_attachment" "status_attachment" {
  target_group_arn = aws_lb_target_group.status.arn
  target_id        = var.status_instance_id
}

resource "aws_lb_target_group_attachment" "lights_attachment" {
  target_group_arn = aws_lb_target_group.lights.arn
  target_id        = var.lighting_instance_id
}

resource "aws_lb_target_group_attachment" "heating_attachment" {
  target_group_arn = aws_lb_target_group.heating.arn
  target_id        = var.heating_instance_id
}

resource "aws_lb_target_group_attachment" "auth_attachment" {
  target_group_arn = aws_lb_target_group.auth.arn
  target_id        = var.auth_instance_id
}

#Create listeners
resource "aws_lb_listener" "public_listener" {
  load_balancer_arn = aws_lb.public_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.status.arn
  }
}

resource "aws_lb_listener" "private_listener" {
  load_balancer_arn = aws_lb.private_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.auth.arn
  }
}

# Create Listener Rules
resource "aws_lb_listener_rule" "status_rule" {
  listener_arn = aws_lb_listener.public_listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.status.arn
  }

  condition {
    path_pattern {
      values = ["/api/status*"]
    }
  }
}

resource "aws_lb_listener_rule" "lights_rule" {
  listener_arn = aws_lb_listener.public_listener.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lights.arn
  }

  condition {
    path_pattern {
      values = ["/api/lights*"]
    }
  }
}

resource "aws_lb_listener_rule" "heating_rule" {
  listener_arn = aws_lb_listener.public_listener.arn
  priority     = 20

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.heating.arn
  }

  condition {
    path_pattern {
      values = ["/api/heating*"]
    }
  }
}

resource "aws_lb_listener_rule" "auth_rule" {
  listener_arn = aws_lb_listener.private_listener.arn
  priority     = 20

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.auth.arn
  }

  condition {
    path_pattern {
      values = ["/api/auth*"]
    }
  }
}
