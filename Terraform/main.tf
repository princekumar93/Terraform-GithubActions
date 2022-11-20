provider "aws" {
    region = "us-east-1"
}

locals {
  bucket_name = "test-terraform-1234-bucket"
}

resource "aws_s3_bucket_object" "file_upload" {
  bucket = local.bucket_name
  for_each = fileset("/DataFiles/", "*")
  key    = "github//${each.value}"
  source = "/DataFiles//${each.value}"
  etag = filemd5("/DataFiles//${each.value}")
}
