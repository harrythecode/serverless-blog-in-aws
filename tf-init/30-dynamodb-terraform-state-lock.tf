resource "aws_dynamodb_table" "ops_terraform_init_statelock" {
  name           = var.aws_dynamodb_tablename
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"
  provider       = "aws.ops-init"

  attribute {
    name = "LockID"
    type = "S"
  }
}
