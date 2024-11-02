# aws-control-tower-tf
Repository for provisioning AWS Control Tower and AFT (Account Factory for Terraform). This covers end-to-end implementation, details provided in the readme. 

### Pre-requisites:
Ensure to have the following:
- Terraform and AWS CLI installed.
- AWS Organization created and Billing budget alerts are setup to track cost usage. This management account will be used as the Control Tower management account, in which you will launch your Control Tower landing zone as well.
- AWS CLI profile configured with Admin user of the Management/Root account of the Organization.

### Instructions:
- Fill in the required variables in `./terraform/variables.tf`:
    - `aws_profile`: Default AWS profile for Terraform provider
    - `organization_root_id`: AWS Organization Root ID
    - `audit_account_info`: Desired account name and email for Audit/Security account
    - `log_archive_account_info`: Desired account name and email for Log Archive account
    - `governed_regions`: Governed regions for AWS Control Tower Landing Zone
- Deploy module `landing_zone_base` first
    ```bash
    $ terraform apply -target=module.landing_zone_base
    ```
- Refresh AWS Organization [console](https://us-east-1.console.aws.amazon.com/organizations/v2/home/accounts) to view the Accounts created
- Afterwards deploy `landing_zone_deployment` module
    ```bash
    $ terraform apply -target=module.landing_zone_deployment
    ```
- Review AWS Control Tower [console](https://us-east-1.console.aws.amazon.com/controltower/home) to view Control Tower and Landing Zone setup.
- Register `Account Factory OU` within the Control Tower.

### Known issues
- There's a known issue with landing_zone_manifest Control tower. When making changes in the terraform code ensure to remove double quotes from `${log_retention_days}` defined in manifest json template file, and then apply. Afterwards, add the double quotes again, otherwise it will always show a change while planning.

### References
- https://docs.aws.amazon.com/controltower/latest/userguide/walkthrough-api-setup.html
- https://docs.aws.amazon.com/controltower/latest/userguide/lz-api-launch.html
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/controltower_landing_zone
- https://docs.aws.amazon.com/controltower/latest/userguide/table-of-baselines.html
