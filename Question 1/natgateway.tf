# Create an Elastic IP for the NAT Gateway
resource "aws_eip" "nat_gateway_eip" {
  vpc = true
}

resource "aws_nat_gateway" "my-natgateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.public_subnet-az1.id
  tags = {
    Name = "gw NAT"
  }
}