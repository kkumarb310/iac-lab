output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.this.cidr_block
}

output "public_subnet_ids" {
  description = "Map of availability zone to public subnet ID"
  value       = { for k, v in aws_subnet.public : k => v.id }
}

output "private_subnet_ids" {
  description = "Map of availability zone to private subnet ID"
  value       = { for k, v in aws_subnet.private : k => v.id }
}

output "nat_gateway_id" {
  description = "ID of the NAT gateway"
  value       = aws_nat_gateway.this.id
}

output "internet_gateway_id" {
  description = "ID of the internet gateway"
  value       = aws_internet_gateway.this.id
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.private.id
}

output "default_security_group_id" {
  description = "ID of the locked-down default security group"
  value       = aws_default_security_group.this.id
}

output "flow_log_id" {
  description = "ID of the VPC Flow Log (null if disabled)"
  value       = var.enable_flow_logs ? aws_flow_log.this[0].id : null
}

output "flow_log_group_arn" {
  description = "ARN of the CloudWatch log group for VPC Flow Logs (null if disabled)"
  value       = var.enable_flow_logs ? aws_cloudwatch_log_group.flow_log[0].arn : null
}
