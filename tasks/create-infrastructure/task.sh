#!/usr/bin/env bash

set -e
bosh -v

echo "Installing OS specified dependencies"
apt-get update && apt-get install -y tzdata wget
wget https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip
unzip terraform_0.11.8_linux_amd64.zip 
mv terraform /usr/bin/


TIMESTAMP=`TZ=Asia/Shanghai date "+%m-%d-%H-%M-%S-%3N"`

echo "=============================================================================================="
echo "Executing Terraform Plan ..."
echo "=============================================================================================="

terraform init cf-cpi-pipelines/terraform/azure-base

terraform plan \
  -var "subscription_id=${SUBSCRIPTION_ID}" \
  -var "tenant_id=${TENANT_ID}" \
  -var "client_id=${CLIENT_ID}" \
  -var "client_secret=${CLIENT_SECRET}" \
  -var "resource_group=${RESOURCE_GROUP_PREFIX}${TIMESTAMP}" \
  -var "region=${REGION}" \
  -var "bosh_security_group=${BOSH_SECURITY_GROUP}" \
  -var "cf_security_group=${CF_SECURITY_GROUP}" \
  -var "vnet_name=${VNET_NAME}" \
  -var "bosh_subnet_name=${BOSH_SUBNET_NAME}" \
  -var "cf_subnet_name=${CF_SUBNET_NAME}" \
  -var "network_cidr=${VNETWORK_CIDR}" \
  -var "bosh_subnet_cidr=${BOSH_SUBNET_CIDR}" \
  -var "cf_subnet_cidr=${CF_SUBNET_CIDR}" \
  -out terraform.tfplan \
  cf-cpi-pipelines/terraform/azure-base

echo "=============================================================================================="
echo "Executing Terraform Apply ..."
echo "=============================================================================================="

terraform apply \
  -state-out terraform-state/terraform.tfstate \
  terraform.tfplan
