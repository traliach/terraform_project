provider "aws" {
  region = "us-west-2"
}

resource "random_integer" "this" {
  min = 1000
  max = 9999
}

resource "aws_s3_bucket" "terraform_backend" {
  bucket = "bootcamp32-${var.env}-${random_integer.this.result}"
  // versioning block removed

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }

  versioning {
    enabled = true
  }

  tags = {
    Name = "Terraform S3 Backend"
    Environment = var.env

  }
}
