terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.44.0"
    }
  }
}

provider "aws" {
  # Configuration options
}


resource "aws_s3_bucket" "default" {
}

resource "aws_s3_object" "my_object" {
  bucket = aws_s3_bucket.my-s3-bucket.id
  key    = "myfile.txt"
  source = "/path/to/myfile.txt"
  etag   = filemd5("/path/to/myfile.txt")
}