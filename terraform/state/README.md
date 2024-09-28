# Bash Scripts for Terraform Backend Setup

## 1. `prepare-backend.sh`

This script prepares the backend for Terraform, checking the required files and configurations.

```bash
# Command to run `prepare-backend.sh`
./prepare-backend.sh <folder> <varfile>

# Example
./prepare-backend.sh ./config ./config/vars.tfvars

# Arguments:
# <folder>  : Directory containing the backend configuration files.
# <varfile> : Path to the variable file that defines configuration parameters.
```

## 2. create_role_buildautomate_in_build_automate_account.sh

Creates an IAM role (buildautomation-iac-iam-role) in the build automation AWS account

```bash
# Command to run `create_role_buildautomate_in_build_automate_account.sh`
./create_role_buildautomate_in_build_automate_account.sh

# Example
./create_role_buildautomate_in_build_automate_account.sh

# No arguments required. The script:
# - Creates an IAM role in the build automation account using a trust policy.
# - Attaches the AdministratorAccess policy to the role.
```

## 3. create_role_buildautomate_remote_account.sh

Creates the buildautomation-iac-iam-role in a remote AWS account.

```bash
# Command to run `create_role_buildautomate_remote_account.sh`
./create_role_buildautomate_remote_account.sh <remote_account_profile>

# Example
./create_role_buildautomate_remote_account.sh remote-account-profile

# Arguments:
# <remote_account_profile> : AWS CLI profile configured for the remote AWS account.

# The script:
# - Creates the IAM role in a remote account with a trust policy.
# - The role is assumed by the build automate account.
```

## 4. prepare-terraform-remote-state.sh

Prepares Terraform's remote state setup by creating the necessary S3 bucket and DynamoDB table using AWS CloudFormation.

```bash
# Command to run `prepare-terraform-remote-state.sh`
./prepare-terraform-remote-state.sh <profile> <account_id> <region>

# Example
./prepare-terraform-remote-state.sh dev-profile 123456789012 us-west-2

# Arguments:
# <profile>    : AWS CLI profile used for executing the commands.
# <account_id> : AWS account ID where the resources will be created.
# <region>     : AWS region where the resources will be deployed.

# The script:
# - Calls CloudFormation templates to create an S3 bucket for remote state storage.
# - Creates a DynamoDB table for state locking.
```

## 5. create-backend.sh

This script manages the full process of creating the Terraform backend using CloudFormation.

```bash
# Command to run `create-backend.sh`
./create-backend.sh

# Example
./create-backend.sh

# No arguments required. The script:
# - Calls CloudFormation stacks to create the backend S3 bucket and DynamoDB table.
# - The resources are created in the specified account and region, as defined in the internal logic.
```

## 6. create_role_buildautomate.sh

Creates the buildautomation-iac-iam-role for general build automation across accounts.

```bash
# Command to run `create_role_buildautomate.sh`
./create_role_buildautomate.sh

# Example
./create_role_buildautomate.sh

# No arguments required. The script:
# - Creates the role with AdministratorAccess in the specified account using AWS CLI.
# - Attaches the AdministratorAccess policy to the created role.
```


---

> This Markdown block contains explanations and usage examples for each of the scripts in your Terraform backend setup. Let me know if you'd like any additional details!
