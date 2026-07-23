variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "db_password" {
  type      = string
  sensitive = true
}