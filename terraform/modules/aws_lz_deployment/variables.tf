variable "template_path" {
  type = string
}

variable "governed_regions" {
  type = list(string)
}

variable "security_ou_name" {
  type    = string
  default = "Security"
}

variable "sandbox_ou_name" {
  type    = string
  default = "Sandbox"
}

variable "log_retention_days" {
  type = number
  default = 10
}

variable "log_account_id" {
  type = string
}

variable "sec_account_id" {
  type = string
}

variable "aws_landing_zone_version" {
  type = string
  default = "3.3"
}

variable "aws_account_factory_ou_name" {
  type = string
  default = "LZ Account Factory OU"
}

variable "ct_baseline_control_id" {
  type = string
  default = "17BSJV3IGJ2QSGA2"
}

variable "ct_baseline_version" {
  type = string
  default = "4.0"
}