output "vpc_ids" {
  description = "Map of VPC IDs"
  value       = { for k, v in var.vpcs : k => module.vpc[k].id }
}