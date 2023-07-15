resource "aws_db_instance" "my_rds_instance" {
  identifier              = "my-db-instance"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t3.micro"
  allocated_storage       = 10
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.private_sg.id]
  //backup_retention_period = 7
  auto_minor_version_upgrade = true
  skip_final_snapshot = true
  db_name           = "RDSInstance"
  username       = "member"
  password       = "#*1Kk2RHwjbQ!9y672lLX"
}

# Private Subnet Configuration
resource "aws_subnet" "private_rds_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.vpc_private_subnets[0]
  availability_zone       = var.azs[0]
}
# Private Subnet Configuration
resource "aws_subnet" "private_rds_subnet-1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.vpc_private_subnets[1]
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