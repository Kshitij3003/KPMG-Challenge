resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
}

# Create an Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}
# Attach the Internet Gateway to the VPC
resource "aws_internet_gateway_attachment" "igw_attachment" {
  count = var.attach_igw ? 1 : 0
  vpc_id = aws_vpc.my_vpc.id
  internet_gateway_id = aws_internet_gateway.my_igw.id
}

# Public Subnet Configuration
resource "aws_subnet" "public_subnet-az1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.10.0/24"
  availability_zone       = var.azs[0]
  map_public_ip_on_launch = true
}
# Public Subnet Configuration
resource "aws_subnet" "public_subnet-az2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.11.0/24"
  availability_zone       = var.azs[1]
  map_public_ip_on_launch = true
}
# Public Security Group Configuration
resource "aws_security_group" "public_sg" {
  name        = "public-sg"
  description = "Security group for the public EC2 instance"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22  # SSH
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allowing HTTP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow outbound traffic to anywhere
  }
}

# Create a Route Table for the public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
}
# Associate the public subnet with the public route table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id = aws_subnet.public_subnet-az1.id
  route_table_id = aws_route_table.public_route_table.id
}
# Create a default route for the public subnet
resource "aws_route" "public_route" {
  route_table_id = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.my_igw.id
}



# Private Subnet Configuration
resource "aws_subnet" "private_subnet-az1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.azs[0]
  map_public_ip_on_launch = false
}
# Private Subnet Configuration
resource "aws_subnet" "private_subnet-az2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = var.azs[1]
  map_public_ip_on_launch = false
}
# Private Security Group Configuration
resource "aws_security_group" "private_sg" {
  name        = "private-sg"
  description = "Security group for the private EC2 instance"
  vpc_id      = aws_vpc.my_vpc.id

  # Add inbound rules to allow access from the public instance only
  ingress {
    from_port                = 22  # SSH
    to_port                  = 22
    protocol                 = "tcp"
    security_groups        = [aws_security_group.public_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow outbound traffic to anywhere
  }
}
# Create a Route Table for the private subnet
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id
}
# Associate the public subnet with the private route table
resource "aws_route_table_association" "private_subnet_association" {
  subnet_id = aws_subnet.private_subnet-az1.id
  route_table_id = aws_route_table.private_route_table.id
}
# Create a default route for the private subnet
resource "aws_route" "private_route" {
  route_table_id = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.my-natgateway.id
}



