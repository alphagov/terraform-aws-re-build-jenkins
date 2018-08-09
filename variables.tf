variable "allowed_ips" {
  description = "A list of IP addresses permitted to access the EC2 instances created that are running Jenkins"
  type        = "list"
}

variable "az" {
  description = "Single AWS availability zone to place master and worker instances in (a,b,c)"
  type        = "string"
}

variable "docker_version" {
  description = "Docker version to install"
  type        = "string"
}

variable "environment" {
  description = "Environment (test, staging, production, etc)"
  type        = "string"
}

variable "github_admin_users" {
  description = "List of Github admin users"
  type        = "list"
  default     = []
}

variable "github_client_id" {
  description = "Your Github client Id"
  type        = "string"
  default     = ""
}

variable "github_client_secret" {
  description = "Your Github client secret"
  type        = "string"
  default     = ""
}

variable "github_organisations" {
  description = "List of Github organisations and teams that users must be a member of to allow HTTPS login to master"
  type        = "list"
  default     = []
}

variable "gitrepo" {
  description = "Git repository to clone in the default user_data when creating EC2 instances. This defaults to the https://github.com/alphagov/terraform-aws-re-build-jenkins repository"
  type        = "string"
  default     = "https://github.com/alphagov/re-build-systems.git"
}

variable "gitrepo_branch" {
  description = "Branch of repository in gitrepo variable"
  type        = "string"
  default     = "master"
}

variable "hostname_suffix" {
  description = "Main part of the domain name and any subdomains to use when constructing the DNS name for the Jenkins instances"
  type        = "string"
}

variable "jenkins_version" {
  description = "Verson of jenkins to install"
  type        = "string"
  default     = "latest"
}

variable "public_subnet_cidr" {
  description = "CIDR blocks for public subnet"
  type        = "string"
  default     = "10.0.101.0/24"
}

variable "region" {
  description = "AWS Region"
  type        = "string"
}

variable "route53_team_zone_id" {
  description = "The Route53 zone id that hosts the external DNS record"
  type        = "string"
}

variable "server_instance_type" {
  description = "This defines the default master server EC2 instance type"
  type        = "string"
  default     = "t2.small"
}

variable "server_name" {
  description = "Name of the jenkins2 server"
  type        = "string"
  default     = "jenkins2"
}

variable "server_root_volume_size" {
  description = "Size of the Jenkins Server root volume (GB)"
  type        = "string"
  default     = "50"
}

variable "ssh_public_key_file" {
  description = "Path to your ssh public key file"
  type        = "string"
}

variable "team_name" {
  description = "Team Name"
  type        = "string"
}

variable "ubuntu_release" {
  description = "Which version of ubuntu to install on Jenkins server"
  type        = "string"
  default     = "xenial-16.04-amd64-server"
}

variable "worker_instance_type" {
  description = "This defines the default worker server EC2 instance type"
  type        = "string"
  default     = "t2.medium"
}

variable "worker_name" {
  description = "Name of the Jenkins2 worker"
  type        = "string"
  default     = "worker"
}

variable "worker_root_volume_size" {
  description = "Size of the Jenkins worker root volume (GB)"
  type        = "string"
  default     = "50"
}
