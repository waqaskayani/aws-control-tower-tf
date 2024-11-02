data "aws_organizations_organization" "org" {}

data "aws_organizations_organizational_units" "ou_root" {
  parent_id = data.aws_organizations_organization.org.roots[0].id
}

data "aws_organizations_organizational_unit" "ou_workload" {
  parent_id = data.aws_organizations_organization.org.roots[0].id
  name      = var.sandbox_ou_name

  depends_on = [ aws_controltower_landing_zone.lz ]
}

data "aws_organizations_organizational_unit" "ou_security" {
  parent_id = data.aws_organizations_organization.org.roots[0].id
  name      = var.security_ou_name

  depends_on = [ aws_controltower_landing_zone.lz ]
}
