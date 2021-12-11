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
    source                        = "../MODULES/iam-user"
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
    source                        = "../MODULES/iam-user"
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
    source                        = "../MODULES/iam-user"
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
    source                    = "../MODULES/iam-group"
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
    source                               = "../MODULES/iam-policies"
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
    source                               = "../MODULES/iam-policies"
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
    source                                            = "../MODULES/iam-role"
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
    source                                            = "../MODULES/iam-role"
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
    source                                            = "../MODULES/iam-role"
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
    source                                            = "../MODULES/iam-role"
    create_iam_role_for_instance_profile_managed_role = true
    iam_managed_role_name                             = "terraform-test-role1"
    iam_role_instance_profile_managed_role_name       = "test-tf-instance-profile-m"

    tags = {
        env  = "Test-TF"
        team = "DevOps"
    }
}
```
### iam-user Variables
|Variable|Default Value|Description|Type|
|---|---|---|---|
|iam_user_names|nil|IAM User|list|
|iam_user_paths|nil|Path in which to create the user|list|
|create_iam_user_login_profile|false|Create IAM User login profile or not, Manages an IAM User Login Profile with limited support for password creation during Terraform resource creation|bool|
|iam_user_pgp_keys|nil|Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Only applies on resource creation. Drift detection is not possible with this argument|list|
|iam_user_password_length|20|The length of the generated password on resource creation. Only applies on resource creation. Drift detection is not possible with this argument|string|
|iam_user_password_reset_required|true|Whether the user should be forced to reset the generated password on resource creation. Only applies on resource creation. Drift detection is not possible with this argument|bool|
|create_iam_access_key|false|Do you want to create a access keys for iam user or not, if you putt true then access keys will be created|bool|
|iam_user_add_ssh_key|false|Do you want add ssh key with iam user or not, True for add ssh key|bool|
|iam_user_public_key_encoding|nil|Specifies the public key encoding format to use in the response. To retrieve the public key in ssh-rsa format, use SSH. To retrieve the public key in PEM format, use PEM|list|
|iam_user_public_ssh_keys|nil|The SSH public key. The public key must be encoded in ssh-rsa format or PEM format|list|
|iam_user_pass_minimum_password_length|8|Minimum length to require for user passwords|string|
|iam_user_pass_require_lowercase_characters|true|Whether to require lowercase characters for user passwords|bool|
|iam_user_pass_require_numbers|true|Whether to require numbers for user passwords|bool|
|iam_user_pass_require_uppercase_characters|true|Whether to require uppercase characters for user passwords|bool|
|iam_user_pass_require_symbols|true|Whether to require symbols for user passwords|bool|
|iam_user_pass_allow_users_to_change_password|true|Whether to allow users to change their own password|bool|
|iam_user_pass_max_password_age|180|The number of days that an user password is valid|string|
|tags|nil|A mapping of tags to assign to the resource|map|

### iam-role Variables
|Variable|Default Value|Description|Type|
|---|---|---|---|
|create_iam_role_basic_assume_policy|false|Create IAM Role with Assume Policy define inside a Role|bool|
|iam_role_name|test-terraform|Friendly name of the role. If omitted, Terraform will assign a random, unique name. See IAM Identifiers for more information|bool|
|iam_role_description|IAM Role|Description of the role|string|
|iam_role_force_detach_policies|false|Whether to force detaching any policies the role has before destroying it. Defaults to false|bool|
|iam_role_assume_policy_action|["ec2:Describe*"]|The actions you want to take on aws services like ec2, s3, iam and so on|list|
|iam_role_assume_policy_resource_name|["*"]|The name of the resouce on which this policy going to effect. it can be particular resource name where you want to provide access to user or group. it can arn:aws:s3:::mybucket|list|
|iam_role_assume_policy_effect|"Allow"|The effect of Custom policy, it can either allow or deny|string|
|create_iam_role_managed_policies|false|Create iam role with Managed Policies and attach these policies in the form of list|bool|
|iam_role_managed_policy_arns|[]|Set of exclusive IAM managed policy ARNs to attach to the IAM role. If this attribute is not configured, Terraform will ignore policy attachments to this resource. When configured, Terraform will align the role's managed policy attachments with this set by attaching or detaching managed policies. Configuring an empty set (i.e., managed_policy_arns = []) will cause Terraform to remove all managed policy attachments|list|
|create_iam_role_instance_profile|false|Create iam role with instance profile, if you want to create then provide true, otherwise provide false to skip it. please provide true to create_iam_role_basic_assume_policy variable as well along with it|bool|
|iam_role_instance_profile_name|nil|Name of the instance profile. If omitted, Terraform will assign a random, unique name. Conflicts with name_prefix. Can be a string of characters consisting of upper and lowercase alphanumeric characters and these special characters: _, +, =, ,, ., @, -. Spaces are not allowed|string|
|iam_role_instance_profile_path|"/"|Path to the instance profile. For more information about paths, see IAM Identifiers in the IAM User Guide. Can be a string of characters consisting of either a forward slash (/) by itself or a string that must begin and end with forward slashes. Can include any ASCII character from the ! (\u0021) through the DEL character (\u007F), including most punctuation characters, digits, and upper and lowercase letters|string|
|create_iam_role_for_instance_profile_managed_role|false|If you already have a role and you want to assign it to instance profile, you can provide true value to this one and provide a role name as well in iam_managed_role_name variable|bool|
|iam_managed_role_name|""|Name of the role to add to the profile|string|
|tags|nil|A mapping of tags to assign to the resource|map|

### iam-policies Variables
|Variable|Default Value|Description|Type|
|---|---|---|---|
|iam_custom_policy_name|nil|The name of the policy. If omitted, Terraform will assign a random, unique name|string|
|iam_custom_policy_path|"/"|Path in which to create the policy. See IAM Identifiers for more information. default /|string|
|iam_custom_policy_description|nil|Description of the IAM policy|string|
|iam_custom_policy_action|["ec2:Describe*"]|The actions you want to take on aws services like ec2, s3, iam and so on|list|
|iam_custom_policy_resource_name|[*]|The name of the resouce on which this policy going to effect. it can be particular resource name where you want to provide access to user or group. it can arn:aws:s3:::mybucket|list|
|iam_custom_policy_effect|"Allow"|The effect of Custom policy, it can either allow or deny|string|
|iam_custom_policy_attach_user|false|Do you want to attach this policy to user. if yes, provide true value. Default is false|bool|
|iam_custom_policy_attach_users_name|["test-user1"]|The user(s) the policy should be applied to|list|
|iam_custom_policy_attach_group|false|Do you want to attach this policy with group, if yes, provide true value. Default is false|bool|
|iam_custom_policy_attach_groups_name|["test-group1"]|The group(s) the policy should be applied to|list|
|iam_custom_policy_attach_role|false|Do you want to attach this policy with role, if yes, provide true value, Default is false|bool|
|iam_custom_policy_attach_roles_name|["test-role1"]|The role(s) the policy should be applied to|list|
|tags|nil|A mapping of tags to assign to the resource|map|


### iam-group Variables
|Variable|Default Value|Description|Type|
|---|---|---|---|
|create_iam_group|false|Provide true value if you want to create the group otherwise please provide false value. default is false|bool|
|iam_group_name|nil|The group's name. The name must consist of upper and lowercase alphanumeric characters with no spaces. You can also include any of the following characters: =,.@-_.. Group names are not distinguished by case. For example, you cannot create groups named both ADMINS and admins|string|
|iam_group_path|nil|(Optional, default /) Path in which to create the group.|string|
|add_user_in_group|false|Do you want to attach group with use|bool|
|iam_group_membership_name|nil|The name to identify the Group Membership|string|
|iam_users_add_in_group|nil|A list of IAM User names to associate with the Group|list|
