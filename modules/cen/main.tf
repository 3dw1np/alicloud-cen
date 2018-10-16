resource "alicloud_cen_instance" "cen" {
  name = "${var.name}"
}

resource "alicloud_cen_instance_attachment" "vpc_attach_A" {
  instance_id              = "${alicloud_cen_instance.cen.id}"
  child_instance_id        = "${var.vpc_ids[0]}"
  child_instance_region_id = "${var.region_ids[0]}"
}

resource "alicloud_cen_instance_attachment" "vpc_attach_B" {
  instance_id              = "${alicloud_cen_instance.cen.id}"
  child_instance_id        = "${var.vpc_ids[1]}"
  child_instance_region_id = "${var.region_ids[1]}"
}

resource "alicloud_cen_bandwidth_package" "bwp" {
  bandwidth             = "${var.bandwidth}"
  period                = 1
  charge_type           = "PrePaid"
  geographic_region_ids = ["China", "Europe"]
}

resource "alicloud_cen_bandwidth_package_attachment" "bwp_attach" {
  instance_id          = "${alicloud_cen_instance.cen.id}"
  bandwidth_package_id = "${alicloud_cen_bandwidth_package.bwp.id}"
}

resource "alicloud_cen_bandwidth_limit" "bwp_limit" {
  instance_id     = "${alicloud_cen_instance.cen.id}"
  region_ids      = "${var.region_ids}"
  bandwidth_limit = "${var.bandwidth}"
  depends_on      = [
    "alicloud_cen_bandwidth_package_attachment.bwp_attach",
    "alicloud_cen_instance_attachment.vpc_attach_A",
    "alicloud_cen_instance_attachment.vpc_attach_B"]
}