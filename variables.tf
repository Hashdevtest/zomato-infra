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
