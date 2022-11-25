provider "aws" {
    region = "us-east-1"
}

locals {
  bucket    = "test-terraform-1234-bucket-prod"
  region         = var.region
  key            = "path/terraform.tfstate"
}


locals {
  bucket_name = "test-terraform-1234-bucket"
}

variable "workspacePath" {
}

variable "region" {
    type = string
}

resource "aws_s3_bucket_object" "file_upload" {
  bucket = "test-terraform-1234-bucket-prod"
  for_each = fileset("${var.workspacePath}/DataFiles/", "**")
  key    = "github//${each.value}"
  source = "${var.workspacePath}/DataFiles//${each.value}"
  etag = filemd5("${var.workspacePath}/DataFiles//${each.value}")
}

output "filecount" {
  value = length(fileset("/DataFiles/", "*"))
}

output "workflowspace" {
  value = var.workspacePath
}

output "ouputregion" {
    value = var.region
}
