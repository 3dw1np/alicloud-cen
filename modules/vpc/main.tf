data "alicloud_zones" "default" {
  "available_instance_type"= "ecs.sn1ne.2xlarge"
  "available_disk_category"= "cloud_ssd"
}

resource "alicloud_vpc" "default" {
  name        = "${var.name}-${var.region_id}"
  cidr_block  = "${var.cidr}"
}

resource "alicloud_vswitch" "default" {
  name              = "${var.name}-${var.region_id}_${count.index}"
  vpc_id            = "${alicloud_vpc.default.id}"
  cidr_block        = "${cidrsubnet(var.cidr, 8, count.index)}"
  availability_zone = "${lookup(data.alicloud_zones.default.zones[count.index], "id")}"
  count             = "${var.az_count}"
}