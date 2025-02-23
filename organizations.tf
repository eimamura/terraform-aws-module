# resource "aws_organizations_account" "new_account" {
#   name  = "dev"
#   email = "aaa@test.com"

#   # Optional: Attach the new account to an existing organizational unit (OU)
#   #   parent_id = "ou-xxxx-yyyyyy" # Replace with your OU ID

#   # Optional: IAM role name that will be created in the new account
#   role_name = "OrganizationAccountAccessRole"
#   #   iam_user_access_to_billing = "DENY"
#   tags = var.tags
# }

# resource "aws_controltower_landing_zone" "example" {
#   # manifest_json = file("landing_zone/LandingZoneManifest.json")
#   manifest_json = file("landing_zone/LZWithoutNewAccount.json")
#   version       = "3.3"

#   tags = {
#     Environment = "Production"
#     ManagedBy   = "Terraform"
#   }
# }

# Your landing zone is now available.
# AWS Control Tower has set up the following:

# centralized management, auditing, and log archiving accounts.
# 2 organizational units, one for your shared accounts and one for accounts that will be provisioned by your users.
# 3 shared accounts, which are the management account and isolated accounts for log archive and security audit.
# Your selected identity and access management configuration.
# 20 preventive controls (SCPs) to enforce policies and 3 detective controls (AWS Config rules) to detect configuration violations.

# Ensure Security Hub Integration
# While AWS Control Tower does not automatically include Security Hub findings, 
# you can still manually integrate Security Hub findings with AWS Control Tower by setting up notifications or workflows.

# data "aws_region" "current" {}
# data "aws_organizations_organization" "example" {}
# data "aws_organizations_organizational_units" "example" { parent_id = data.aws_organizations_organization.example.roots[0].id }
# resource "aws_controltower_control" "example" {
#   control_identifier = "arn:aws:controltower:${data.aws_region.current.name}::control/AWS-GR_EC2_VOLUME_INUSE_CHECK"
#   target_identifier = [
#     for x in data.aws_organizations_organizational_units.example.children :
#     x.arn if x.name == "Infrastructure"
#   ][0]

#   parameters {
#     key   = "AllowedRegions"
#     value = jsonencode(["us-east-1"])
#   }
# }
