variable "create_iam_group" {
    description = "Provide true value if you want to create the group otherwise please provide false value. default is false"
    type        = bool
    default     = false
}

variable "iam_group_name" {
    description = "The group's name. The name must consist of upper and lowercase alphanumeric characters with no spaces. You can also include any of the following characters: =,.@-_.. Group names are not distinguished by case. For example, you cannot create groups named both ADMINS and admins."
    type        = string
    default     = ""
}

variable "iam_group_path" {
    description = "(Optional, default /) Path in which to create the group."
    type        = string
    default     = ""
}

variable "add_user_in_group" {
    description = "Do you want to attach group with us"
    type        = bool
    default     = true
}

variable "iam_group_membership_name" {
    description = "The name to identify the Group Membership"
    type        = string
    default     = ""
}

variable "iam_users_add_in_group" {
    description = "A list of IAM User names to associate with the Group"
    type        = list
    default     = []
}