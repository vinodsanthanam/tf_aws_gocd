module "networkModule" {
  source               = "./modules/network"
  access_key           = "${var.access_key}"
  secret_key           = "${var.secret_key}"
  region               = "${var.region}"
  environment_tag      = "${var.environment_tag}"
  availability_zone    = "${var.availability_zone}"
  cidr_vpc             = "${var.cidr_vpc}"
  cidr_subnet          = "${var.cidr_subnet}"
}

module "securityGroupModule" {
  source            = "./modules/security"
  access_key        = "${var.access_key}"
  secret_key        = "${var.secret_key}"
  region            = "${var.region}"
  environment_tag   = "${var.environment_tag}"
  availability_zone = "${var.availability_zone}"
  vpc_id            = "${module.networkModule.vpc_id}"
}

module "instanceModule" {
  source             = "./modules/instance"
  access_key         = "${var.access_key}"
  secret_key         = "${var.secret_key}"
  region             = "${var.region}"
  environment_tag    = "${var.environment_tag}"
  availability_zone  = "${var.availability_zone}"
  subnet_public_id   = "${module.networkModule.subnet_public_id}"
  public_key_path    = "${var.public_key_path}"
  security_group_ids = ["${module.securityGroupModule.sg_22}", "${module.securityGroupModule.sg_80}", "${module.securityGroupModule.sg_443}", "${module.securityGroupModule.sg_8153}"]
  instance_ami       = "${var.instance_ami}"
  instance_type      = "${var.instance_type}"
}
