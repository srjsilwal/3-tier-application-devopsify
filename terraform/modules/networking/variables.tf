variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_1_cidr" {
  type = string
}

variable "public_subnet_2_cidr" {
  type = string
}

variable "private_subnet_1_cidr" {
  type = string
}

variable "private_subnet_2_cidr" {
  type = string
}

variable "internet_gateway_name" {
  type = string
}

variable "public_subnet_1_az" {
  default = "us-east-1a"
  type = string
}

variable "public_subnet_2_az" {
  default = "us-east-1b"
  type = string
}

variable "private_subnet_1_az" {
  default = "us-east-1a"
  type = string
}

variable "private_subnet_2_az" {
  default = "us-east-1b"
  type = string
}