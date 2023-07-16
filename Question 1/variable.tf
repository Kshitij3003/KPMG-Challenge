variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden"
  default     = "10.0.0.0/16"
}

variable "azs"{
  default = ["us-east-1a","us-east-1b"]
}

variable "vpc_database_subnets" {
  type        = list
  description = "A list of database subnets inside the VPC"
  default     = ["10.0.20.0/23","10.0.22.0/23"]
}

variable "attach_igw" {
  default = false
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "instance_ami" {
  type = string
  default = "ami-06ca3ca175f37dd66"
}

variable "db_instance_type" {
  type = string
  default = "db.t3.micro"
}

variable "db_engine" {
  type = string
  default = "5.7"
}

variable "db_name" {
  type = string
  default = "RDSInstance"
}

variable "db_username" {
  type = string
  default = "member"
}

variable "db_password" {
  type = string
  default = "#*1Kk2RHwjbQ!9y672lLX"
}

variable "vpc_flow_iam_role" {
  type = string
  default = "arn:aws:iam::066167066263:role/vpc-flow-log"
}

variable "vpc_flow_log_destination" {
  type = string
  default = "arn:aws:logs:us-east-1:066167066263:log-group:vpc-flow-log-group"
}