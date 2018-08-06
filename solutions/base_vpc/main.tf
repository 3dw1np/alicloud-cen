provider "alicloud" {}

module "vpc" {
  source    = "../../modules/vpc"
  region_id = "${var.region_id}"
  name      = "${var.name}"
  cidr      = "${var.cidr}"
  az_count  = "${var.az_count}"
}