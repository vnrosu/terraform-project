#Create a launch template 
resource "aws_launch_template" "launch_template" {
  name          = var.launch_template_name
  instance_type = var.instance_type
  image_id      = var.image_id
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = var.associate_public_ip_address
    security_groups             = var.security_group_ids
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.instance_name
    }
  }
}
#Create an autoscaling group
resource "aws_autoscaling_group" "we_scale" {
  desired_capacity    = 2
  max_size            = 5
  min_size            = 1
  vpc_zone_identifier = var.subnet_ids
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }
}

# Attach autoscaling group to the target group
resource "aws_autoscaling_attachment" "my_autoscaling_attachment" {
  autoscaling_group_name = aws_autoscaling_group.we_scale.id
  lb_target_group_arn    = var.target_group_arn
}
