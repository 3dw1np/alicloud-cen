provider "alicloud" {
  region = "${var.region_id}"
}

resource "alicloud_security_group" "web" {
  name   = "${var.name}_web_sg"
  vpc_id = "${var.vpc_id}"
}

resource "alicloud_security_group" "ssh" {
  name   = "${var.name}_ssh_sg"
  vpc_id = "${var.vpc_id}"
}

resource "alicloud_security_group_rule" "allow_http_access" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = "${alicloud_security_group.web.id}"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_ssh_access" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = "${alicloud_security_group.ssh.id}"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_instance" "reverse_proxy" {
  instance_name              = "${var.name}_reverse_proxy_srv"
  instance_type              = "ecs.xn4.small"
  system_disk_category       = "cloud_ssd"
  system_disk_size           = 40
  image_id                   = "ubuntu_16_0402_64_20G_alibase_20180409.vhd"

  vswitch_id                 = "${var.vswitch_id}"
  internet_max_bandwidth_out = 1 // Not allocate public IP for this instance

  security_groups            = ["${alicloud_security_group.web.id}", "${alicloud_security_group.ssh.id}"]
  user_data                  = "${data.template_file.user_data.rendered}"
  password                   = "789636Az&"
}

data "template_file" "user_data" {
  template = "${file("${path.module}/tpl/user_data.sh")}"

  vars {
    PROXY_PASS_IP  = "${var.proxy_pass_ip}"
  }
}