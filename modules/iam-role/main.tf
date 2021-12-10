resource "aws_iam_role" "iam_role" {
    count                 = var.create_iam_role_basic_assume_policy ? 1 : 0
    name                  = var.iam_role_name
    description           = var.iam_role_description
    force_detach_policies = var.iam_role_force_detach_policies

    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [    
      {
        Action = var.iam_role_assume_policy_action,
        Effect   = var.iam_role_assume_policy_effect
        Resource = var.iam_role_assume_policy_resource_name
      },
    ]
  })

    tags  = var.tags
}

resource "aws_iam_role" "iam_role_managed_policy_arn" {
    count                 = var.create_iam_role_managed_policies ? 1 : 0
    name                  = var.iam_role_name
    description           = var.iam_role_description
    force_detach_policies = var.iam_role_force_detach_policies
    managed_policy_arns   = var.iam_role_managed_policy_arns

    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [    
      {
        Action = var.iam_role_assume_policy_action,
        Effect   = var.iam_role_assume_policy_effect
        Resource = var.iam_role_assume_policy_resource_name
      },
    ]
  })

    tags  = var.tags
}

resource "aws_iam_instance_profile" "iam_role_instance_profile" {
    count = var.create_iam_role_instance_profile && var.create_iam_role_basic_assume_policy ? 1 : 0
    name  = var.iam_role_instance_profile_name
    path  = var.iam_role_instance_profile_path
    role  = aws_iam_role.iam_role[count.index].name

    tags  = var.tags
}

resource "aws_iam_instance_profile" "iam_role_instance_profile_managed_role" {
    count = var.create_iam_role_for_instance_profile_managed_role ? 1 : 0
    name  = var.iam_role_instance_profile_name
    path  = var.iam_role_instance_profile_path
    role  = var.iam_managed_role_name

    tags  = var.tags
}