#!/usr/bin/env bash
# Deploy helper for a future S3 + CloudFront setup. It creates no AWS resources.
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <s3-bucket-name>" >&2
  exit 1
fi

aws s3 sync . "s3://$1" \
  --exclude ".git/*" \
  --exclude ".gitignore" \
  --exclude "README.md" \
  --exclude "deploy/*" \
  --delete \
  --cache-control "public, max-age=300"

echo "Upload complete. Create a CloudFront invalidation separately after configuring a distribution."
