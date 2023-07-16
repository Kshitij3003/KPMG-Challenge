resource "aws_s3_bucket" "tfstate_bucket" {
  bucket = "terraform-statelist"
  acl    = "private"
  versioning {
    enabled = true
  }
}