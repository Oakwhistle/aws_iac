#!/bin/bash

folder=$1 
varfile=$2
#---Import checks script
. commons/checks.sh $folder $varfile

call_cfm_bucket_stack() {

    _STACK_PARAMS=" --parameter-overrides AccountId=$STRING_DATA"
    _TEMPLATE_PATH="cloudformation/tfbackend-bucket.yml"
    _STACK_NAME="devops-tfbackend-bucket-cf"

    echo "Calling function stack from commons/functions.sh"
    stack
}

call_cfm_dynamo_stack() {
    _TEMPLATE_PATH="cloudformation/tfbackend-dynamo.yml"
    # Validation to support original functionality.
    # Due to the first iteration of this script create a file 
    # Wiht next name convention devops-tfbackend-dynamo-############-cf for network case
    # But now for other kind of iac process the format is: 
    # devops-tfbackend-dynamo-############-INFRA_TYPE-SERVICE-ENVIRONMENT-cf
    if [[ $INFRA_TYPE == "network" ]]; then
        _STACK_PARAMS=" --parameter-overrides AccountId=$ACCOUNT_ID InfraType=$INFRA_TYPE Region=$AWS_DEFAULT_REGION Project=$PROJECT Service=$SERVICE Environment=$ENVIRONMENT"
        _STACK_NAME="devops-tfbackend-dynamo-$ACCOUNT_ID-$INFRA_TYPE-$PROJECT-$AWS_DEFAULT_REGION-cf"
    else
        _STACK_PARAMS=" --parameter-overrides AccountId=$ACCOUNT_ID InfraType=$INFRA_TYPE Region=$AWS_DEFAULT_REGION Project=$PROJECT Service=$SERVICE Environment=$ENVIRONMENT"
        _STACK_NAME="devops-tfbackend-dynamo-$ACCOUNT_ID-$INFRA_TYPE-$PROJECT-$SERVICE-$AWS_DEFAULT_REGION-cf"
    fi

    echo "Dynamo Stack Name: $_STACK_NAME"
    echo "Calling function stack from commons/functions.sh"
    stack
}

echo "Calling function call_cfm_bucket_stack"
call_cfm_bucket_stack

echo "Calling function call_cfm_dynamo_stack"
call_cfm_dynamo_stack
