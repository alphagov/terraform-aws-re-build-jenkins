module "jenkins2_worker" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "1.5.0"
  name                        = "${var.worker_name}.${var.environment}.${var.team_name}.${var.hostname_suffix}"
  ami                         = "${data.aws_ami.source.id}"
  instance_type               = "${var.worker_instance_type}"
  associate_public_ip_address = true
  user_data                   = "${data.template_cloudinit_config.jenkins2_worker_cloud_init.rendered}"
  key_name                    = "jenkins2_key_${var.team_name}_${var.environment}"
  monitoring                  = true
  vpc_security_group_ids      = ["${module.jenkins2_sg_worker.this_security_group_id}"]
  subnet_id                   = "${element(module.jenkins2_vpc.public_subnets,0)}"

  root_block_device = [{
    volume_size           = "${var.worker_root_volume_size}"
    delete_on_termination = "true"
  }]

  tags {
    AvailabilityZone = "${local.configured_az}"
    Environment      = "${var.environment}"
    ManagedBy        = "terraform"
    Name             = "jenkins2_worker_ec2_${var.team_name}_${var.environment}"
    Team             = "${var.team_name}"
    Type             = "Jenkins-worker"
  }
}

resource "aws_route53_record" "jenkins2_worker_private" {
  zone_id = "${aws_route53_zone.private_facing.zone_id}"
  name    = "${var.worker_name}"
  type    = "A"
  ttl     = "300"
  records = ["${module.jenkins2_worker.private_ip}"]
}
