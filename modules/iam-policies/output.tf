output "iam_custom_policy_id" {
    description = "The ARN assigned by AWS to this policy."
    value       = aws_iam_policy.iam_policy.id
}

output "iam_custom_policy_arn" {
    description = "The ARN assigned by AWS to this policy."
    value       = aws_iam_policy.iam_policy.arn
}

output "iam_custom_policy_description" {
    description = "The description of the policy."
    value       = aws_iam_policy.iam_policy.description
}

output "iam_custom_policy_name" {
    description = "The name of the policy."
    value       = aws_iam_policy.iam_policy.name
}

output "iam_custom_policy_path" {
    description = "The path of the policy in IAM."
    value       = aws_iam_policy.iam_policy.path
}

output "iam_custom_policy_policy" {
    description = "The policy document."
    value       = aws_iam_policy.iam_policy.policy
}

output "iam_custom_policy_policy_id" {
    description = "The policy's ID."
    value       = aws_iam_policy.iam_policy.policy_id
}