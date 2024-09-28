#!/bin/bash

# Variables
ROLE_NAME="automation-iac-iam-role"
REGION="eu-central-1"
BUILDAUTOMATE_ACCOUNT_ID="090876143603"
PERMISION_SET="AWSReservedSSO_<name>"
ROLE_IN_ACCOUNT_BUILDAUTOMATE="arn:aws:iam::${BUILDAUTOMATE_ACCOUNT_ID}:role/${ROLE_NAME}"
PROFILE_REMOTE_ACCOUNT=$1
# PROFILE="default"
# ADMIN_POLICY_ARN="arn:aws:iam::aws:policy/AdministratorAccess"

# Crear el archivo trust-policy.json para la cuenta B
cat > trust-policy.json << EOL
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "arn:aws:iam::${BUILDAUTOMATE_ACCOUNT_ID}:role/aws-reserved/sso.amazonaws.com/eu-central-1/${PERMISION_SET}",
                    "${ROLE_IN_ACCOUNT_BUILDAUTOMATE}"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOL

# Crear el rol en la cuenta B con la política de confianza
echo "Creando el rol ${ROLE_NAME} en la cuenta ${PROFILE_REMOTE_ACCOUNT}..."
aws iam create-role --role-name ${ROLE_NAME} --assume-role-policy-document file://trust-policy.json --profile ${PROFILE_REMOTE_ACCOUNT}

# Adjuntar la política de AdministratorAccess al rol en la cuenta B
echo "Adicionando política AdministratorAccess al rol ${ROLE_NAME} en la cuenta ${PROFILE_REMOTE_ACCOUNT}..."
aws iam attach-role-policy --role-name ${ROLE_NAME} --policy-arn ${ADMIN_POLICY_ARN} --profile ${PROFILE_REMOTE_ACCOUNT}

# Limpiar archivo temporal
rm trust-policy.json

echo "Rol ${ROLE_NAME} creado y política adjunta exitosamente en la cuenta ${PROFILE_REMOTE_ACCOUNT}."
