resource "aws_iam_role" "role" {
  name = "${var.name}-${var.env}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(var.tags, { Name = "${var.name}-${var.env}-role" })
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.name}-${var.env}-role"
  role = aws_iam_role.role.name
}

resource "aws_iam_role_policy" "ssm_ps_policy" {
  name        = "${var.name}-${var.env}-ssm_ps_policy"
  role        = aws_iam_role.role.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": [
          "kms:Decrypt",
          "ssm:GetParameterHistory",
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter"
        ],
        "Resource": [
          var.kms_arn,
          "arn:aws:kms:us-east-1:${data.aws_caller_identity.identity.account_id}:key/97f14d48-2686-4713-9aa1-776591b60d52"
        ]
      }
    ]
  })
}