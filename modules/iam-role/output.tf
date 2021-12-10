output "iam_role_arn" {
    description = "Amazon Resource Name (ARN) specifying the role."
    value       = aws_iam_role.iam_role[*].arn
}

output "iam_role_create_date" {
    description = "Creation date of the IAM role."
    value       = aws_iam_role.iam_role[*].create_date
}

output "iam_role_id" {
    description = "Name of the role."
    value       = aws_iam_role.iam_role[*].id
}

output "iam_role_name" {
    description = "Name of the role."
    value       = aws_iam_role.iam_role[*].name
}

output "iam_role_unique_id" {
    description = "Stable and unique string identifying the role."
    value       = aws_iam_role.iam_role[*].unique_id
}

output "iam_role_instance_profile_arn" {
    description = "ARN assigned by AWS to the instance profile"
    value       = aws_iam_instance_profile.iam_role_instance_profile[*].arn
}

output "iam_role_instance_profile__managed_role_name" {
    description = "ARN assigned by AWS to the instance profile"
    value       = aws_iam_instance_profile.iam_role_instance_profile_managed_role[*].arn
}

output "iam_role_instance_profile_id" {
    description = "Instance profile's ID"
    value       = aws_iam_instance_profile.iam_role_instance_profile[*].id
}

output "iam_role_instance_profile_managed_role_id" {
    description = "Instance profile's ID"
    value       = aws_iam_instance_profile.iam_role_instance_profile_managed_role[*].id
}

output "iam_role_instance_profile_unique_id" {
    description = "Unique ID assigned by AWS"
    value       = aws_iam_instance_profile.iam_role_instance_profile[*].unique_id
}

output "iam_role_instance_profile_managed_role_unique_id" {
    description = "Unique ID assigned by AWS"
    value       = aws_iam_instance_profile.iam_role_instance_profile_managed_role[*].unique_id
}