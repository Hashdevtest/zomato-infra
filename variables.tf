variable "project" {
default = "zomato"
description = "project name"
}

variable "environment" {
default = "production"
description = "project environment"
}


variable "region" {
  description = "amazon region"
  type = string
  default = "ap-south-1"
}

variable "instance_ami" {
  default = "ami-0e742cca61fb65051"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "key" {
  default = "aws"
}
