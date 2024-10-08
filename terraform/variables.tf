#################################
## 01. Organization/LZ base setup

# NOTE: Update account names and root emails in main.tf, configure rest of the information below

variable "organization_root_id" {
  type = string
  default = ""
}

variable "organization_trusted_role_name" {
  type = string
  default = "OrganizationAccountAccessRole"
}

variable "close_on_deletion" {
  type = bool
  default = true
}

variable "iam_user_access_to_billing" {
  type = string
  default = "ALLOW"  
}

##############################
## 02. Landing zone deployment

variable "governed_regions" {
  type = list(string)
  default = ["us-east-1"]
}

variable "security_ou_name" {
  type    = string
  default = "Security OU"
}

variable "sandbox_ou_name" {
  type    = string
  default = "Sandbox OU"
}

variable "log_retention_days" {
  type = number
  default = 365
}
