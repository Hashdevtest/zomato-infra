terraform {
  backend "s3" {
    bucket = "tfproject-backend.haashdev.tech"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
