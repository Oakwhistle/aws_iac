#!/bin/bash

STS_ACCCOUNT_CHAIN_TO_ROLE=$(aws iam get-role --role-name buildautomation-iac-iam-role | jq '.Role | .AssumeRolePolicyDocument.Statement[].Principal.AWS ' | grep root | tr -dc '0-9')
echo "Principal Account: $STS_ACCCOUNT_CHAIN_TO_ROLE"
if [[ $STS_ACCCOUNT_CHAIN_TO_ROLE == "<account-id>" ]]; then
    STRING_DATA="buildautomation"
else
    STRING_DATA=$ACCOUNT_ID
fi

#---Import funcions script
. commons/functions.sh

# Terraform Component Path e.g($1=network OR $1=eks)
# The $1 will be send by pipeline definition in one of the step of build-dynamo-and-backend.yml
_TERRAFORM_PATH=../$1

if [[ -z "$_TERRAFORM_PATH" ]]; then
    SCRIPT_NAME=$(basename $0)
    echo "[ERROR] Must send _TERRAFORM_PATH variable: ./$SCRIPT_NAME TF_DIR"
    exit 1
fi

_BACKEND_TPL="backend.tf.tpl"

if [[ ! -f "$_TERRAFORM_PATH/$_BACKEND_TPL" ]]; then
    echo "[ERROR] $_BACKEND_TPL file not exist"
    exit 1
fi

INFRA_TYPE="$(basename -- $_TERRAFORM_PATH)"

# The $1 will be send by pipeline definition in one of the step of build-dynamo-and-backend.yml
if [[ "$1" != "network" ]]; then

    if [[ ! -z $2 ]]; then
        TFVARS_NAME_FILE=$2
    fi

    if [[ -z "$TFVARS_NAME_FILE" ]]; then
        echo "[ERROR] Must set TFVARS_NAME_FILE environment variable"
        exit 1
    fi

    BASE_DIRECTORY=$(echo "$_TERRAFORM_PATH" | cut -d "/" -f2)
    # This returns always the first directory after / if exist
    # Example it would return following: eks
    PATH_TFVARS_FILE=../$BASE_DIRECTORY/vars/$TFVARS_NAME_FILE.tfvars

    # Search with grep using pattern for only find the exact word
    SERVICE="$(grep -w "^service" $PATH_TFVARS_FILE | awk -F\" '{ print $2 }')"
    if [[ -z "$SERVICE" ]]; then
        echo "[ERROR] Must set SERVICE variable"
        exit 1
    fi
    
    PROJECT="$(grep -w "^project" $PATH_TFVARS_FILE | awk -F\" '{ print $2 }')"
    if [[ -z "$PROJECT" ]]; then
        echo "[ERROR] Must set PROJECT variable"
        exit 1
    fi

    # Search with grep using pattern for only find the exact word
    ENVIRONMENT="$(grep -w "^environment" $PATH_TFVARS_FILE | awk -F\" '{ print $2 }')"
    if [[ -z "$ENVIRONMENT" ]]; then
        echo "[ERROR] Must set ENVIRONMENT variable"
        exit 1
    fi

    if [[ ! -z $2 ]]; then
        ACCOUNT_ID="$(grep -w "^account_id" $PATH_TFVARS_FILE | awk -F\" '{ print $2 }')"
        echo $ACCOUNT_ID
        AWS_DEFAULT_REGION="$(grep -w "^region" $PATH_TFVARS_FILE | awk -F\" '{ print $2 }')"
        echo $AWS_DEFAULT_REGION
    fi
else
    if [[ ! -z $2 ]]; then
        TFVARS_NAME_FILE=$2
    fi

    if [[ -z "$TFVARS_NAME_FILE" ]]; then
        echo "[ERROR] Must set TFVARS_NAME_FILE environment variable"
        exit 1
    fi
    BASE_DIRECTORY=$(echo "$_TERRAFORM_PATH" | cut -d "/" -f2)
    # This returns always the first directory after / if exist
    # Example it would return following: eks
    PATH_TFVARS_FILE=../$BASE_DIRECTORY/vars/$TFVARS_NAME_FILE.tfvars
    # This variable will be defined for a pipeline
    ACCOUNT_ID="$(grep -w "^account_id" $PATH_TFVARS_FILE | awk -F\" '{ print $2 }')"

    if [[ -z "$ACCOUNT_ID" ]]; then
        echo "[ERROR] Must set ACCOUNT_ID environment variable"
        exit 1
    fi

    AWS_DEFAULT_REGION="$(grep -w "^region" $PATH_TFVARS_FILE | awk -F\" '{ print $2 }')"
    # This variable will be defined for a pipeline
    if [[ -z "$AWS_DEFAULT_REGION" ]]; then
        echo "[ERROR] Must set AWS_DEFAULT_REGION environment variable"
        exit 1
    fi

    SERVICE="$(grep -w "^service" $PATH_TFVARS_FILE | awk -F\" '{ print $2 }')"
    if [[ -z "$SERVICE" ]]; then
        SERVICE="network"
    fi
    
    PROJECT="$(grep -w "^project" $PATH_TFVARS_FILE | awk -F\" '{ print $2 }')"
    if [[ -z "$PROJECT" ]]; then
        echo "[ERROR] Must set PROJECT variable"
        exit 1
    fi
    
    ENVIRONMENT="$(grep -w "^environment" $PATH_TFVARS_FILE | awk -F\" '{ print $2 }')"
    if [[ -z "$ENVIRONMENT" ]]; then
        echo "[ERROR] Must set ENVIRONMENT variable"
        exit 1
    fi
fi