#These are   for  public

resource "aws_subnet" "public-sa-east-1a" {
  provider = aws.sa-east-1
  vpc_id                  = aws_vpc.app1-Brazil.id
  cidr_block              = "10.153.1.0/24"
  availability_zone       = "sa-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-sa-east-1a"
    Service = "J-Tele-Doctor"
  }
}

resource "aws_subnet" "public-sa-east-1b" {
  provider = aws.sa-east-1
  vpc_id                  = aws_vpc.app1-Brazil.id
  cidr_block              = "10.153.2.0/24"
  availability_zone       = "sa-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-sa-east-1b"
    Service = "J-Tele-Doctor"
  }
}

#these are for private
resource "aws_subnet" "private-sa-east-1a" {
  provider = aws.sa-east-1
  vpc_id            = aws_vpc.app1-Brazil.id
  cidr_block        = "10.153.11.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name    = "private-sa-east-1a"
    Service = "J-Tele-Doctor"
  }
}

resource "aws_subnet" "private-sa-east-1b" {
  provider = aws.sa-east-1
  vpc_id            = aws_vpc.app1-Brazil.id
  cidr_block        = "10.153.12.0/24"
  availability_zone = "sa-east-1b"

  tags = {
    Name    = "private-sa-east-1b"
    Service = "J-Tele-Doctor"
  }
}
