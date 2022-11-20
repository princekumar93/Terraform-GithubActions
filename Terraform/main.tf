provider "aws" {
    region = "us-east-1"
}


locals {
  bucket_name = "test-terraform-1234-bucket"
}

resource "aws_s3_bucket_object" "object" {
  bucket = local.bucket_name
  for_each = fileset("Terraform-GithubActions/DataFiles/", "*")
  key    = "github/${each.value}"
  source = "Terraform-GithubActions/DataFiles/${each.value}"
  etag = filemd5("Terraform-GithubActions/DataFiles/${each.value}")
}
