resource "aws_vpc" "trl2" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "amvvpc"
  }
}

resource "aws_subnet" "sub1" {
  vpc_id            = aws_vpc.trl2.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "amvsub"
  }
  depends_on = [aws_vpc.trl2]
}

resource "aws_security_group" "tlsg" {
  name        = "amvsg"
  description = "for sg"
  vpc_id      = aws_vpc.trl2.id

  ingress {
    description = "for ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]

  }

  tags = {
    Name = "amvsg"

  }
  depends_on = [aws_vpc.trl2]
}

data "aws_route_table" "trdefault" {
  vpc_id     = aws_vpc.trl2.id
  depends_on = [aws_vpc.trl2]
}

resource "aws_internet_gateway" "trlgw" {
  vpc_id = aws_vpc.trl2.id

  tags = {
    Name = "amvigw"
  }
  depends_on = [aws_vpc.trl2, data.aws_route_table.trdefault]
}
resource "aws_route" "r" {
  route_table_id         = data.aws_route_table.trdefault.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.trlgw.id

  depends_on = [aws_vpc.trl2,
  aws_internet_gateway.trlgw]
}


resource "aws_instance" "trlec2" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  associate_public_ip_address = true
  instance_type          = "t2.micro"
  key_name               = "Boaz1"
  subnet_id              = aws_subnet.sub1.id
  vpc_security_group_ids = [aws_security_group.tlsg.id]
  tags = {
    Name = "amvec2"
  }
}