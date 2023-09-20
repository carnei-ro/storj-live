# ------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# ------------------------------------------------------------------------------

# Version constraints
terraform_version_constraint  = ">= 1.4.6"
terragrunt_version_constraint = ">= 0.45.0"

# Local aliases for improved maintainability
locals {
  repo_root = get_repo_root()

  storj_project_name = split("/", get_path_from_repo_root())[0]

  # Automatically load account variables
  project_vars = read_terragrunt_config(format("%s/%s/project.hcl", local.repo_root, local.storj_project_name)).locals

  # Automatically Terraform Cloud variables
  terraform_cloud = read_terragrunt_config(format("%s/terraform_cloud.hcl", local.repo_root)).locals
}

# Copy the first .tool-versions file found in the directory hierarchy when blueprint has none,
# otherwise skip and use one defined in blueprint.
# NOTE: requires ASDF-VM (https://asdf-vm.com)
generate "tool_versions" {
  path      = ".tool-versions"
  if_exists = "skip"
  contents  = file(find_in_parent_folders(".tool-versions"))
}

# Generate the STORJ provider config
generate "storj_provider" {
  path      = "_tg-storj-provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    provider "storj" {
      access_grant = "${local.project_vars.storj_access_grant}"
    }
  EOF
}

# Generate the Backend config
generate "backend" {
  path      = "_backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    terraform {
      required_providers {
        storj = {
          source = "F21/storj"
          version = "0.0.2-fork1"
          # source = "storj/storj"
          # version = "0.0.1"
        }
      }
      cloud {
        organization = "${local.terraform_cloud.organization}"

        workspaces {
          name = "${sha256(path_relative_to_include())}"
        }
      }
    }
  EOF
}

retry_max_attempts       = 3
retry_sleep_interval_sec = 5

retryable_errors = [
]

# Automatically fill the "var.access_grant" variables - no need to explicitly set it in the "terragrunt.hcl" child files
inputs = {
  access_grant = local.project_vars.storj_access_grant
}
