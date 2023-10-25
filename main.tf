terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.22.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}


resource "aws_vpc" "amvn1" {
  cidr_block = var.netork_Cidr
  tags = {
    name = local.name
  }
}

resource "aws_subnet" "trail_subnets" {
  count      = var.subnets_count
  vpc_id     = aws_vpc.amvn1.id
  cidr_block = var.amvsubnets_ranges[count.index]

  tags = {
    Name = var.subnets_names[count.index]
  }
  depends_on = [aws_vpc.amvn1]
}