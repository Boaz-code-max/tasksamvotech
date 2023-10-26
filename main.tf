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
  cidr_block = cidrsubnet(var.netork_Cidr, 8, count.index)

  tags = {
    Name = var.subnets_names[count.index]
  }
  depends_on = [aws_vpc.amvn1]
}

data "aws_route_table" "default" {
  vpc_id = aws_vpc.amvn1.id


}

resource "aws_internet_gateway" "amvgw" {
  vpc_id = aws_vpc.amvn1.id

  tags = {
    Name = "amigw"
  }
}


resource "aws_route" "amvr" {
  route_table_id         = data.aws_route_table.default.id
  destination_cidr_block = local.anywhere
  gateway_id             = aws_internet_gateway.amvgw.id

  depends_on = [
    aws_vpc.amvn1,
    aws_internet_gateway.amvgw
  ]
}