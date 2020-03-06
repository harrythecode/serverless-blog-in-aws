###
# Global settings
###

# Default Region that you want to deploy items
aws_region      = "<your-value-of>"

# Default AWS Account ID that you want to deploy items
aws_account_id  = "<your-value-of>"
# //
###

###
# Service Specific settings
###

# ARN for Terraforming (e.g.,) arn:aws:iam::<aws_accound_id>:role/Administrator
aws_ops_init_role_arn  = "<your-value-of>"

# Bucket name that you want to create by terraforming the tf-init scripts.
aws_s3_bucketname      = "<your-value-of>"

# DynamoDB Table name that you want to create by terraforming the tf-init scripts.
aws_dynamodb_tablename = "<your-value-of>"

# //
###