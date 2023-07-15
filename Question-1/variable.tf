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

variable "vpc_public_subnets" {
  type        = list
  description = "A list of public subnets inside the VPC"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "vpc_private_subnets" {
  type        = list
  description = "A list of private subnets inside the VPC"
  default     = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
}

variable "vpc_database_subnets" {
  type        = list
  description = "A list of database subnets inside the VPC"
  default     = ["10.0.21.0/23", "10.0.22.0/23", "10.0.23.0/23"]
}

variable "attach_igw" {
  default = false
}