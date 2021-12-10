resource "aws_iam_user" "user" {
    count = length(var.iam_user_names)
    name  = var.iam_user_names[count.index]
    path  = var.iam_user_paths[count.index]

    tags  = var.tags
}

resource "aws_iam_user_login_profile" "login_profile" {
    count                   = var.create_iam_user_login_profile ? length(var.iam_user_names) : 0
    user                    = aws_iam_user.user[count.index].name
    pgp_key                 = var.iam_user_pgp_keys[count.index]
    password_length         = var.iam_user_password_length
    password_reset_required = var.iam_user_password_reset_required
}

resource "aws_iam_access_key" "access_keys" {
    count = var.create_iam_access_key ? length(var.iam_user_names) : 0
    user  = aws_iam_user.user[count.index].name
}

// resource "aws_iam_access_key" "access_keys_with_pgp_key" {
//     count   = var.iam_user_add_ssh_key && var.create_iam_access_key_with_pgp_key ? length(var.iam_user_names) : 0
//     user    = aws_iam_user.user[count.index].name
//     pgp_key = var.iam_user_pgp_keys[count.index]
// }

resource "aws_iam_user_ssh_key" "user_ssh_key" {
    count    = var.iam_user_add_ssh_key ? length(var.iam_user_names) : 0
    username = aws_iam_user.user[count.index].name
    encoding = var.iam_user_public_key_encoding[count.index]
    public_key = var.iam_user_public_ssh_keys[count.index]
}

resource "aws_iam_account_password_policy" "user_password_policy" {
    minimum_password_length        = var.iam_user_pass_minimum_password_length
    require_lowercase_characters   = var.iam_user_pass_require_lowercase_characters
    require_numbers                = var.iam_user_pass_require_numbers
    require_uppercase_characters   = var.iam_user_pass_require_uppercase_characters
    require_symbols                = var.iam_user_pass_require_symbols
    allow_users_to_change_password = var.iam_user_pass_allow_users_to_change_password
    max_password_age               = var.iam_user_pass_max_password_age
}


