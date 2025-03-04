resource "aws_s3_bucket" "data_lake" {
  bucket        = "my-tf-test-bucket-sjehjfhj"
  force_destroy = true
}
resource "aws_s3_object" "csv" {
  bucket       = aws_s3_bucket.data_lake.id
  key          = "students.csv"
  source       = "./students.csv" # Ensure this file exists in your working directory
  content_type = "text/csv"
}

resource "aws_glue_catalog_database" "my_db" {
  name = "my_glue_db"
}
module "glue_role" {
  source              = "./modules/iam_role"
  role_name           = "glue-role"
  assume_role_service = "glue.amazonaws.com"
  policy_json         = file("policies/ec2-s3-policy.json")
}
resource "aws_glue_crawler" "my_crawler" {
  name          = "my_s3_crawler"
  role          = module.glue_role.iam_role_arn
  database_name = aws_glue_catalog_database.my_db.name

  s3_target {
    path = "s3://${aws_s3_bucket.data_lake.bucket}/"
  }

  schedule = "cron(0 12 * * ? *)" # Runs daily at 12 PM UTC
}

resource "aws_iam_policy_attachment" "glue_logs_policy" {
  name       = "glue-logs-attach"
  roles      = [module.glue_role.iam_role_name]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_policy_attachment" "glue_service_role" {
  name       = "glue-service-role-attach"
  roles      = [module.glue_role.iam_role_name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_glue_registry" "example" {
  registry_name = "example-registry"
}
resource "aws_glue_schema" "example" {
  schema_name       = "example-schema"
  registry_arn      = aws_glue_registry.example.arn
  data_format       = "AVRO"
  compatibility     = "NONE"
  schema_definition = "{\"type\": \"record\", \"name\": \"r1\", \"fields\": [ {\"name\": \"f1\", \"type\": \"int\"}, {\"name\": \"f2\", \"type\": \"string\"} ]}"
}

resource "aws_glue_workflow" "example" {
  name = "example"
}
# resource "aws_glue_trigger" "example-start" {
#   name          = "trigger-start"
#   type          = "ON_DEMAND"
#   workflow_name = aws_glue_workflow.example.name

#   actions {
#     job_name = "example-job"
#   }
# }
# resource "aws_glue_trigger" "example-inner" {
#   name          = "trigger-inner"
#   type          = "CONDITIONAL"
#   workflow_name = aws_glue_workflow.example.name

#   predicate {
#     conditions {
#       job_name = "example-job"
#       state    = "SUCCEEDED"
#     }
#   }

#   actions {
#     job_name = "another-example-job"
#   }
# }

# resource "aws_lakeformation_resource" "data_lake_db" {
#   arn                     = aws_s3_bucket.data_lake.arn
#   use_service_linked_role = true
# }

# data "aws_caller_identity" "current" {}

# module "athena_role" {
#   source              = "./modules/iam_role"
#   role_name           = "query-role"
#   assume_role_service = "athena.amazonaws.com"
#   policy_json         = file("policies/ec2-s3-policy.json")
# }

# resource "aws_lakeformation_data_lake_settings" "example" {
#   admins = [data.aws_caller_identity.current.arn, module.athena_role.iam_role_arn]

#   create_database_default_permissions {
#     permissions = ["SELECT", "ALTER", "DROP"]
#     principal   = module.athena_role.iam_role_arn
#   }

#   create_table_default_permissions {
#     permissions = ["ALL"]
#     principal   = data.aws_caller_identity.current.arn
#   }
# }

# resource "aws_glue_catalog_database" "example" {
#   name = "my_data_lake"
# }

# resource "aws_glue_catalog_table" "data_lake_table" {
#   name          = "students"
#   database_name = aws_glue_catalog_database.example.name
#   table_type    = "EXTERNAL_TABLE"

#   storage_descriptor {
#     location      = aws_s3_bucket.data_lake.bucket
#     input_format  = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
#     output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"
#     ser_de_info {
#       name                  = "ParquetSerDe"
#       serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"
#     }
#   }
# }

# resource "aws_lakeformation_resource" "s3_resource" {
#   arn      = "arn:aws:s3:::my-data-lake-bucket"
#   role_arn = aws_iam_role.lake_formation_role.arn
# }
# resource "aws_lakeformation_permissions" "s3_permissions" {
#   principal = aws_iam_role.lake_formation_role.arn
#   data_location {
#     arn = aws_s3_bucket.data_lake.arn
#   }
#   permissions = ["DATA_LOCATION_ACCESS"]
# }

# module "lake_formation_role" {
#   source              = "./modules/iam_role"
#   role_name           = "lake-formation-role"
#   assume_role_service = "lakeformation.amazonaws.com"
#   policy_json         = file("policies/ecs-task-policy.json")
# }

# resource "aws_iam_role" "lake_formation_role" {
#   name = "MyLakeFormationRole"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Principal = {
#           Service = "lakeformation.amazonaws.com"
#         }
#         Effect = "Allow"
#         Sid    = ""
#       },
#     ]
#   })
# }
