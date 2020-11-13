provider "aws" {
  profile="devinabox"
  region="us-east-1"
}

resource "aws_vpc" "vpc" {
  cidr_block = "172.31.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    "Source" = var.origin_tag
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Source" = var.origin_tag
  }
}

resource "aws_subnet" "subnet_public" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "172.31.32.0/20"
  map_public_ip_on_launch = "true"
  tags = {
    "Source" = var.origin_tag
    "Type" = "Public"
  }
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "Source" = var.origin_tag
  }
}

resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.rtb_public.id

}

resource "aws_key_pair" "ec2key" {
  key_name = "publicKey"
  public_key = file(var.public_key_path)
}

resource "aws_security_group" "sg_22" {
  name = "devinaboxSG"
  vpc_id = aws_vpc.vpc.id
  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port   = 30000
      to_port     = 30000
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Source" = var.origin_tag
  }
}

data "aws_ami" "packer" {
  most_recent = true
  filter {
    name = "name"
    values = ["dev-in-a-box-2-2-*"]
  }
  owners = ["self"]
}

resource "aws_instance" "instance" {
  ami           = data.aws_ami.packer.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.subnet_public.id
  vpc_security_group_ids = [aws_security_group.sg_22.id]
  key_name = aws_key_pair.ec2key.key_name

  credit_specification {
    cpu_credits = "unlimited"
  }

  root_block_device {
    volume_size = 50
    volume_type = "gp2"
  }

  tags = {
        "Source" = var.origin_tag
        "Name" = "DevInABox"
  }
}
