variable "name" {
  description = "Solution Name"
}

variable "region_id" {
  description = "RegionId deployment"
}

variable "vpc_id" {
  description = "Id of the VPC where to deploy the proxy reverse"
}

variable "vswitch_id" {
  description = "Id of the proxy reverse vswitch"
}

variable "proxy_pass_ip" {
  description = "Private ip address of the proxy server"
}