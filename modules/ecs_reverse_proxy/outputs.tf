output "private_ip" {
  value = "${alicloud_instance.reverse_proxy.private_ip}"
}