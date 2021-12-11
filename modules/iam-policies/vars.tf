variable "iam_custom_policy_name" {
    description = "The name of the policy. If omitted, Terraform will assign a random, unique name."
    type        = string
    default     = ""
}

variable "iam_custom_policy_path" {
    description = "Path in which to create the policy. See IAM Identifiers for more information. default /"
    type        = string
    default     = "/"
}

variable "iam_custom_policy_description" {
    description = "Description of the IAM policy"
    type        = string
    default     = ""
}

variable "iam_custom_policy_action" {
    description = "The actions you want to take on aws services like ec2, s3, iam and so on"
    type        = list
    default     = ["ec2:Describe*"]
}

variable "iam_custom_policy_resource_name" {
    description = "The name of the resouce on which this policy going to effect. it can be particular resource name where you want to provide access to user or group. it can arn:aws:s3:::mybucket, "
    type        = list
    default     = ["*"]
}

variable "iam_custom_policy_effect" {
    description = "The effect of Custom policy, it can either allow or deny"
    type        = string
    default     = "Allow"
}

variable "iam_custom_policy_attach_user" {
    description = "Do you want to attach this policy to user. if yes, provide true value. Default is false"
    type        = bool
    default     = false
}

variable "iam_custom_policy_attach_users_name" {
    description = "The user(s) the policy should be applied to"
    type        = list
    default     = ["test-user1"]
}

variable "iam_custom_policy_attach_group" {
    description = "Do you want to attach this policy with group, if yes, provide true value. Default is false"
    type        = bool
    default     = false
}

variable "iam_custom_policy_attach_groups_name" {
    description = "The group(s) the policy should be applied to"
    type        = list
    default     = ["test-group1"]
}

variable "iam_custom_policy_attach_role" {
    description = "Do you want to attach this policy with role, if yes, provide true value, Default is false"
    type        = bool
    default     = false
}

variable "iam_custom_policy_attach_roles_name" {
    description = "The role(s) the policy should be applied to"
    type        = list
    default     = ["test-role1"]
}

variable "tags" {
    description = "A mapping of tags to assign to the resource."
    type        = map(string)
}