variable "project" {}
variable "createdBy" {}
variable "environment" {}
variable "owner" {}
variable "account_id" {}

locals {
  tags = {
    Project     = var.project
    createdby   = var.createdBy
    Environment = var.environment
    Owner       = var.owner
  }
}