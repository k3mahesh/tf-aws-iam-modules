variable "create_iam_role_basic_assume_policy" {
    description = "Create IAM Role with Assume Policy define inside a Role"
    type        = bool
    default     = false
}

variable "iam_role_name" {
    description = "Friendly name of the role. If omitted, Terraform will assign a random, unique name. See IAM Identifiers for more information."
    type        = string
    default     = "test-terraform"
}

variable "iam_role_description" {
    description = "Description of the role."
    type        = string
    default     = "IAM Role"
}

variable "iam_role_force_detach_policies" {
    description = "Whether to force detaching any policies the role has before destroying it. Defaults to false."
    type        = bool
    default     = false
}

variable "iam_role_assume_policy_action" {
    description = "The actions you want to take on aws services like ec2, s3, iam and so on"
    type        = list
    default     = ["ec2:Describe*"]
}

variable "iam_role_assume_policy_resource_name" {
    description = "The name of the resouce on which this policy going to effect. it can be particular resource name where you want to provide access to user or group. it can arn:aws:s3:::mybucket, "
    type        = list
    default     = ["*"]
}

variable "iam_role_assume_policy_effect" {
    description = "The effect of Custom policy, it can either allow or deny"
    type        = string
    default     = "Allow"
}

variable "create_iam_role_managed_policies" {
    description = "Create iam role with Managed Policies and attach these policies in the form of list"
    type        = bool
    default     = false
}

variable "iam_role_managed_policy_arns" {
    description = "Set of exclusive IAM managed policy ARNs to attach to the IAM role. If this attribute is not configured, Terraform will ignore policy attachments to this resource. When configured, Terraform will align the role's managed policy attachments with this set by attaching or detaching managed policies. Configuring an empty set (i.e., managed_policy_arns = []) will cause Terraform to remove all managed policy attachments."
    type        = list
    default     = []
}

variable "create_iam_role_instance_profile" {
    description = "Create iam role with instance profile, if you want to create then provide true, otherwise provide false to skip it. please provide true to create_iam_role_basic_assume_policy variable as well along with it"
    type        = bool
    default     = false
}

variable "iam_role_instance_profile_name" {
    description = "Name of the instance profile. If omitted, Terraform will assign a random, unique name. Conflicts with name_prefix. Can be a string of characters consisting of upper and lowercase alphanumeric characters and these special characters: _, +, =, ,, ., @, -. Spaces are not allowed"
    type        = string
    default     = ""
}

variable "iam_role_instance_profile_path" {
    description = "Path to the instance profile. For more information about paths, see IAM Identifiers in the IAM User Guide. Can be a string of characters consisting of either a forward slash (/) by itself or a string that must begin and end with forward slashes. Can include any ASCII character from the ! (\u0021) through the DEL character (\u007F), including most punctuation characters, digits, and upper and lowercase letters"
    type        = string
    default     = "/"
}

variable "create_iam_role_for_instance_profile_managed_role" {
    description = "If you already have a role and you want to assign it to instance profile, you can provide true value to this one and provide a role name as well in iam_managed_role_name variable"
    type        = bool
    default     = false
}

variable "iam_managed_role_name" {
    description = "Name of the role to add to the profile"
    type        = string
    default     = ""
}

variable "tags" {
    description = "A mapping of tags to assign to the resource."
    type        = map(string)
}