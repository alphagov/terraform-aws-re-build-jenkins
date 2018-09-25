module "jenkins2_sg_worker" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "1.22.0"

  name        = "jenkins2_sg_worker_${var.team_name}_${var.environment}"
  description = "Jenkins2 Security Group Allowing HTTP and SSH"
  vpc_id      = "${module.jenkins2_vpc.vpc_id}"

  egress_rules = ["all-all"]

  ingress_cidr_blocks = ["${var.public_subnet_cidr}"]
  ingress_rules       = ["ssh-tcp"]

  ingress_with_source_security_group_id = [
    {
      from_port                = 2375
      to_port                  = 2375
      protocol                 = "tcp"
      description              = "Server connecting to Docker API"
      source_security_group_id = "${module.jenkins2_sg_asg_server_internal.this_security_group_id}"
    },
  ]
}
