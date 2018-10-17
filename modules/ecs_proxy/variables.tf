variable "name" {
  description = "Solution Name"
}

variable "region_id" {
  description = "RegionId deployment"
}

variable "vpc_id" {
  description = "Id of the VPC where to deploy the proxy pass"
}

variable "vswitch_id" {
  description = "Id of the proxy pass vswitch"
}

variable "allow_network_cidr" {
  description = "CIDR block of the reverse proxy"
}