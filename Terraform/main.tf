provider "aws" {
    region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "test-terraform-1234-bucket-prod"
    key            = "path/terraform.tfstate"
    region         = "us-east-1"
  }
}

variable "workspacePath" {
}

variable "region" {
    type = string
}

resource "aws_s3_bucket_object" "file_upload" {
  bucket = "test-terraform-1234-bucket-prod"
  for_each = fileset("../DataFiles/", "**")
  key    = "github//${each.value}"
  source = "$../DataFiles//${each.value}"
  etag = filemd5("../DataFiles//${each.value}")
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
