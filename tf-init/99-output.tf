# The output below can be used by other terraform respositories.

output "aws_account_id" {
    value = var.aws_account_id
}

output "aws_s3_bucket_arn" {
    value = aws_s3_bucket.ops_terraform_init.arn
}

output "aws_dynamodb_arn" {
    value = aws_dynamodb_table.ops_terraform_init_statelock.arn
}