# resource "aws_efs_file_system" "example" {
#   creation_token   = "my-product"
#   performance_mode = "generalPurpose"
#   throughput_mode  = "bursting"
#   tags             = var.tags
#   lifecycle_policy {
#     transition_to_ia = "AFTER_30_DAYS"
#   }
# }

# # no use access point if use mount target
# resource "aws_efs_mount_target" "example" {
#   file_system_id  = aws_efs_file_system.example.id
#   subnet_id       = module.vpc.public_subnet_ids[0]
#   security_groups = [module.sg.efs_sg]
# }

# # resource "aws_efs_access_point" "example" {
# #   file_system_id = aws_efs_file_system.example.id
# #   posix_user {
# #     uid = 1001
# #     gid = 1001
# #   }
# #   root_directory {
# #     path = "/example-path"
# #     creation_info {
# #       owner_gid = 1001
# #       owner_uid = 1001
# #       permissions = "750"
# #     }
# #   }
# # }
