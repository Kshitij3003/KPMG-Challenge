resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
}

# Public Subnet Configuration
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.vpc_public_subnets[0]
  availability_zone       = var.azs[0]
  map_public_ip_on_launch = true
}

# Private Subnet Configuration
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.vpc_private_subnets[2]
  availability_zone       = var.azs[0]
  map_public_ip_on_launch = false
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

# Create a Route Table for the public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
}
# Create a default route for the public subnet
resource "aws_route" "public_route" {
  route_table_id = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.my_igw.id
}
# Associate the public subnet with the public route table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

