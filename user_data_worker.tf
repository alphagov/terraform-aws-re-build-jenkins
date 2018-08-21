locals {
  default_worker_user_data = "${file(coalesce(var.append_worker_user_data,"${path.module}/cloud-init/worker_specific_cloud_init.bash"))}"
}

data "template_file" "jenkins2_worker_template" {
  template = "${local.default_worker_user_data}"

  vars {
    awsaz    = "${local.configured_az}"
    awsenv   = "${var.environment}"
    fqdn     = "${var.worker_name}.${var.environment}.${var.team_name}.${var.hostname_suffix}"
    hostname = "${var.worker_name}.${var.environment}.${var.team_name}.${var.hostname_suffix}"
    team     = "${var.team_name}"
  }
}

data "template_file" "jenkins2_worker_custom_template" {
  template = "${file("${var.append_worker_user_data}")}"

  vars {
    awsaz    = "${local.configured_az}"
    awsenv   = "${var.environment}"
    fqdn     = "${var.worker_name}.${var.environment}.${var.team_name}.${var.hostname_suffix}"
    hostname = "${var.worker_name}.${var.environment}.${var.team_name}.${var.hostname_suffix}"
    team     = "${var.team_name}"
  }
}

data "template_cloudinit_config" "jenkins2_worker_cloud_init" {
  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.jenkins2_worker_template.rendered}"
  }

  part {
    # It would be nice to use count here, but we cannot yet (https://github.com/hashicorp/terraform/issues/5091). count = "${length(var.append_worker_user_data) == 0 ? 0 : 1}"

    content_type = "text/x-shellscript"
    content      = "${data.template_file.jenkins2_worker_custom_template.rendered}"
    merge_type   = "list(append)+dict(recurse_array)+str(append)"
  }
}
