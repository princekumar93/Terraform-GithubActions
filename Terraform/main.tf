provider "aws" {
    region = "us-east-1"
}

locals {
  bucket_name = "test-terraform-1234-bucket"
}

variable "workspacePath" {
}

resource "aws_s3_bucket_object" "file_upload" {
  bucket = local.bucket_name
  for_each = fileset("${workspacePath}/DataFiles/", "*")
  key    = "github//${each.value}"
  source = "${workspacePath}/DataFiles//${each.value}"
  etag = filemd5("${workspacePath}/DataFiles//${each.value}")
}

output "filecount" {
  value = length(fileset("/DataFiles/", "*"))
}
