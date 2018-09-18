#!/usr/bin/env bash

set -e

export BOSH_LOG_LEVEL="debug"
export BOSH_LOG_PATH="./run.log"

bosh create-env ~/azure-quickstart-templates/tree/master/bosh-setup/manifests/bosh.yml \
  --state=state.json \
  --vars-store=~/bosh-deployment-vars.yml \
  -o ~/azure-quickstart-templates/tree/master/bosh-setup/manifests/cpi.yml \
  -o ~/azure-quickstart-templates/tree/master/bosh-setup/manifests/custom-cpi-release.yml \
  -o ~/azure-quickstart-templates/tree/master/bosh-setup/manifests/custom-bosh-tag.yml \
  -o ~/azure-quickstart-templates/tree/master/bosh-setup/manifests/custom-environment.yml \
  -o ~/azure-quickstart-templates/tree/master/bosh-setup/manifests/use-azure-dns.yml \
  -o ~/azure-quickstart-templates/tree/master/bosh-setup/manifests/jumpbox-user.yml \
  -o ~/azure-quickstart-templates/tree/master/bosh-setup/manifests/keep-failed-or-unreachable-vms.yml \
  -v cpi_release_sha1=372c0220e2e38ca9201135eccb52ff912f2d0538 \
  -v cpi_release_url=https://bosh.io/d/github.com/cloudfoundry-incubator/bosh-azure-cpi-release?v=35.4.0 \
  -o ~/azure-quickstart-templates/tree/master/bosh-setup/manifests/enable-telemetry-and-boot-diagnostics.yml \
  -o ~/azure-quickstart-templates/tree/master/bosh-setup/manifests/uaa.yml \
  -o ~/azure-quickstart-templates/tree/master/bosh-setup/manifests/credhub.yml \
  -v director_name=azure \
  -v internal_cidr=10.0.0.0/24 \
  -v internal_gw=10.0.0.1 \
  -v internal_ip=10.0.0.4 \
  -v director_vm_instance_type=Standard_D2_v2 \
  -v resource_group_name=ICA-RG-UNManagedCF-9-17-20-47-43 \
  -v vnet_name=boshvnet-crp \
  -v subnet_name=Bosh \
  -v default_security_group=nsg-bosh \
  -v environment=AzureCloud \
  -v subscription_id=${AZURE_SUBSCRIPTION_ID} \
  -v tenant_id=${AZURE_TENANT_ID} \
  -v client_id=${AZURE_CLIENT_ID} \
  -v client_secret=${AZURE_CLIENT_SECRET} \
  -v storage_account_name=yqfwbcyxhx2tgcfdefaultsa \
