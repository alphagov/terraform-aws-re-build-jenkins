resource "aws_route53_zone" "private_facing" {
  name   = "${var.environment}.${var.team_name}.${local.configured_az}.internal"
  vpc_id = "${module.jenkins2_vpc.vpc_id}"

  tags {
    AvailabilityZone = "${local.configured_az}"
    Environment      = "${var.environment}"
    ManagedBy        = "terraform"
    Name             = "jenkins2_r53_private_${var.team_name}_${var.environment}"
    Team             = "${var.team_name}"
  }
}
