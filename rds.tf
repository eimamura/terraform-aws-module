
# module "rds" {
#   source                = "./modules/rds"
#   db_identifier         = "my-postgres-db"
#   engine_version        = "16.3"
#   instance_class        = "db.t3.micro"
#   allocated_storage     = 20
#   max_allocated_storage = 100
#   db_username           = "myadmin"
#   db_password           = var.password
#   secret_name           = "rds-postgres-password"
#   subnet_ids            = module.vpc.private_subnet_ids
#   security_group_id     = module.sg.rds_postgres_sg
# }

# output "rds_endpoint" {
#   value = module.rds.rds_endpoint
# }
