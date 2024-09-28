#!/bin/bash

# Variables
ROLE_NAME="automation-iac-iam-role"
ACCOUNT_ID="090876143603"
REGION="eu-central-1"
PROFILE="default"
ADMIN_POLICY_ARN="arn:aws:iam::aws:policy/AdministratorAccess"
# PERMISION_SET="AWSReservedSSO_<name>"
# SSO_INSTANCE_ARN="arn:aws:iam::${ACCOUNT_ID}:role/aws-reserved/sso.amazonaws.com/eu-central-1/${PERMISION_SET}"

# Crear el archivo trust-policy.json
cat > trust-policy.json << EOL
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "arn:aws:iam::${ACCOUNT_ID}:root",
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOL

# SSO Policy
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Principal": {
#                 "AWS": [
#                     "arn:aws:iam::${ACCOUNT_ID}:root",
#                     "${SSO_INSTANCE_ARN}"
#                 ]
#             },
#             "Action": "sts:AssumeRole"
#         }
#     ]
# }

# Crear el rol con la política de confianza
echo "Creando el rol ${ROLE_NAME}..."
aws iam create-role --role-name ${ROLE_NAME} --assume-role-policy-document file://trust-policy.json --profile ${PROFILE}

# Adjuntar la política de AdministratorAccess
echo "Adicionando política AdministratorAccess al rol ${ROLE_NAME}..."
aws iam attach-role-policy --role-name ${ROLE_NAME} --policy-arn ${ADMIN_POLICY_ARN} --profile ${PROFILE}
