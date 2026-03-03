resource "aws_vpc_peering_connection" "roboshop-default" {
 count = var.is_peering_required ? 1 : 0
  peer_vpc_id   = data.aws_vpc.default_vpc.id 
  vpc_id        = aws_vpc.main.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  auto_accept = true 

    tags = merge(
    var.vpc_tags,
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-default" 
    }
  )

}

#roboshop vpc - deafult vpc peering routes
resource "aws_route" "roboshop-default-public-peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id            = aws_route_table.public.id 
  destination_cidr_block    = data.aws_vpc.default_vpc.cidr_block
  gateway_id = aws_vpc_peering_connection.roboshop-default[count.index].id 
}

resource "aws_route" "roboshop-default-private-peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id            = aws_route_table.private.id 
  destination_cidr_block    = data.aws_vpc.default_vpc.cidr_block
  gateway_id = aws_vpc_peering_connection.roboshop-default[count.index].id 
}

#default vpc - roboshop vpc peering routes
resource "aws_route" "roboshop-default-database-peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id            = aws_route_table.database.id 
  destination_cidr_block    = data.aws_vpc.default_vpc.cidr_block
  gateway_id = aws_vpc_peering_connection.roboshop-default[count.index].id 
}

#default vpc to roboshop vpc peering route
resource "aws_route" "default-roboshop-peering" {
  count = var.is_peering_required ? 1 : 0

  route_table_id         = data.aws_vpc.default_vpc.main_route_table_id
  destination_cidr_block = aws_vpc.main.cidr_block
  gateway_id             = aws_vpc_peering_connection.roboshop-default[count.index].id
}

# resource "aws_route" "default-roboshop-public-peering" {
#   count = var.is_peering_required ? 1 : 0
#   route_table_id            = data.aws_vpc.default_vpc.main_route_table_id
#   destination_cidr_block    = aws_vpc.main.cidr_block
#   gateway_id = aws_vpc_peering_connection.roboshop-default[count.index].id 
# }

# resource "aws_route" "default-roboshop-private-peering" {
#   count = var.is_peering_required ? 1 : 0
#   route_table_id            = data.aws_vpc.default_vpc.main_route_table_id 
#   destination_cidr_block    = aws_vpc.main.cidr_block
#   gateway_id = aws_vpc_peering_connection.roboshop-default[count.index].id 
# }

# resource "aws_route" "default-roboshop-database-peering" {
#   count = var.is_peering_required ? 1 : 0
#   route_table_id            = data.aws_vpc.default_vpc.main_route_table_id 
#   destination_cidr_block    = aws_vpc.main.cidr_block
#   gateway_id = aws_vpc_peering_connection.roboshop-default[count.index].id 
# }

