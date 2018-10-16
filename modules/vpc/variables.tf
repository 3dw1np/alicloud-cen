variable "name" {
  description = "Solution Name"
}

variable "region_id" {
  description = "RegionId deployment"
}

variable "cidr" {
  description = "CIDR range to use for the VPC"
}

variable "az_count" {
  description = "Number of availability zones to use"
  default = 2
}