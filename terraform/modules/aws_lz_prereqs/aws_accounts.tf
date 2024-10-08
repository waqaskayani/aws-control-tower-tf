resource "aws_organizations_account" "account" {
  for_each          = var.accounts
  name              = each.key
  email             = each.value

  parent_id         = var.organization_root_id                # Parent Organizational Unit ID or Root ID for the account. Defaults to the Organization default Root ID.
  role_name         = var.organization_trusted_role_name      # The name of an IAM role that Organizations automatically preconfigures in the new member account. This role trusts the root account.
  close_on_deletion = var.close_on_deletion                   # If true, a deletion event will close the account. Otherwise, it will only remove from the organization.
  iam_user_access_to_billing = var.iam_user_access_to_billing # If set to ALLOW, the new account enables IAM users and roles to access account billing information if they have the required permissions.

  lifecycle {
    ignore_changes = [ parent_id ]                            # Ignored as Account will later be moved into Landing Zone managed OUs
  }
}

output "account_ids" {
  value       = { for key, account in aws_organizations_account.account : key => account.id }
}
