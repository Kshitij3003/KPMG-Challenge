data "aws_key_pair" "my_key_pair" {
  key_name = "Private"  # Replace with the name of your EC2 key pair
}
data "aws_key_pair" "my_public_key_pair" {
  key_name = "Project"  # Replace with the name of your EC2 key pair
}

# Public EC2 Instance Configuration
resource "aws_instance" "public_instance" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  vpc_security_group_ids     = [aws_security_group.public_sg.id]
  subnet_id = aws_subnet.public_subnet-az1.id
  key_name = "Project"
}

# Private EC2 Instance Configuration
resource "aws_instance" "private_instance" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  vpc_security_group_ids     = [aws_security_group.private_sg.id]
  subnet_id = aws_subnet.private_subnet-az1.id
  key_name = "Private"
  user_data = <<-EOF
    #!/bin/bash
    # Write down the command for installing mysql and then after server is luanched, run mysql -h DB_HOST -u DB_USER -p DB_PASSWORD to conect to mysql instance
    # ...
    # Configure the private instance to connect to the RDS instance
    echo "export DB_HOST=${aws_db_instance.my_rds_instance.endpoint}" >> /home/ec2-user/.bashrc
    echo "export DB_USER=${aws_db_instance.my_rds_instance.username}" >> /home/ec2-user/.bashrc
    echo "export DB_PASSWORD=${aws_db_instance.my_rds_instance.password}" >> /home/ec2-user/.bashrc
    source /home/ec2-user/.bashrc
    EOF
}