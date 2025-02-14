resource "aws_ecr_repository" "this" {
  name         = "myrepo"
  force_delete = true
}
