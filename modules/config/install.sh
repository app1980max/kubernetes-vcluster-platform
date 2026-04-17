#!/bin/bash
set -e

echo "Updating system..."
sudo apt-get update -y

echo "Installing base packages..."
sudo apt-get install -y docker.io jq curl wget unzip

# ------------------------------------------------
# Install vCluster
# ------------------------------------------------
echo "Installing vCluster..."
curl -L https://github.com/loft-sh/vcluster/releases/latest/download/vcluster-linux-amd64 -o vcluster
sudo install -c -m 0755 vcluster /usr/local/bin
rm -f vcluster

sleep 5

LATEST_URL=$(wget --no-check-certificate -qO- \
  https://api.github.com/repos/loft-sh/loft/releases/latest \
  | jq -r '.assets[] | select(.name | test("linux_amd64")) | .browser_download_url')

wget --no-check-certificate -O loft-linux-amd64.tar.gz "$LATEST_URL"
tar -xzf loft-linux-amd64.tar.gz
chmod +x loft
sudo mv loft /usr/local/bin/loft

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
            echo              "Installation complete" 
            echo "------------------------------------------------"

