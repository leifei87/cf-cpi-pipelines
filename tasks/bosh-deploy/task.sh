#!/usr/bin/env bash

set -e
bosh -v

echo "Installing OS specified dependencies for bosh create-env command"
apt-get update && apt-get install -y build-essential zlibc zlib1g-dev ruby ruby-dev openssl libxslt-dev libxml2-dev libssl-dev libreadline6 libreadline6-dev libyaml-dev libsqlite3-dev sqlite3

wget https://github.com/cloudfoundry/bosh-bootloader/releases/download/v6.10.0/bbl-v6.10.0_linux_x86-64
chmod +x bbl-v6.10.0_linux_x86-64 
mv bbl-v6.10.0_linux_x86-64 /usr/bin/bbl

export BBL_IAAS=azure
export BBL_AZURE_CLIENT_ID=${AZURE_CLIENT_ID}
export BBL_AZURE_CLIENT_SECRET=${AZURE_CLIENT_SECRET}
export BBL_AZURE_REGION="westeurope"
export BBL_AZURE_SUBSCRIPTION_ID=${AZURE_SUBSCRIPTION_ID}
export BBL_AZURE_TENANT_ID=${AZURE_TENANT_ID}

bbl --debug up

bosh alias-env azure
bosh -e azure login
bosh -e azure deployments