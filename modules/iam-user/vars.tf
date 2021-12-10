variable "iam_user_names" {
    description = "IAM User"
    type        = list
    default     = []
}

variable "iam_user_paths" {
    description = "Path in which to create the user."
    type        = list
    default     = []
}

variable "create_iam_user_login_profile" {
    description = "Create IAM User login profile or not, Manages an IAM User Login Profile with limited support for password creation during Terraform resource creation."
    type        = bool
    default     = false
}

variable "iam_user_pgp_keys" {
    description = "Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Only applies on resource creation. Drift detection is not possible with this argument."
    type        = list
    default     = []
}

variable "iam_user_password_length" {
    description = "The length of the generated password on resource creation. Only applies on resource creation. Drift detection is not possible with this argument."
    type        = string
    default     = "20"
}

variable "iam_user_password_reset_required" {
    description = "Whether the user should be forced to reset the generated password on resource creation. Only applies on resource creation. Drift detection is not possible with this argument."
    type        = bool
    default     = true
}

variable "create_iam_access_key" {
    description = "Do you want to create a access keys for iam user or not, if you putt true then access keys will be created"
    type        = bool
    default     = false
}

// variable "create_iam_access_key_with_pgp_key" {
//     description = "Create IAM Access keys with PGP Key Encryption"
//     type        = bool
//     default     = false
// }

// variable "iam_user_access_key_pgp_key" {
//     description = "Either a base-64 encoded PGP public key, or a keybase username in the form keybase:some_person_that_exists, for use in the encrypted_secret output attribute."
//     type        = list
//     default     = []
// }

variable "iam_user_add_ssh_key" {
    description = "Do you want add ssh key with iam user or not, True for add ssh key"
    type        = bool
    default     = false
}

variable "iam_user_public_key_encoding" {
    description = "Specifies the public key encoding format to use in the response. To retrieve the public key in ssh-rsa format, use SSH. To retrieve the public key in PEM format, use PEM."
    type        = list
    default     = []
}

variable "iam_user_public_ssh_keys" {
    description = "The SSH public key. The public key must be encoded in ssh-rsa format or PEM format."
    type        = list
    default     = []
}

variable "tags" {
    description = "A mapping of tags to assign to the resource."
    type        = map(string)
}

variable "iam_user_pass_minimum_password_length" {
    description = "Minimum length to require for user passwords"
    type        = string
    default     = "8"
}

variable "iam_user_pass_require_lowercase_characters" {
    description = "Whether to require lowercase characters for user passwords."
    type        = bool
    default     = true
}

variable "iam_user_pass_require_numbers" {
    description = "Whether to require numbers for user passwords."
    type        = bool
    default     = true
}

variable "iam_user_pass_require_uppercase_characters" {
    description = "Whether to require uppercase characters for user passwords."
    type        = bool
    default     = true
}

variable "iam_user_pass_require_symbols" {
    description = "Whether to require symbols for user passwords."
    type        = bool
    default     = true
}

variable "iam_user_pass_allow_users_to_change_password" {
    description = "Whether to allow users to change their own password"
    type        = bool
    default     = true
}

variable "iam_user_pass_max_password_age" {
    description = "The number of days that an user password is valid."
    type        = string
    default     = "180"
}
