# Create bucket for shared state
resource "aws_s3_bucket" "ops_website" {
  bucket   = var.aws_s3_bucketname
  acl      = "private"
  provider = "aws.ops-blog"
  region   = var.aws_region

  versioning {
    enabled = true
  }

  website {
    index_document = "index.html"
    error_document = "public/404.html"
  }

  lifecycle_rule {
    id      = "clean-up"
    enabled = true

    abort_incomplete_multipart_upload_days = 7

    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    expiration {
      expired_object_delete_marker = true
    }

    noncurrent_version_expiration {
      days = 365
    }
  }

  # Encrypt with SSE
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

}

resource "aws_s3_bucket_policy" "ops_website_bucket_policy" {
  bucket = aws_s3_bucket.ops_website.id
  policy = data.aws_iam_policy_document.ops_website_policy_document.json
  provider = "aws.ops-blog"
}

data "aws_iam_policy_document" "ops_website_policy_document" {
  statement {
    sid = "internalAccess"
    principals {
      type        = "AWS"
      identifiers = [ var.tf_state_role_arn ]
    }
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket",
    ]
    resources = [
        "${aws_s3_bucket.ops_website.arn}/*",
        aws_s3_bucket.ops_website.arn
    ]
  }

  statement {
    sid = "externalAccess"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject",
    ]
    resources = [
        "${aws_s3_bucket.ops_website.arn}/public/*"
    ]
  }

  provider = "aws.ops-blog"
}

resource "aws_s3_bucket_public_access_block" "ops_website" {
  bucket                  = aws_s3_bucket.ops_website.id
  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
  
  provider = "aws.ops-blog"
}