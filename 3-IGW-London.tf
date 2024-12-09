resource "aws_internet_gateway" "igw-London" {
  provider = aws.eu-west-2
  vpc_id = aws_vpc.app1-London.id

  tags = {
    Name    = "app1_IGW-London"
    Service = "J-Tele-Doctor"
  }
}
