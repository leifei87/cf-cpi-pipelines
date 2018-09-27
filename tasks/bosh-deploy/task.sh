#!/usr/bin/env bash

set -e
bosh -v
export BOSH_LOG_LEVEL="debug"
export BOSH_LOG_PATH="./run.log"

echo "Installing OS specified dependencies for bosh create-env command"
apt-get update && apt-get install -y jq build-essential zlibc zlib1g-dev ruby ruby-dev openssl libxslt-dev libxml2-dev libssl-dev libreadline6 libreadline6-dev libyaml-dev libsqlite3-dev sqlite3

STORAGE_ACCOUNT_NAME=`cat terraform-state/terraform.tfstate | jq -r '.modules | .[].outputs.storage_account_name.value'`
RESOURCE_GROUP_NAME=`cat terraform-state/terraform.tfstate | jq -r '.modules | .[].outputs.resource_group_name.value'`
EXTERNAL_IP=`cat terraform-state/terraform.tfstate | jq -r '.modules | .[].outputs.bosh_external_ip.value'`

bosh create-env cf-cpi-pipelines/manifests/bosh.yml \
  --state=state.json \
  --vars-store=bosh-director-cert/bosh-deployment-vars.yml \
  -o cf-cpi-pipelines/manifests/cpi.yml \
  -o cf-cpi-pipelines/manifests/custom-cpi-release.yml \
  -o cf-cpi-pipelines/manifests/custom-environment.yml \
  -o cf-cpi-pipelines/manifests/use-azure-dns.yml \
  -o cf-cpi-pipelines/manifests/jumpbox-user.yml \
  -o cf-cpi-pipelines/manifests/keep-failed-or-unreachable-vms.yml \
  -v cpi_release_sha1=372c0220e2e38ca9201135eccb52ff912f2d0538 \
  -v cpi_release_url=https://bosh.io/d/github.com/cloudfoundry-incubator/bosh-azure-cpi-release?v=35.4.0 \
  -o cf-cpi-pipelines/manifests/uaa.yml \
  -o cf-cpi-pipelines/manifests/credhub.yml \
  -o cf-cpi-pipelines/manifests/external-ip-with-registry-not-recommended.yml \
  -v director_name=azure \
  -v external_ip=${EXTERNAL_IP} \
  -v internal_cidr=${BOSH_SUBNET_CIDR} \
  -v internal_gw=${BOSH_GATEWAY} \
  -v internal_ip=${BOSH_PRIVATE_IP} \
  -v director_vm_instance_type=${INSTANCE_TYPE} \
  -v resource_group_name=${RESOURCE_GROUP_NAME} \
  -v vnet_name=${VNET_NAME} \
  -v subnet_name=${BOSH_SUBNET_NAME} \
  -v default_security_group=${BOSH_SECURITY_GROUP} \
  -v environment=${ENVIRONMENT} \
  -v subscription_id=${SUBSCRIPTION_ID} \
  -v tenant_id=${TENANT_ID} \
  -v client_id=${CLIENT_ID} \
  -v client_secret=${CLIENT_SECRET} \
  -v storage_account_name=${STORAGE_ACCOUNT_NAME}