output "iam_group_id" {
    description = "The group's ID"
    value       = aws_iam_group.iam_group[*].id
}

output "iam_group_arn" {
    description = "The ARN assigned by AWS for this group."
    value       = aws_iam_group.iam_group[*].arn
}

output "iam_group_name" {
    description = "The group's name"
    value       = aws_iam_group.iam_group[*].name
}

output "iam_group_path" {
    description = "The path of the group in IAM."
    value       = aws_iam_group.iam_group[*].path
}

output "iam_group_unique_id" {
    description = "The unique ID assigned by AWS."
    value       = aws_iam_group.iam_group[*].unique_id
}

output "iam_group_membership_name" {
    description = "The name to identify the Group Membership"
    value       = aws_iam_group_membership.iam_group_attach[*].name
}

output "iam_users_add_in_group" {
    description = "list of IAM User names"
    value       = aws_iam_group_membership.iam_group_attach[*].users
}

output "iam_group_membership_groupname" {
    description = "IAM Group name"
    value       = aws_iam_group_membership.iam_group_attach[*].group
}