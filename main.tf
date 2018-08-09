terraform {
  required_version = "= 0.11.7"
}

data "aws_region" "provider_region" {}
data "aws_availability_zones" "provider_az" {}

locals {
  configured_region = "${
    length(var.region) == 0
    ? data.aws_region.provider_region.name
    : var.region
  }"

  configured_az = "${
    length(var.az) == 0
    ? data.aws_availability_zones.provider_az.names[1]
    : var.az
  }"
}
