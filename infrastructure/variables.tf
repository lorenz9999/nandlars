variable "aws_region" {
  description = "AWS region for the S3 bucket. CloudFront is global."
  type        = string
  default     = "eu-central-1"
}

variable "bucket_name_prefix" {
  description = "Prefix for the globally unique S3 bucket name. Lowercase letters, numbers and hyphens only."
  type        = string
  default     = "nandlars-site"

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,50}[a-z0-9]$", var.bucket_name_prefix))
    error_message = "bucket_name_prefix must contain 3–52 lowercase letters, numbers or hyphens and may not start or end with a hyphen."
  }
}

variable "github_repository" {
  description = "GitHub repository allowed to deploy, in OWNER/REPOSITORY form."
  type        = string

  validation {
    condition     = can(regex("^[^/]+/[^/]+$", var.github_repository))
    error_message = "github_repository must use OWNER/REPOSITORY form."
  }
}
