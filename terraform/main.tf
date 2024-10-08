locals {

  # Enter each accounts name and root email
  audit_account_name       = ""
  audit_account_email      = ""
  log_archive_account_name = ""
  log_archive_account_email = ""

  # Create corresponding mapping of each account name to email
  accounts = {
    (local.audit_account_name)       = local.audit_account_email
    (local.log_archive_account_name) = local.log_archive_account_email
  }
}

module "landing_zone_base" {
  source  = "./modules/aws_lz_prereqs"
  accounts = local.accounts
  
  organization_root_id           = var.organization_root_id
  organization_trusted_role_name = var.organization_trusted_role_name
}

module "landing_zone_deployment" {
  source  = "./modules/aws_lz_deployment"

  template_path      = "${path.module}/templates/landing_zone_manifest.json.tpl"
  governed_regions   = var.governed_regions
  security_ou_name   = var.security_ou_name
  sandbox_ou_name    = var.sandbox_ou_name
  log_account_id     = module.landing_zone_base.account_ids[local.log_archive_account_name]
  sec_account_id     = module.landing_zone_base.account_ids[local.audit_account_name]
  log_retention_days = var.log_retention_days

  depends_on = [ 
    module.landing_zone_base
  ]
}
