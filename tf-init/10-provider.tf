terraform {
  backend "local" {}
}

provider "aws" {
  assume_role {
    role_arn = var.aws_ops_init_role_arn
  }
  
  alias               = "ops-init"
  region              = var.aws_region
  allowed_account_ids = [ var.aws_account_id ]
}