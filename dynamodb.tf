# resource "aws_dynamodb_table" "test_table" {
#   name           = "TestTable"
#   billing_mode   = "PROVISIONED" # PAY_PER_REQUEST
#   read_capacity  = 1
#   write_capacity = 1
#   hash_key       = "id"

#   attribute {
#     name = "id"
#     type = "S"
#   }
# }
