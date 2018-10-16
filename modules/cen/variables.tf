variable "name" {
  description = "Solution Name"
}

variable "region_ids" {
  type = "list"
  description = "RegionIds deployment"
}

variable "vpc_ids" {
  type = "list"
  description = "VpcIds deployment"
}

variable "bandwidth" {
  description = "CEN Bandwidth package (unit Mbps)"
}