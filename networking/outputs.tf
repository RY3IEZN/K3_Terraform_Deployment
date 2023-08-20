# networking outputs

output "name" {
  value       = "aws_vpc.k3_vpc.id"
  description = "k3_vpc_cidr"
}


output "db_subnet_group_name" {
  value = aws_db_subnet_group.k3_rds_subnet_group.*.name
}

output "db_security_group" {
  value = [aws_security_group.k3_sg["rds"].id]
}