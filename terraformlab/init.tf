provider "aws" {
  region = "ap-northeast-1"
}

data "aws_availability_zones" "available" {
  state = "available"
}
