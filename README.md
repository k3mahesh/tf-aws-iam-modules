# Identity Access Management (IAM) Terraform Modules

Identity Access Management is used to manage access to users and resources.

## Modules Covered
- iam-user
- iam-group
- iam-role
- iam-policies

## Usage

You can use each module as below. Please check the examples.

#### Create User Only
```
module "iam_user" {
    source                        = "MODULES/iam-user"
    iam_user_names                = ["tf-user1"]
    iam_user_paths                = ["/"]
    tags = {
        env  = "Test-TF"
        team = "DevOps"
    }
}
```
#### Create Multiple Users and Create Access keys as well
If you want to Create Access keys as well, provide true to `create_iam_access_key` variable. The default value is false for this Variable.
```
module "iam_user" {
    source                        = "MODULES/iam-user"
    iam_user_names                = ["tf-user1", "tf-user2", "tf-user3"]
    iam_user_paths                = ["/", "/", "/"]
    create_iam_access_key         = true
    tags = {
        env  = "Test-TF"
        team = "DevOps"
    }
}
```
#### Create User with PGP Key For Password Encryption
Create a Account or Register all users with keybase.io. Add/Register your device in keybase.io account. Check the Encription key in state file. Command to decript by keybase

`echo "${encrypted_password}" | base64 --decode | keybase pgp decrypt`

Follow this [link](https://stackoverflow.com/questions/53534722/how-to-enable-the-console-login-for-iam-user-in-terraform) for steps to follow
```
module "iam_user" {
    source                        = "MODULES/iam-user"
    iam_user_names                = ["tf-user1", "tf-user2", "tf-user3"]
    iam_user_paths                = ["/", "/", "/"]
    create_iam_user_login_profile = true
    iam_user_password_length      = 20
    iam_user_pgp_keys             = ["keybase:maheshk23", "keybase:maheshk23", "keybase:maheshk23"]

    tags = {
        env  = "Test-TF"
        team = "DevOps"
    }
}
```
#### Create Group
You can all add the Members in the group with this module, you only need to provide true to `add_user_in_group` and provide list of users to add in Group. Default value is false.
```
module "iam_group_terraform" {
    source                    = "MODULES/iam-group"
    create_iam_group          = true
    iam_group_name            = "tf-group"
    iam_group_path            = "/"
    add_user_in_group         = true
    iam_group_membership_name = "tf-membership-testing"
    iam_users_add_in_group    = ["tf-user1", "tf-user2", "tf-user3"]
}
```
#### Create Basic Policy
```
module "iam_policy_ec2_describe" {
    source                               = "MODULES/iam-policies"
    iam_custom_policy_name               = "terraform-test1"
    iam_custom_policy_path               = "/"
    iam_custom_policy_description        = "Test with Terraform"
    iam_custom_policy_action             = ["ec2:Describe*"]
    iam_custom_policy_effect             = "Allow"
    iam_custom_policy_resource_name      = ["*"]

    tags = {
        env  = "Test-TF"
        team = "DevOps"
    }
}
```
#### Create Basic Policy and attach it with Users, Groups and Roles
You can Create and Add same Policy with multiple Users, Groups and Roles.
- if you want to add only with users provide true to `iam_custom_policy_attach_user` and provide list of Users.
- To attach Policy with Groups provide true to `iam_custom_policy_attach_group`, and provide list of groups, and same for Role.
```
module "iam_policy_ec2_describe" {
    source                               = "MODULES/iam-policies"
    iam_custom_policy_name               = "terraform-test1"
    iam_custom_policy_path               = "/"
    iam_custom_policy_description        = "Test with Terraform"
    iam_custom_policy_action             = ["ec2:Describe*"]
    iam_custom_policy_effect             = "Allow"
    iam_custom_policy_resource_name      = ["*"]
    iam_custom_policy_attach_user        = false   
    iam_custom_policy_attach_group       = false
    iam_custom_policy_attach_role        = false
    iam_custom_policy_attach_users_name  = ["tf-user1", "tf-user2"]
    iam_custom_policy_attach_groups_name = ["tf-group"]

    tags = {
        env  = "Test-TF"
        team = "DevOps"
    }
}
```
Note: You can remove attachment variable you don't want them. For example, you only want to attach above policy with users, you can remove group and role related parametes from the module.
#### Create Basic Role
```
module "iam_role" {
    source                                            = "MODULES/iam-role"
    create_iam_role_basic_assume_policy               = true
    iam_role_name                                     = "terraform-test-role1"
    iam_role_description                              = "tesing role"
    iam_role_assume_policy_action                     = ["ec2:Describe*"]
    iam_role_assume_policy_effect                     = "Allow"
    iam_role_assume_policy_resource_name              = ["*"]

    tags = {
        env  = "Test-TF"
        team = "DevOps"
    }
}
```
#### Create Role and Attach Already Created Policy
```
module "iam_role_managed_policy" {
    source                                            = "MODULES/iam-role"
    create_iam_role_basic_assume_policy               = true
    iam_role_name                                     = "terraform-test-role1"
    iam_role_description                              = "tesing role"
    iam_role_assume_policy_action                     = ["ec2:Describe*"]
    iam_role_assume_policy_effect                     = "Allow"
    iam_role_assume_policy_resource_name              = ["*"]
    create_iam_role_managed_policies                  = true
    iam_role_managed_policy_arns                      = [module.iam_policy_ec2_describe.iam_custom_policy_arn]

    tags = {
        env  = "Test-TF"
        team = "DevOps"
    }
}
```
#### Create Instance Profile Role
Provide true to `create_iam_role_basic_assume_policy` variable to create Instance Profile Role, also need provide true to `create_iam_role_instance_profile` variable as given below example.
```
module "iam_role" {
    source                                            = "MODULES/iam-role"
    create_iam_role_basic_assume_policy               = true
    iam_role_name                                     = "terraform-test-role1"
    iam_role_description                              = "tesing role"
    iam_role_assume_policy_action                     = ["ec2:Describe*"]
    iam_role_assume_policy_effect                     = "Allow"
    iam_role_assume_policy_resource_name              = ["*"]
    create_iam_role_instance_profile                  = true
    iam_role_instance_profile_name                    = "test-tf-instance-profile"

    tags = {
        env  = "Test-TF"
        team = "DevOps"
    }
}
```
#### Create Instance Profile If Role is already Created
```
module "iam_role" {
    source                                            = "MODULES/iam-role"
    create_iam_role_for_instance_profile_managed_role = true
    iam_managed_role_name                             = "terraform-test-role1"
    iam_role_instance_profile_managed_role_name       = "test-tf-instance-profile-m"

    tags = {
        env  = "Test-TF"
        team = "DevOps"
    }
}
```
