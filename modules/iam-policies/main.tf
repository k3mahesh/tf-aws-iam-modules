resource "aws_iam_policy" "iam_policy"{
    name        = var.iam_custom_policy_name
    path        = var.iam_custom_policy_path
    description = var.iam_custom_policy_description

    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [    
      {
        Action = var.iam_custom_policy_action
        Effect   = var.iam_custom_policy_effect
        Resource = var.iam_custom_policy_resource_name
      },
    ]
  })

    tags  = var.tags
}

resource "aws_iam_user_policy_attachment" "policy_attach_user" {
    count      = var.iam_custom_policy_attach_user ? length(var.iam_custom_policy_attach_users_name) : 0
    user       = var.iam_custom_policy_attach_users_name[count.index]
    policy_arn = aws_iam_policy.iam_policy.arn
}

resource "aws_iam_group_policy_attachment" "policy_attach_group" {
    count      = var.iam_custom_policy_attach_group ? length(var.iam_custom_policy_attach_groups_name) : 0
    group      = var.iam_custom_policy_attach_groups_name[count.index]
    policy_arn = aws_iam_policy.iam_policy.arn
}

resource "aws_iam_role_policy_attachment" "policy_attach_role" {
    count      = var.iam_custom_policy_attach_role ? length(var.iam_custom_policy_attach_roles_name) : 0
    role       = var.iam_custom_policy_attach_roles_name[count.index]
    policy_arn = aws_iam_policy.iam_policy.arn
}

