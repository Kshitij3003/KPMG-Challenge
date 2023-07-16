# Create a Flow Log
resource "aws_flow_log" "my_flow_log" {
  iam_role_arn = var.vpc_flow_iam_role  # Specify the ARN of the IAM role for Flow Logs
  log_destination = var.vpc_flow_log_destination  # Specify the ARN of the CloudWatch Logs log group
  traffic_type = "ALL"
  vpc_id = aws_vpc.my_vpc.id
}