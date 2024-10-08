variable "accounts" {
  description = "A map of account names to their corresponding emails."
  type        = map(string)
}

variable "organization_root_id" {
  type = string
}

variable "organization_trusted_role_name" {
  type = string
}

variable "close_on_deletion" {
  type = bool
  default = true
}

variable "iam_user_access_to_billing" {
  type = string
  default = "ALLOW"  
}
