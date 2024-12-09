
resource "aws_ec2_transit_gateway" "Brazil-TGW1" {
    provider = aws.sa-east-1
  tags = {
    Name: "Brazil-TGW1"
  }
}
output "TGW-Peer-attach-ID-Brazil" {
  value       = aws_ec2_transit_gateway.Brazil-TGW1.id
  description = "TGW ID"
}


resource "aws_ec2_transit_gateway_vpc_attachment" "Private-VPC-Brazil-TG-attach" {
    provider = aws.sa-east-1
  subnet_ids         = [aws_subnet.private-sa-east-1a.id, aws_subnet.private-sa-east-1b.id]
  transit_gateway_id = aws_ec2_transit_gateway.Brazil-TGW1.id
  vpc_id             = aws_vpc.app1-Brazil.id
  transit_gateway_default_route_table_association = false #or  by default associate to default Brazil-TGW-Route-table
  transit_gateway_default_route_table_propagation = false #or  by default propagate to default Brazil-TGW-Route-table
}





resource "aws_ec2_transit_gateway_route_table" "Brazil-TG-Route-Table" { #TGW route table Brazil
    provider = aws.sa-east-1 
  transit_gateway_id = aws_ec2_transit_gateway.Brazil-TGW1.id 
}

resource "aws_ec2_transit_gateway_route_table_association" "Brazil-TGW1_Association" { #Associates Brazil-VPC-TGW-attach to Brazil-TGW-Route-Table
    provider = aws.sa-east-1
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.Private-VPC-Brazil-TG-attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Brazil-TG-Route-Table.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "Brazil-TGW1_Propagation" { #Propagates Brazil-VPC-TGW-attach to Brazil-TGW-Route-Table
    provider = aws.sa-east-1
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.Private-VPC-Brazil-TG-attach.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Brazil-TG-Route-Table.id
}




resource "aws_ec2_transit_gateway_peering_attachment_accepter" "Brazil_Japan_Peer_Accepter" { #accept peer
  provider = aws.sa-east-1
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.Japan_Brazil_Peer.id
  tags = {
    Name = "Brazil-Japan-Peer-Accepter"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "Brazil-to-Japan-TGW1_Peer_Association" { #Associates Brazil-Japan-TGW-Peer to Brazil-TGW-Route-Table
    provider = aws.sa-east-1
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment_accepter.Brazil_Japan_Peer_Accepter.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Brazil-TG-Route-Table.id
  replace_existing_association = true #removes default TGW-Route-Table-Association so you can Associate with the one specified in your code
}

resource "aws_ec2_transit_gateway_route" "Brazil_to_Japan_Route" { #Route on TG Brazil -> to -> Japan
    provider = aws.sa-east-1
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.Brazil-TG-Route-Table.id
  destination_cidr_block         = "10.150.0.0/16"  # CIDR block of the VPC in sa-east-1
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.Japan_Brazil_Peer.id
}
##
