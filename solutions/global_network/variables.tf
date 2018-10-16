variable "name" {
  description = "Solution Name"
}

variable "region_id_A" {
  description = "RegionId deployment"
}

variable "cidr_A" {
  description = "CIDR range to use for the VPC"
}

variable "az_count_A" {
  description = "Number of availability zones to use"
  default = 2
}

variable "region_id_B" {
  description = "RegionId deployment"
}

variable "cidr_B" {
  description = "CIDR range to use for the VPC"
}

variable "az_count_B" {
  description = "Number of availability zones to use"
  default = 2
}

variable "bandwidth" {
  description = "CEN Bandwidth package (unit Mbps)"
  default = 2
}