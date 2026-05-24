
resource "aws_s3_bucket" "my-s3-bucket" {
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_object" "my_object" {
  bucket = aws_s3_bucket.my-s3-bucket.id
  key    = "myfile.txt"
  source = "../../etags/myfile.txt"
  etag   = filemd5("../../etags/myfile.txt")
}

output "object_etag" {
  value = aws_s3_object.my_object.etag
}