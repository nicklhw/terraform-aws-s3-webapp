terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.74.3"
    }
  }
}

provider "aws" {
  region = var.region

  assume_role {
    role_arn     = var.aws_dev_role_arn
    session_name = "terraform"
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.prefix}-terramino"
  acl    = "public-read"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.prefix}-terramino/*"
            ]
        }
    ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "error.html"

  }
  force_destroy = true
}

resource "aws_s3_bucket_object" "webapp" {
  acl          = "public-read"
  key          = "index.html"
  bucket       = aws_s3_bucket.bucket.id
  content      = file("${path.module}/assets/index.html")
  content_type = "text/html"

}
