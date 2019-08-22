output "elastic_ip" {
  value = "${module.instanceModule.instance_eip}"
}
