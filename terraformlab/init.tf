provider "aws" {
  access_key = "[YOUR ACCESS KEY ID]"

  region = "ap-northeast-1"
}

data "aws_availability_zones" "available" {
  state = "available"
}
