resource "aws_s3_bucket" "state_bucket" {
  bucket = "terraform-statefile-s3-bucket"
  acl    = "private"
  count  = 1
  versioning {
    enabled = true
  }
}
resource "aws_flow_log" "my_vpc_flow_log" {
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.my_vpc.id
}