
resource "aws_ec2_transit_gateway" "London-TGW1" {
    provider = aws.eu-west-2
  tags = {
    Name: "London-TGW1"
  }
}
output "TGW-Peer-attach-ID-London" {
  value       = aws_ec2_transit_gateway.London-TGW1.id
  description = "TGW ID"
}


resource "aws_ec2_transit_gateway_vpc_attachment" "Private-VPC-London-TG-attach" {
    provider = aws.eu-west-2
  subnet_ids         = [aws_subnet.private-eu-west-2a.id, aws_subnet.private-eu-west-2b.id]
  transit_gateway_id = aws_ec2_transit_gateway.London-TGW1.id
  vpc_id             = aws_vpc.app1-London.id
  transit_gateway_default_route_table_association = false #or  by default associate to default London-TGW-Route-table
  transit_gateway_default_route_table_propagation = false #or  by default propagate to default London-TGW-Route-table
}





resource "aws_ec2_transit_gateway_route_table" "London-TG-Route-Table" { #TGW route table London
    provider = aws.eu-west-2 
  transit_gateway_id = aws_ec2_transit_gateway.London-TGW1.id 
}

resource "aws_ec2_transit_gateway_route_table_association" "London-TGW1_Association" { #Associates London-VPC-TGW-attach to London-TGW-Route-Table
    provider = aws.eu-west-2
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.Private-VPC-London-TG-attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.London-TG-Route-Table.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "London-TGW1_Propagation" { #Propagates London-VPC-TGW-attach to London-TGW-Route-Table
    provider = aws.eu-west-2
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.Private-VPC-London-TG-attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.London-TG-Route-Table.id
}




resource "aws_ec2_transit_gateway_peering_attachment_accepter" "London_Japan_Peer_Accepter" { #accept peer
  provider = aws.eu-west-2
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.Japan_London_Peer.id
  tags = {
    Name = "London-Japan-Peer-Accepter"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "London-to-Japan-TGW1_Peer_Association" { #Associates London-Japan-TGW-Peer to London-TGW-Route-Table
    provider = aws.eu-west-2
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.London_Japan_Peer_Accepter.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.London-TG-Route-Table.id
  replace_existing_association = true #removes default TGW-Route-Table-Association so you can Associate with the one specified in your code
}

resource "aws_ec2_transit_gateway_route" "London_to_Japan_Route" { #Route on TG London -> to -> Japan
    provider = aws.eu-west-2
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.London-TG-Route-Table.id
  destination_cidr_block         = "10.150.0.0/16"  # CIDR block of the VPC in sa-east-1
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.Japan_London_Peer.id
}
