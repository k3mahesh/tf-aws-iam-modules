resource "aws_iam_group" "iam_group" {
    count = var.create_iam_group ? 1 : 0
    name  = var.iam_group_name
    path  = var.iam_group_path
}

resource "aws_iam_group_membership" "iam_group_attach" {
    count = var.add_user_in_group ? 1 : 0
    name  = var.iam_group_membership_name
    users = var.iam_users_add_in_group
    group = var.iam_group_name
}