# Initialize Resources for Terraform

These terraform scripts will initialize a new environment. There are several manual steps below. In this case, *terraform-init-user* is used as an example of an IAM user.

## Getting Started
### Set up IAM user for terraform init
1. You need to create an IAM user to run `$ terraform init`. 
2. You need to generate the user's Access Key & download it.
3. Configure a profile with the credentials (e.g.,) `$ aws configure --profile terraform-init-user`

### Rename & Modify the tfvar file
1. Rename `terraform-template.tfvars` to `terraform.tfvars`
2. Change values in the file to appropriate values that you have.

### Apply the terraform scripts
1. Run `$ AWS_PROFILE=terraform-init-user terraform init`
2. Run `$ AWS_PROFILE=terraform-init-user terraform apply`