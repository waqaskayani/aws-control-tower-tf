## Control Tower Admin
resource "aws_iam_service_linked_role" "control_tower_service_role" {
  aws_service_name = "controltower.amazonaws.com"
}

resource "aws_iam_role" "control_tower_admin_role" {
  name = "AWSControlTowerAdmin"
  path = "/service-role/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "controltower.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "control_tower_policy_attachment_1" {
  role       = aws_iam_role.control_tower_admin_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSControlTowerServiceRolePolicy"
}

resource "aws_iam_role_policy" "control_tower_admin_policy" {
  name = "AWSControlTowerAdminPolicy"
  role = aws_iam_role.control_tower_admin_role.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ec2:DescribeAvailabilityZones",
            "Resource": "*"
        }
    ]
}
EOF
}


## Control Tower CloudTrail
resource "aws_iam_service_linked_role" "control_tower_cloud_trail_service_role" {
  aws_service_name = "cloudtrail.amazonaws.com"
}

resource "aws_iam_role" "control_tower_cloud_trail_role" {
  name = "AWSControlTowerCloudTrailRole"
  path = "/service-role/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "cloudtrail.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "control_tower_cloud_trail_policy" {
  name = "AWSControlTowerCloudTrailRolePolicy"
  role = aws_iam_role.control_tower_cloud_trail_role.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "logs:CreateLogStream",
            "Resource": "arn:aws:logs:*:*:log-group:aws-controltower/CloudTrailLogs:*",
            "Effect": "Allow"
        },
        {
            "Action": "logs:PutLogEvents",
            "Resource": "arn:aws:logs:*:*:log-group:aws-controltower/CloudTrailLogs:*",
            "Effect": "Allow"
        }
    ]
}
EOF
}


## Control Tower Config Aggregator Role
resource "aws_iam_service_linked_role" "control_tower_config_aggregator_service_role" {
  aws_service_name = "config.amazonaws.com"
}

resource "aws_iam_role" "control_tower_config_aggregator_role" {
  name = "AWSControlTowerConfigAggregatorRoleForOrganizations"
  path = "/service-role/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "config.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "control_tower_config_aggregator_policy_attachment" {
  role       = aws_iam_role.control_tower_config_aggregator_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRoleForOrganizations"
}


### Control Tower StackSet Role
# resource "aws_iam_service_linked_role" "control_tower_stack_set_service_role" {
#   aws_service_name = "cloudformation.amazonaws.com"
# }

resource "aws_iam_role" "control_tower_stack_set_role" {
  name = "AWSControlTowerStackSetRole"
  path = "/service-role/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "cloudformation.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "control_tower_stack_set_policy" {
  name = "AWSControlTowerStackSetRolePolicy"
  role = aws_iam_role.control_tower_stack_set_role.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "sts:AssumeRole"
            ],
            "Resource": [
                "arn:aws:iam::*:role/AWSControlTowerExecution"
            ],
            "Effect": "Allow"
        }
    ]
}
EOF
}
