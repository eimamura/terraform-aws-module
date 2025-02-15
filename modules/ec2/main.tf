resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id # Use subnet_id passed from parent module
  key_name                    = var.key_name
  associate_public_ip_address = var.create_in_public_subnet # Only associate public IP if it's a public subnet
  vpc_security_group_ids      = var.security_group_ids
  tags = merge(var.tags, {
    Name = var.instance_name
  })
  # Pass the user_data variable here
  user_data = var.user_data

  # Conditionally use the IAM instance profile if provided
  iam_instance_profile = var.iam_instance_profile != "" ? var.iam_instance_profile : null

  # Conditionally use instance_market_options if use_spot_instance is true
  dynamic "instance_market_options" {
    for_each = var.use_spot_instance ? [1] : []
    content {
      market_type = "spot"
      spot_options {
        instance_interruption_behavior = "stop"
        max_price                      = "0.01"
        spot_instance_type             = "persistent"
        # valid_until = "2022-12-31T23:59:59Z"
      }
    }
  }
}
