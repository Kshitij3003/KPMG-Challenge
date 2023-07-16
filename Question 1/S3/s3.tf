resource "aws_s3_bucket" "tfstate_bucket" {
  bucket = "terraform-statelist"
  acl    = "private"
  count  = 1
  versioning {
    enabled = true
  }
}