output "lz" {
  value = aws_controltower_landing_zone.lz.id
}

output "ou_names_and_ids" {
  value = {
    (var.sandbox_ou_name)       = data.aws_organizations_organizational_unit.ou_workload.id
    (var.security_ou_name)      = data.aws_organizations_organizational_unit.ou_security.id
    (var.aws_account_factory_ou_name) = aws_organizations_organizational_unit.account_factory_ou.id
  }
}
