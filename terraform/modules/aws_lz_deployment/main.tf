data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

resource "aws_controltower_landing_zone" "lz" {
  manifest_json  = templatefile(var.template_path, {
    governed_regions   = jsonencode(var.governed_regions)
    security_ou_name   = var.security_ou_name
    sandbox_ou_name    = var.sandbox_ou_name
    log_account_id     = var.log_account_id
    sec_account_id     = var.sec_account_id
    log_retention_days = var.log_retention_days
    kms_key_arn        = aws_kms_key.kms_key.arn
  })

  version       = var.aws_landing_zone_version

  timeouts {            # Defining timeout to ensure Control Tower Landing zone has ample time to be created, modified or deleted
    create = "75m"
    update = "75m"
    delete = "2h"
  }  

  depends_on = [ 
    aws_kms_key.kms_key,
    aws_kms_alias.kms_key
  ]
}

resource "aws_kms_key" "kms_key" {
  description             = "Symmetric encryption KMS key for Landing Zone resources"
  enable_key_rotation     = true

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Id": "key-default-1",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
                    "${data.aws_caller_identity.current.arn}"
                ]
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow AWS Config to use KMS for encryption",
            "Effect": "Allow",
            "Principal": {
                "Service": "config.amazonaws.com"
            },
            "Action": [
                "kms:Decrypt",
                "kms:GenerateDataKey"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow CloudTrail to use KMS for encryption",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudtrail.amazonaws.com"
            },
            "Action": [
                "kms:GenerateDataKey*",
                "kms:Decrypt"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "aws:SourceArn": "arn:aws:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:trail/aws-controltower-BaselineCloudTrail"
                },
                "StringLike": {
                    "kms:EncryptionContext:aws:cloudtrail:arn": "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"
                }
            }
        }
    ]
}
EOF
}

resource "aws_kms_alias" "kms_key" {
  name          = "alias/lz-key"
  target_key_id = aws_kms_key.kms_key.key_id
}
