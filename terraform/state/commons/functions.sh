#!/bin/bash

# This function is called if you want to deploy a cloudformation
stack() {
    echo "[INFO] Searching $_STACK_NAME cloudformation Stack"
    _STACK_EXISTS=$(trap 'aws cloudformation describe-stacks --stack-name '"$_STACK_NAME"'' EXIT)
    _STACK_EXISTS=$(echo "$_STACK_EXISTS" | grep "CreationTime")
    if [[ -z "$_STACK_EXISTS" ]]; then
        echo "[LOG] Terraform backend $_STACK_NAME CloudFormation doesn't exist, creating it ..."
        aws cloudformation deploy \
            --stack-name "$_STACK_NAME" \
            --template-file "$_TEMPLATE_PATH" $_STACK_PARAMS   
    else
        echo "[LOG] Terraform backend $_STACK_NAME CloudFormation stack exists, do nothing"
    fi
}

prepare_backend_file() {
    if [[ -f $_TERRAFORM_PATH/backend.tf ]]; then
        rm $_TERRAFORM_PATH/backend.tf
    fi

    cp "${_TERRAFORM_PATH}/${_BACKEND_TPL}" "${_TERRAFORM_PATH}/tmp_${_BACKEND_TPL}"
    sed -i 's~AWS_DEFAULT_REGION~'"$AWS_DEFAULT_REGION"'~' "${_TERRAFORM_PATH}/tmp_${_BACKEND_TPL}"
    sed -i 's~STRING_DATA~'"$STRING_DATA"'~' "${_TERRAFORM_PATH}/tmp_${_BACKEND_TPL}"
    sed -i 's~ACCOUNT_ID~'"$ACCOUNT_ID"'~' "${_TERRAFORM_PATH}/tmp_${_BACKEND_TPL}"
    sed -i 's~INFRA_TYPE~'"$INFRA_TYPE"'~' "${_TERRAFORM_PATH}/tmp_${_BACKEND_TPL}"
    sed -i 's~SERVICE~'"$SERVICE"'~' "${_TERRAFORM_PATH}/tmp_${_BACKEND_TPL}"
    sed -i 's~ENVIRONMENT~'"$ENVIRONMENT"'~' "${_TERRAFORM_PATH}/tmp_${_BACKEND_TPL}"
    sed -i 's~PROJECT~'"$PROJECT"'~' "${_TERRAFORM_PATH}/tmp_${_BACKEND_TPL}"
    mv "${_TERRAFORM_PATH}/tmp_${_BACKEND_TPL}" "${_TERRAFORM_PATH}"/backend.tf
    echo "[LOG] Prepared backend for the account - $ACCOUNT_ID for infra $INFRA_TYPE and Service $SERVICE in Environment $ENVIRONMENT"
    ls -lah "$_TERRAFORM_PATH"
    cat "${_TERRAFORM_PATH}"/backend.tf
    terraform -chdir=$_TERRAFORM_PATH init
}

# Now, Its possible to use, output from state file
prepare_terrraform_remote_state_file() {
    if [[ -f $_TERRAFORM_PATH/terrraform-remote-state.tf ]]; then
        rm $_TERRAFORM_PATH/terrraform-remote-state.tf
    fi

    cp "${_TERRAFORM_PATH}/terrraform-remote-state.tf.tpl" "${_TERRAFORM_PATH}/tmp_terrraform-remote-state.tf.tpl"
    sed -i 's~AWS_DEFAULT_REGION~'"$AWS_DEFAULT_REGION"'~' "${_TERRAFORM_PATH}/tmp_terrraform-remote-state.tf.tpl"
    sed -i 's~STRING_DATA~'"$STRING_DATA"'~' "${_TERRAFORM_PATH}/tmp_terrraform-remote-state.tf.tpl"
    sed -i 's~ACCOUNT_ID~'"$ACCOUNT_ID"'~' "${_TERRAFORM_PATH}/tmp_terrraform-remote-state.tf.tpl"
    sed -i 's~SERVICE~'"$SERVICE"'~' "${_TERRAFORM_PATH}/tmp_terrraform-remote-state.tf.tpl"
    sed -i 's~ENVIRONMENT~'"$ENVIRONMENT"'~' "${_TERRAFORM_PATH}/tmp_terrraform-remote-state.tf.tpl"
    sed -i 's~PROJECT~'"$PROJECT"'~' "${_TERRAFORM_PATH}/tmp_terrraform-remote-state.tf.tpl"
    sed -i 's~INFRA_TYPE~'"$INFRA_TYPE"'~' "${_TERRAFORM_PATH}/tmp_terrraform-remote-state.tf.tpl"
    mv "${_TERRAFORM_PATH}/tmp_terrraform-remote-state.tf.tpl" "${_TERRAFORM_PATH}"/terrraform-remote-state.tf
    echo "[LOG] Prepared terrraform-remote-state for the account - $ACCOUNT_ID for infra eks and Service $SERVICE in Environment $ENVIRONMENT"
    cat "${_TERRAFORM_PATH}/terrraform-remote-state.tf"
    echo -e "\n"
}