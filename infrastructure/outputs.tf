output "website_bucket_name" {
  description = "Set this as the S3_BUCKET_NAME GitHub Actions repository variable."
  value       = aws_s3_bucket.site.bucket
}

output "cloudfront_distribution_id" {
  description = "Set this as the CLOUDFRONT_DISTRIBUTION_ID GitHub Actions repository variable."
  value       = aws_cloudfront_distribution.site.id
}

output "cloudfront_url" {
  description = "Default HTTPS URL supplied by CloudFront."
  value       = "https://${aws_cloudfront_distribution.site.domain_name}"
}

output "github_actions_role_arn" {
  description = "Set this as the AWS_ROLE_TO_ASSUME GitHub Actions repository variable."
  value       = aws_iam_role.github_actions_deploy.arn
}
