output "environment" {
  value = "${var.environment}"
}

output "github_callback_url" {
  description = "Callback uri for Github authentication flow"
  value       = "https://${var.server_name}.${var.environment}.${var.team_name}.${var.hostname_suffix}/securityRealm/finishLogin"
}

output "image_id" {
  description = "Id of AMI used to create EC2 instances"
  value       = "${data.aws_ami.source.id}"
}

output "jenkins2_url" {
  description = "Url of Jenkins instance"
  value       = "https://${var.server_name}.${var.environment}.${var.team_name}.${var.hostname_suffix}"
}

output "jenkins2_vpc_id" {
  description = "The ID of the VPC"
  value       = "${module.jenkins2_vpc.vpc_id}"
}

output "jenkins2_worker_public_ip" {
  description = "jenkins2 worker public IP address"
  value       = ["${module.jenkins2_worker.public_ip}"]
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = ["${module.jenkins2_vpc.public_subnets}"]
}

output "team_zone_id" {
  description = "The Hosted Zone ID"
  value       = "${var.route53_team_zone_id}"
}
