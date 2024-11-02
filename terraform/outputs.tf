output "lz_id" {
  value = module.landing_zone_deployment.lz
}

output "base_ou_names_and_ids" {
  value = module.landing_zone_deployment.ou_names_and_ids
}

output "lz_base_account_ids" {
  value = module.landing_zone_base.account_ids
}
