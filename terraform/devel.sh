#!/bin/bash

RED='\033[1;31m'
YELLOW="\033[0;33m"
GREEN='\033[0;32m'
END='\033[0m'

GET_ENV_PROFILE=$(env | grep -w "AWS_PROFILE")

if [[ -z "$GET_ENV_PROFILE" ]]; then
    echo -e "${RED}[ERROR] Must configure a PROFILE ${END}"
    echo -e "${RED}Create a aws profile: aws configure --profile iac${END}"

    echo -e "${RED}After create a profile, you must set AWS_PROFILE variable${END}"
    echo -e "${RED}You need to set a aws profile, using the next command: export AWS_PROFILE=<PROFILE_NAME>${END}"
    echo -e "${YELLOW}<PROFILE_NAME> availables:${END}"
    aws configure list-profiles
    exit 1
fi

#---Import funcions script
. state/commons/functions.sh

_TERRAFORM_PATH=$1

TFVARS_NAME_FILE=$2

if [[ -z "$_TERRAFORM_PATH" ]]; then
    SCRIPT_NAME=$(basename $0)
    echo "[ERROR] Must send iac folder param: ./$SCRIPT_NAME IAC_FOLDER"
    exit 1
else
    FOLDER_EXIST=$(find ./ -maxdepth 1 -type d -not -path "./state" | grep -w "$_TERRAFORM_PATH")
    if [[ -z "$FOLDER_EXIST" ]]; then
        echo "[ERROR] The iac folder name does not found."
        echo "Maybe, The list can help you."
        find ./ -maxdepth 1 -type d -not -path "./state" | sed 's:./: :'
        exit 1
    fi
fi

INFRA_TYPE="$(basename -- $_TERRAFORM_PATH)"

if [[ -z "$TFVARS_NAME_FILE" ]]; then
    echo "[ERROR] Must set TFVARS_NAME_FILE environment variable"
    echo "Maybe, The list can help you."
    printf '%s\n' $_TERRAFORM_PATH/vars/* | cut -d "/" -f3 | sed s/.tfvars//g
    exit 1
fi

_BACKEND_TPL="backend.tf.tpl"

if [[ ! -f "$_TERRAFORM_PATH/$_BACKEND_TPL" ]]; then
    echo "[ERROR] $_BACKEND_TPL file not exist"
    exit 1
fi

BASE_DIRECTORY=$(echo "$_TERRAFORM_PATH" | cut -d "/" -f2)

PATH_TFVARS_FILE=$BASE_DIRECTORY/vars/$TFVARS_NAME_FILE.tfvars

# Search with grep using pattern for only find the exact word
ENVIRONMENT="$(grep -w "^environment" $PATH_TFVARS_FILE | awk -F\" '{ print $2 }')"
if [[ -z "$ENVIRONMENT" ]]; then
    echo "[ERROR] Must set ENVIRONMENT variable"
    exit 1
fi

# Search with grep using pattern for only find the exact word
ACCOUNT_ID="$(grep -w "^account_id" $PATH_TFVARS_FILE | awk -F\" '{ print $2 }')"
if [[ -z "$ACCOUNT_ID" ]]; then
    echo "[ERROR] Must set ACCOUNT_ID variable"
    exit 1
fi

PROJECT="$(grep -w "^project" $PATH_TFVARS_FILE | awk -F\" '{ print $2 }')"
if [[ -z "$PROJECT" ]]; then
    echo "[ERROR] Must set PROJECT variable"
    exit 1
fi

# Search with grep using pattern for only find the exact word
AWS_DEFAULT_REGION="$(grep -w "^region" $PATH_TFVARS_FILE | awk -F\" '{ print $2 }')"
if [[ -z "$AWS_DEFAULT_REGION" ]]; then
    echo "[ERROR] Must set AWS_DEFAULT_REGION variable"
    exit 1
fi

if [[ "$INFRA_TYPE" != "network" ]]; then
    # Search with grep using pattern for only find the exact word
    SERVICE="$(grep -w "^service" $PATH_TFVARS_FILE | awk -F\" '{ print $2 }')"
    if [[ -z "$SERVICE" ]]; then
        echo "[ERROR] Must set SERVICE variable"
        exit 1
    fi
fi

if [[ -d $_TERRAFORM_PATH/.terraform ]]; then
    echo "Remove $_TERRAFORM_PATH/.terraform.lock.hcl File and .terraform Folder"
    rm -rf $_TERRAFORM_PATH/.terraform $_TERRAFORM_PATH/.terraform.lock.hcl $_TERRAFORM_PATH/backend.tf
    echo "Installing terraform modules."
    cd $_TERRAFORM_PATH && terraform init
    cd ..
else
    echo "Installing terraform modules."
    cd $_TERRAFORM_PATH && terraform init
    cd ..
fi

STS_ACCCOUNT_CHAIN_TO_ROLE=$(aws iam get-role --role-name buildautomation-iac-iam-role | jq '.Role | .AssumeRolePolicyDocument.Statement[].Principal.AWS ' | grep root | tr -dc '0-9')
echo "Principal Account: $STS_ACCCOUNT_CHAIN_TO_ROLE"
if [[ $STS_ACCCOUNT_CHAIN_TO_ROLE == "<account-id>" ]]; then
    STRING_DATA="buildautomation"
else
    STRING_DATA=$ACCOUNT_ID
fi

prepare_backend_file
echo -e "\n"

# if [[ "$INFRA_TYPE" == "eks" ]]; then
#     _TERRAFORM_PATH=$1/k8s-addons
#     INFRA_TYPE=k8s-addons
#     if [[ -d $_TERRAFORM_PATH/.terraform ]]; then
#         echo "Remove $_TERRAFORM_PATH/.terraform"
#         rm -rf $_TERRAFORM_PATH/.terraform
#     fi
#     prepare_backend_file
#     prepare_terrraform_remote_state_file
# fi
