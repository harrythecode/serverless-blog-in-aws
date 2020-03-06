# Create bucket for shared state
resource "aws_s3_bucket" "ops_website" {
  bucket   = var.aws_s3_bucketname
  acl      = "private"
  provider = "aws.ops-blog"
  region   = var.aws_region

  versioning {
    enabled = true
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
    principals {
      type        = "AWS"
      identifiers = [var.tf_state_role_arn, aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
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
  provider = "aws.ops-blog"
}

resource "aws_s3_bucket_public_access_block" "ops_website" {
  bucket                  = aws_s3_bucket.ops_website.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  
  provider = "aws.ops-blog"
}