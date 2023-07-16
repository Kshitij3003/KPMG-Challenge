# Create a CloudWatch metric alarm for the public instance
resource "aws_cloudwatch_metric_alarm" "public_instance_alarm" {
  alarm_name = "public-instance-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 60
  statistic = "Average"
  threshold = 80
  alarm_description = "This metric monitors the CPU utilization of the public instance"
  dimensions = {
    InstanceId = aws_instance.public_instance.id
  }
}

# Create a CloudWatch metric alarm for the private instance
resource "aws_cloudwatch_metric_alarm" "private_instance_alarm" {
  alarm_name = "private-instance-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 60
  statistic = "Average"
  threshold = 80
  alarm_description = "This metric monitors the CPU utilization of the private instance"
  dimensions = {
    InstanceId = aws_instance.private_instance.id
  }
}
