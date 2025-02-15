resource "aws_launch_template" "this" {
  name          = var.name
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = var.user_data != null ? base64encode(var.user_data) : null
  ebs_optimized = true

  # Conditionally assign the IAM instance profile if provided
  iam_instance_profile {
    name = var.iam_instance_profile != "" ? var.iam_instance_profile : null
  }

  instance_market_options {
    market_type = "spot"
    # spot_options {
    #   spot_instance_type = "persistent" # Set Spot instance to persistent
    # }
  }

  network_interfaces {
    subnet_id                   = var.subnet_id
    security_groups             = var.security_groups
    associate_public_ip_address = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(var.tags, {
      Name = var.name
    })
  }
}
