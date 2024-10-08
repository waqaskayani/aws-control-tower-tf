# aws-control-tower-tf
Repository for provisioning AWS Control Tower and AFT (Account Factory for Terraform). This covers end-to-end implementation, details provided in the readme. 

### Pre-requisites:
Ensure to have the following:
- Terraform and AWS CLI installed
- AWS CLI profile configured with Admin user of the Management/Root account of the Organization
- Update profile name in `./terraform/providers.tf`
- Update following local variables in `./terraform/main.tf`:
    - `audit_account_name`: Account name for Audit/Security account
    - `audit_account_email`: Root account email for Audit/Security account
    - `log_archive_account_name`: Account name for Log Archive account
    - `log_archive_account_email`: Root account email for Log Archive account

### Instructions:
- Ensure AWS Organization is created and Billing budget alerts are setup to track cost usage. This management account will be used as the Control Tower management account, in which you will launch your Control Tower landing zone as well
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

### References
- https://docs.aws.amazon.com/controltower/latest/userguide/walkthrough-api-setup.html
- https://docs.aws.amazon.com/controltower/latest/userguide/lz-api-launch.html
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/controltower_landing_zone
