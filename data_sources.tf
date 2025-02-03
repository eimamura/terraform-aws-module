# data "aws_ami" "amazon_linux_2023" {
#   most_recent = true
#   owners      = ["amazon"]
#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm-*-x86_64-gp2"] # Filter for the desired Amazon Linux 2023 version
#   }
#   filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }
# }


data "aws_ssm_parameter" "latest_amzn_linux_2023_ami" {
  # name = "/aws/service/ami-amazon-linux-latest/amazon-linux-2023-x86_64-gp2"
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-minimal-kernel-default-x86_64"
}
