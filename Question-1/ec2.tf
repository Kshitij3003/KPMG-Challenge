//data "aws_ami" "ubuntu" {
//  most_recent = true
//  owners      = ["amazon"]
//  filter {
//    name   = "architecture"
//    values = ["i386, x86_64"]
//  }
//}
data "aws_key_pair" "my_key_pair" {
  key_name = "Private"  # Replace with the name of your EC2 key pair
}
data "aws_key_pair" "my_public_key_pair" {
  key_name = "Project"  # Replace with the name of your EC2 key pair
}
data "aws_security_group" "public_sg" {
  id = aws_security_group.public_sg.id
}

data "aws_security_group" "private_sg" {
  id = aws_security_group.private_sg.id
}
locals {
  public_subnet=aws_subnet.public_subnet.id
}
locals {
  private_subnet=aws_subnet.private_subnet.id
}

# Public EC2 Instance Configuration
resource "aws_instance" "public_instance" {
  ami           = "ami-06ca3ca175f37dd66"
  instance_type = "t2.micro"
  vpc_security_group_ids     = [data.aws_security_group.public_sg.id]
  subnet_id = aws_subnet.public_subnet.id
  key_name = "Project"
}

# Private EC2 Instance Configuration
resource "aws_instance" "private_instance" {
  ami           = "ami-06ca3ca175f37dd66"
  instance_type = "t2.micro"
  vpc_security_group_ids     = [data.aws_security_group.private_sg.id]
  subnet_id = aws_subnet.private_subnet.id
  key_name = "Private"
}


