#creat a vpc
resource "aws_vpc" "claws" {
  cidr_block         = "10.0.0.0/16"
  instance_tenancy   = "default"
  enable_dns_support = "true"
  enable_classiclink = "false"
  tags = {
    Name = "vprofile_vpc"
  }

}
# subnet
resource "aws_subnet" "claws" {
  cidr_block              = "10.0.1.0/24"
  vpc_id                  = aws_vpc.Claws.id
  map_public_ip_on_launch = "true"
  availability_zone       = var.zone1

  tags = {
    Name = "vprofilepublic1"

  }
}

resource "aws_subnet" "clawspublic2" {
  cidr_block              = "10.0.2.0/24"
  vpc_id                  = aws_vpc.claws.id
  map_public_ip_on_launch = "true"
  availability_zone       = var.zone2

  tags = {
    Name = "vprofilepublic2"

  }
}
resource "aws_subnet" "clawsprivate1" {
  cidr_block              = "10.0.3.0/24"
  vpc_id                  = aws_vpc.claws.id
  map_public_ip_on_launch = "true"
  availability_zone       = var.zone1

  tags = {
    Name = "vprofileprivate1"

  }
}
resource "aws_subnet" "clawsprivate2" {
  cidr_block              = "10.0.4.0/24"
  vpc_id                  = aws_vpc.claws.id
  map_public_ip_on_launch = "true"
  availability_zone       = var.zone2

  tags = {
    Name = "vproprivate2"

  }
}
#internet gateway
resource "aws_internet_gateway" "claws_igw" {
  vpc_id = aws_vpc.claws.id
  tags = {
    Name = "vprofile_igw"

  }
}
resource "aws_route_table" "claws_rtb" {
  vpc_id = aws_vpc.claws.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.claws_igw.id
  }
  tags = {
    Name = "vpro"
  }
}
#route associtons public
resource "aws_route_table_association" "asspub1" {
  route_table_id = aws_route_table.claws_rtb.id
  subnet_id      = aws_subnet.clawspublic1.id
}
resource "aws_route_table_association" "asspub2" {
  route_table_id = aws_route_table.claws_rtb.id
  subnet_id      = aws_subnet.clawspublic2.id
}