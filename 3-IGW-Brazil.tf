resource "aws_internet_gateway" "igw-Brazil" {
  provider = aws.sa-east-1
  vpc_id = aws_vpc.app1-Brazil.id

  tags = {
    Name    = "app1_IGW-Brazil"
    Service = "J-Tele-Doctor"
  }
}
