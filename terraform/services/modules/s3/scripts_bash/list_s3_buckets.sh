#!/bin/bash

set -xv

account_id=$1

# Obtener la lista de buckets y sus ARNs
cred=$(aws sts assume-role --role-arn "arn:aws:iam::$account_id:role/buildautomation-iac-iam-role" --role-session-name "terraform")

if [ -z "$cred" ]; then
  echo "Failed to assume role for account $account_id"
  exit 1
fi

export AWS_ACCESS_KEY_ID=$(echo $cred | jq -r '.Credentials.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(echo $cred | jq -r '.Credentials.SecretAccessKey')
export AWS_SESSION_TOKEN=$(echo $cred | jq -r '.Credentials.SessionToken')


BUCKETS=$(aws s3api list-buckets --query "Buckets[].Name" --output json)

# Construir un mapa de buckets a ARNs
OUTPUT="{"
for BUCKET in $(echo $BUCKETS | jq -r '.[]'); do
  ARN="arn:aws:s3:::$BUCKET"
  OUTPUT+="\"$BUCKET\": \"$ARN\","
done
OUTPUT="${OUTPUT%,}}" # Eliminar la última coma y cerrar el JSON

# Devolver el JSON
echo "$OUTPUT"
