locals {
  # Create corresponding mapping of each account name to email directly from variables
  accounts = {
    (var.audit_account_info["name"])       = var.audit_account_info["email"]
    (var.log_archive_account_info["name"]) = var.log_archive_account_info["email"]
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
  log_account_id     = module.landing_zone_base.account_ids[var.log_archive_account_info["name"]]
  sec_account_id     = module.landing_zone_base.account_ids[var.audit_account_info["name"]]
  log_retention_days = var.log_retention_days

  depends_on = [ 
    module.landing_zone_base
  ]
}
