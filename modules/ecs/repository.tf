resource "aws_ecr_repository" "my_repository" {
  name         = "myrepo"
  force_delete = true
}
