{
    "governedRegions": ${governed_regions},
    "organizationStructure": {
        "security": {
            "name": "${security_ou_name}"
        },
        "sandbox": {
            "name": "${sandbox_ou_name}"
        }
    },
    "centralizedLogging": {
         "accountId": "${log_account_id}",
         "configurations": {
             "loggingBucket": {
                 "retentionDays": "${log_retention_days}"
             },
             "accessLoggingBucket": {
                 "retentionDays": "${log_retention_days}"
             },
             "kmsKeyArn": "${kms_key_arn}"
         },
         "enabled": true
    },
    "securityRoles": {
         "accountId": "${sec_account_id}"
    },
    "accessManagement": {
         "enabled": true
    }
}
