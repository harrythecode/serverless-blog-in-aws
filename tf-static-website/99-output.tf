
output "s3_bucket_domain" {
    value = aws_s3_bucket.ops_website.bucket_domain_name
}

output "s3_bucket_regional_domain" {
    value = aws_s3_bucket.ops_website.bucket_regional_domain_name
}

output "origin_access_identity" {
    value = aws_cloudfront_origin_access_identity.origin_access_identity
}