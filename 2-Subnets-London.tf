#These are   for  public

resource "aws_subnet" "public-eu-west-2a" {
  provider = aws.eu-west-2
  vpc_id                  = aws_vpc.app1-London.id
  cidr_block              = "10.152.1.0/24"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-eu-west-2a"
    Service = "J-Tele-Doctor"
  }
}

resource "aws_subnet" "public-eu-west-2b" {
  provider = aws.eu-west-2
  vpc_id                  = aws_vpc.app1-London.id
  cidr_block              = "10.152.2.0/24"
  availability_zone       = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-eu-west-2b"
    Service = "J-Tele-Doctor"
  }
}

#these are for private
resource "aws_subnet" "private-eu-west-2a" {
  provider = aws.eu-west-2
  vpc_id            = aws_vpc.app1-London.id
  cidr_block        = "10.152.11.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name    = "private-eu-west-2a"
    Service = "J-Tele-Doctor"
  }
}

resource "aws_subnet" "private-eu-west-2b" {
  provider = aws.eu-west-2
  vpc_id            = aws_vpc.app1-London.id
  cidr_block        = "10.152.12.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name    = "private-eu-west-2b"
    Service = "J-Tele-Doctor"
  }
}
