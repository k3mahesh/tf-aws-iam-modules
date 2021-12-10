output "iam_user_arn" {
    description = "The ARN assigned by AWS for this user"
    value       = aws_iam_user.user[*].arn
}

output "iam_user_name" {
    description = "The user name"
    value       =  aws_iam_user.user[*].name
}

output "iam_user_unique_id" {
    description = "The unique ID assigned by AWS"
    value       = aws_iam_user.user[*].unique_id
}

output "iam_user_key_fingerprint_pgp_key" {
    description = "The fingerprint of the PGP key used to encrypt the password. Only available if password was handled on Terraform resource creation, not import."
    value       = aws_iam_user_login_profile.login_profile[*].key_fingerprint
}

output "iam_user_encrypted_password" {
    description = "The encrypted password, base64 encoded. Only available if password was handled on Terraform resource creation, not import."
    value       = aws_iam_user_login_profile.login_profile[*].encrypted_password
}

output "iam_user_access_key_id" {
    description = "Access key ID of iam user"
    value       = aws_iam_access_key.access_keys[*].id
}

output "iam_user_access_key_pgp_key_encrypted_secret" {
    description = "Encrypted secret, base64 encoded, if pgp_key was specified. This attribute is not available for imported resources. The encrypted secret may be decrypted using the command line, for example: terraform output -raw encrypted_secret | base64 --decode | keybase pgp decrypt."
    value       = aws_iam_access_key.access_keys[*].encrypted_secret
}

output "iam_user_access_key_pgp_key_key_fingerprint" {
    description = "Fingerprint of the PGP key used to encrypt the secret. This attribute is not available for imported resources. [Access key Resouces]"
    value       = aws_iam_access_key.access_keys[*].key_fingerprint
}

output "iam_user_access_key_secret" {
    description = "Secret access key. This attribute is not available for imported resources. Note that this will be written to the state file. If you use this, please protect your backend state file judiciously. Alternatively, you may supply a pgp_key instead, which will prevent the secret from being stored in plaintext, at the cost of preventing the use of the secret key in automation. [Access key Resouces]"
    value       = aws_iam_access_key.access_keys[*].secret
}

output "iam_user_ssh_public_key_id" {
    description = "The unique identifier for the SSH public key."
    value       = aws_iam_user_ssh_key.user_ssh_key[*].ssh_public_key_id
}

output "iam_user_ssh_key_fingerprint" {
    description = "The MD5 message digest of the SSH public key."
    value       = aws_iam_user_ssh_key.user_ssh_key[*].fingerprint
}