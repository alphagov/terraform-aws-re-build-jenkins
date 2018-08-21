locals {
  default_server_user_data = "${file(coalesce(var.append_server_user_data,"${path.module}/cloud-init/worker-${local.ubuntu_release}"))}"
}

data "template_file" "jenkins2_asg_server_template" {
  template = "${local.default_server_user_data}"

  depends_on = ["aws_efs_file_system.jenkins2_efs_server"]

  vars {
    awsaz                = "${local.configured_az}"
    awsenv               = "${var.environment}"
    efs_file_system      = "${aws_efs_file_system.jenkins2_efs_server.id}"
    fqdn                 = "${var.server_name}.${var.environment}.${var.team_name}.${var.hostname_suffix}"
    gitrepo              = "${var.gitrepo}"
    gitrepo_branch       = "${var.gitrepo_branch}"
    hostname             = "${var.server_name}.${var.environment}.${var.team_name}.${var.hostname_suffix}"
    jenkins_version      = "${local.jenkins_version}"
    region               = "${local.configured_region}"
    team                 = "${var.team_name}"
    github_admin_users   = "${join(",", var.github_admin_users)}"
    github_client_id     = "${var.github_client_id}"
    github_client_secret = "${var.github_client_secret}"
    github_organisations = "${join(",", var.github_organisations)}"
    jenkins_url          = "https://${var.environment}.${var.team_name}.${var.hostname_suffix}/"
  }
}

data "template_file" "jenkins2_asg_server_custom_template" {
  template = "${file("${var.append_server_user_data}")}"

  depends_on = ["aws_efs_file_system.jenkins2_efs_server"]

  vars {
    awsaz                = "${local.configured_az}"
    awsenv               = "${var.environment}"
    efs_file_system      = "${aws_efs_file_system.jenkins2_efs_server.id}"
    fqdn                 = "${var.server_name}.${var.environment}.${var.team_name}.${var.hostname_suffix}"
    gitrepo              = "${var.gitrepo}"
    gitrepo_branch       = "${var.gitrepo_branch}"
    hostname             = "${var.server_name}.${var.environment}.${var.team_name}.${var.hostname_suffix}"
    jenkins_version      = "${local.jenkins_version}"
    region               = "${local.configured_region}"
    team                 = "${var.team_name}"
    github_admin_users   = "${join(",", var.github_admin_users)}"
    github_client_id     = "${var.github_client_id}"
    github_client_secret = "${var.github_client_secret}"
    github_organisations = "${join(",", var.github_organisations)}"
    jenkins_url          = "https://${var.environment}.${var.team_name}.${var.hostname_suffix}/"
  }
}

data "template_cloudinit_config" "server_cloud_init" {
  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.jenkins2_asg_server_template.rendered}"
  }

  part {
    # It would be nice to use count here, but we cannot yet (https://github.com/hashicorp/terraform/issues/5091). count = "${length(var.append_server_user_data) == 0 ? 0 : 1}"

    content_type = "text/x-shellscript"
    content      = "${data.template_file.jenkins2_asg_server_custom_template.rendered}"
    merge_type   = "list(append)+dict(recurse_array)+str(append)"
  }
}
