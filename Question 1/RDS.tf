resource "aws_db_instance" "my_rds_instance" {
  identifier              = "my-db-instance"
  engine                  = "mysql"
  engine_version          = var.db_engine
  instance_class          = var.db_instance_type
  allocated_storage       = 10
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.private_sg.id]
  //backup_retention_period = 7
  auto_minor_version_upgrade = true
  skip_final_snapshot = true
  db_name           = var.db_name
  username       = var.db_username
  password       = var.db_password
}

# Private Subnet Configuration
resource "aws_subnet" "private_rds_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.vpc_database_subnets[0]
  availability_zone       = var.azs[0]
}
# Private Subnet Configuration
resource "aws_subnet" "private_rds_subnet-1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.vpc_database_subnets[1]
  availability_zone       = var.azs[1]
}
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "my-rds-subnet"
  description = "My DB subnet group"
  subnet_ids = [
    aws_subnet.private_rds_subnet.id,
    aws_subnet.private_rds_subnet-1.id
  ]
}
# Create a security group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Security group for RDS"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.private_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}