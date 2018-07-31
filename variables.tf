# #### DNS preferences (from https://github.com/alphagov/terraform-aws-re-build-dns)

variable route53_team_zone_id {
  description = "The Route53 zone id, obtained from using https://github.com/alphagov/terraform-aws-re-build-dns or elsewhere"
  type        = "string"
}

# #### AWS preferences ####

variable "allowed_ips" {
  description = "A list of IP addresses permitted to access the EC2 instances created that are running Jenkins"
  type        = "list"
}

variable "aws_region" {
  description = "AWS region"
  type        = "string"
  default     = "eu-west-2"
}

variable "aws_az" {
  description = "AWS availability zone. Note that this must exist in the region specified in the aws_region variable"
  type        = "string"
  default     = "eu-west-2a"
}

variable "aws_profile" {
  description = "AWS profile name from ~/.aws/credentials or wherever your AWS credentials are stored"
  type        = "string"
}

variable "instance_type" {
  description = "This defines the default (AWS) instance type"
  type        = "string"
  default     = "t2.small"
}

variable "public_subnet_cidr" {
  description = "CIDR blocks for public subnet"
  type        = "string"
  default     = "10.0.101.0/24"
}

variable "ssh_public_key_file" {
  description = "Path to your ssh public key file"
  type        = "string"
}

# #### Environment preferences ####

variable "environment" {
  description = "Environment (test, staging, production, etc)"
  type        = "string"
}

# #### Github preferences ####

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
  description = "List of Github organisations"
  type        = "list"
  default     = []
}

variable "gitrepo" {
  description = "Git repository to clone in the default user_data when creating EC2 instances. This defaults to the https://github.com/alphagov/terraform-aws-re-build-jenkins repository"
  type        = "string"
  default     = "https://github.com/alphagov/terraform-aws-re-build-jenkins"
}

variable "gitrepo_branch" {
  description = "Branch of repository in gitrepo variable"
  type        = "string"
  default     = "master"
}

# #### Docker and Jenkins preferences ####

variable "dockerversion" {
  description = "Docker version to install"
  type        = "string"
}

variable "hostname_suffix" {
  description = "Main part of the domain name and any subdomains to use when constructing the DNS name for the Jenkins instances"
  type        = "string"
}

variable "server_name" {
  description = "Name of the jenkins2 server"
  type        = "string"
}

variable "server_root_volume_size" {
  description = "Size of the Jenkins Server root volume (GB)"
  type        = "string"
  default     = "50"
}

variable "team_name" {
  description = "Team Name"
  type        = "string"
  default     = "team2"
}

variable "ubuntu_release" {
  description = "Which version of ubuntu to install on Jenkins server"
  type        = "string"
  default     = "xenial-16.04-amd64-server"
}

variable "worker_instance_type" {
  description = "This defines the default (AWS) instance type"
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

# #### Advanced preferences ####

# Only touch these if you know what you're doing!
variable "user_data" {
  description = "Link to cloud init file containing setup information for Jenkins worker server instance. You do not need to set this - it defaults to a sensible value"
  type        = "string"
  default     = ""
}
