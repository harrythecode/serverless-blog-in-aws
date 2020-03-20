###
# Global settings
###

# Default Region that you want to deploy items
aws_region     = "<your-value-of>"

# Default AWS Account ID that you want to deploy items
aws_account_id = "<your-value-of>"

# //
###

###
# Service Specific settings
###

# ARN for Terraforming (e.g.,) arn:aws:iam::<aws_accound_id>:role/Administrator
tf_state_role_arn = "<your-value-of>"

# Bucket name that you intend to have a static website which is NOT relevant to the tf-init's one.
aws_s3_bucketname = "<your-value-of>"

# Domain name of your website. (e.g.,) example.com
domain_name       = "<your-value-of>"

# //
###