resource "aws_s3_bucket" "sandeep_s3bucket" {
  bucket = var.bucket_name

}

resource "aws_s3_bucket_versioning" "version" {
  count = var.versioning ? 1:0
  bucket = aws_s3_bucket.sandeep_s3bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "owner_ctrl" {
  bucket = aws_s3_bucket.sandeep_s3bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "prvt_acl" {
  count = var.public_acl ? 0:1

  bucket = aws_s3_bucket.sandeep_s3bucket.id

  depends_on = [ aws_s3_bucket_ownership_controls.owner_ctrl]

  acl = "private"
}

resource "aws_s3_bucket_public_access_block" "bucket_access" {
  count = var.public_acl ? 1:0

  bucket = aws_s3_bucket.sandeep_s3bucket.id

  block_public_acls = false
  block_public_policy = false
  restrict_public_buckets = false
  ignore_public_acls = false
}

resource "aws_s3_bucket_acl" "public_acl" {
   count = var.public_acl ? 1:0

  bucket = aws_s3_bucket.sandeep_s3bucket.id

  depends_on = [ aws_s3_bucket_ownership_controls.owner_ctrl, aws_s3_bucket_public_access_block.bucket_access ]

  acl = "public-read"
}