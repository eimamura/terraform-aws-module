data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"] # AMI owner is Amazon
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"] # Amazon Linux 2 AMI name pattern
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"] # Ensure it's an EBS-backed image
  }
}
