module "jenkins2_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.30.0"

  name = "jenkins2_vpc_${var.team_name}_${var.environment}"

  enable_dns_hostnames = true
  enable_dns_support   = true

  cidr = "10.0.0.0/16"

  azs            = ["${local.configured_az}"]
  public_subnets = ["${var.public_subnet_cidr}"]

  # enable_nat_gateway = true
  # single_nat_gateway = true

  tags = {
    AvailabilityZone = "${local.configured_region}${local.configured_az}"
    Environment      = "${var.environment}"
    ManagedBy        = "terraform"
    Name             = "jenkins2_vpc_${var.team_name}_${var.environment}"
    Team             = "${var.team_name}"
  }
}
