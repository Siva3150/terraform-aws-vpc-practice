output "vpc_id" {
    value = aws_vpc.main.id 
  
}

output "public-subnet_ids" {
    value = aws_subnet.public[*].id
  
}

output "private-subnet_ids" {
    value = aws_subnet.private[*].id
  
}

output "database-subnet_ids" {
    value = aws_subnet.database[*].id
  
}

# output "default_vpc_id" {
#   value = data.aws_vpc.default_vpc.id
# }

