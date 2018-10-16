module "vpc_A" {
  source    = "../../modules/vpc"
  region_id = "${var.region_id_A}"
  name      = "${var.name}"
  cidr      = "${var.cidr_A}"
  az_count  = "${var.az_count_A}"
}

module "vpc_B" {
  source    = "../../modules/vpc"
  region_id = "${var.region_id_B}"
  name      = "${var.name}"
  cidr      = "${var.cidr_B}"
  az_count  = "${var.az_count_B}"
}

module "cen" {
  source     = "../../modules/cen"
  region_ids = ["${var.region_id_A}", "${var.region_id_B}"]
  vpc_ids    = ["${module.vpc_A.vpc_id}", "${module.vpc_B.vpc_id}"]
  name       = "${var.name}"
  bandwidth  = "${var.bandwidth}"
}