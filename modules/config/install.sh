#!/bin/bash
set -e

# ------------------------------------------------
# Terraform
# ------------------------------------------------
echo "Checking Terraform..."
if command -v terraform &> /dev/null
then
    echo "Terraform already installed: $(terraform version | head -n1)"
else
    echo "Installing Terraform..."
    TERRAFORM_VERSION="1.10.4"

    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip

    sudo mv terraform /usr/local/bin/
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
fi

# ------------------------------------------------
# Helm
# ------------------------------------------------
echo "Checking Helm..."
if command -v helm &> /dev/null
then
    echo "Helm already installed: $(helm version --short)"
else
    echo "Installing Helm..."
    HELM_VERSION="v3.13.3"

    curl -LO https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz
    tar -xzf helm-${HELM_VERSION}-linux-amd64.tar.gz

    sudo mv linux-amd64/helm /usr/local/bin/helm
    rm -rf linux-amd64 helm-${HELM_VERSION}-linux-amd64.tar.gz
fi

# ------------------------------------------------
# kubectl
# ------------------------------------------------
echo "Checking kubectl..."
if command -v kubectl &> /dev/null
then
    echo "kubectl already installed: $(kubectl version --client --short)"
else
    echo "Installing kubectl..."
    KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)

    curl -LO https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
fi

            echo "------------------------------------------------"
            echo                  "Completed" 
            echo "------------------------------------------------"

