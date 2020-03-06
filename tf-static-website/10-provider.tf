terraform {
  backend "s3" {}
}

provider "aws" {
  assume_role {
    role_arn = var.tf_state_role_arn
  }

  alias               = "ops-blog"
  region              = var.aws_region
  allowed_account_ids = [ var.aws_account_id ]
}

# Deploy ACM in the us-east-1 because Cloudfront expects that you have a cert there.
provider "aws" {
  assume_role {
    role_arn = var.tf_state_role_arn
  }

  alias               = "ops-blog-us-east-1"
  region              = "us-east-1"
  allowed_account_ids = [ var.aws_account_id ]
}