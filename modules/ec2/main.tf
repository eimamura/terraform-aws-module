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
}
