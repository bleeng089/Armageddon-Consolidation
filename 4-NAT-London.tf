resource "aws_eip" "nat-London" { #elastic IP
provider = aws.eu-west-2
  domain = "vpc"

  tags = {
    Name = "nat-London"
  }
}

resource "aws_nat_gateway" "nat-London" {
  provider = aws.eu-west-2
  allocation_id = aws_eip.nat-London.id #.nat references aws_eip.nat object
  subnet_id     = aws_subnet.public-eu-west-2a.id 

  tags = {
    Name = "nat-London"
  }

  depends_on = [aws_internet_gateway.igw-London] # ensures terraform creates IGW before creating this resource(NGW). NGW depend on IGW
}
