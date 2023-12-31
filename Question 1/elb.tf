resource "aws_lb" "my_elb" {
  name = "my-elb"
  load_balancer_type = "application"
  subnets = [aws_subnet.public_subnet-az1.id,aws_subnet.public_subnet-az2.id]
  security_groups = [aws_security_group.public_sg.id]
}

resource "aws_lb_target_group" "elb_target_group" {
  name     = "elb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
}

# Create the ELB attachment
resource "aws_lb_target_group_attachment" "my_elb_attachment" {
  count            = 2
  target_group_arn = aws_lb_target_group.elb_target_group.arn
  target_id = aws_instance.private_instance.id
  port = 80
}