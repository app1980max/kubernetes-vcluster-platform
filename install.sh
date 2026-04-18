#!/usr/bin/env sh

set -e
cat <<EOF
Typical installation of the vCluster based on Kubernetes
    1. ### Check Dependencies Before Install
    2. ### Deploy vCluster Platform 
    3. ### Create Virtual Clusters ( Dev\QA )
EOF
sleep 5
             echo      "----- ............................. -----"
             echo            "--- CHECK DEPENDENCIES ---"
             echo      "----- ............................. -----"
             
source modules/config/install.sh
sleep 5
             echo      "----- ............................. -----"
             echo           "---  LOAD-TERRAFORM-FILES  ---"
             echo      "----- ............................. -----"
sleep 5         
terraform init || { echo "Terraform init failed"; exit 1; }
terraform validate || exit 1 
TF_VARS_FILE=${TF_VARS_FILE:-template.tfvars}
terraform apply -var-file="$TF_VARS_FILE" -auto-approve

             echo      "----- ............................. -----"
             echo          "---  TERRAFORM-STATE-LIST  ---"
             echo      "----- ............................. -----"
sleep 5
terraform state list  && kubectl get ing -A
               printf "\nWaiting for application will be ready... \n"
printf "\nYou should see 'dashboard' as a reponse below (if you do the ingress is working):\n"

             echo      "----- ............................. -----"
             echo           "---  vCLUSTER IS READY  ---"
             echo      "----- ............................. -----"
             
