# output vpc IDs
output "vpc_ids" {
  description = "Map of VPC IDs"
  value       = { for k, v in var.vpcs : k => module.vpc[k].id }
}

# output subnet IDs
output "subnet_ids" {
  description = "Map of Subnet IDs"
  value       = { for k, v in var.subnets : k => module.subnets[k].id }
}