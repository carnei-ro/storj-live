terraform {
  before_hook "patch_terraform_cloud_workspace_execution_mode" {
    commands = ["apply", "plan"]
    execute = [
      "sh",
      "-c",
      <<-EOC
        ${local.repo_root}/_hack/patch-terraform-cloud-workspace-execution-mode.sh \
        ${local.terraform_cloud.organization} \
        ${local.terraform_cloud_workspace}
      EOC
    ]
  }
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_root                 = get_repo_root()
  terraform_cloud           = read_terragrunt_config(find_in_parent_folders("terraform_cloud.hcl")).locals
  terraform_cloud_workspace = sha256(path_relative_to_include())
}

dependency "photos_bucket" {
  config_path = "../../../buckets/photos"
}

inputs = {
  bucket = [{
    name  = dependency.photos_bucket.outputs.bucket_id
    paths = []
  }]

  allow_download = true
  allow_upload   = true
  allow_list     = true
  allow_delete   = true
}
