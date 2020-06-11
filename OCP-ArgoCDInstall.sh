#!/bin/bash

#Check if CLI tools are installed

FILE=/usr/local/bin/argocd
if test -f "$FILE"; then
    echo "$FILE exists."
else
    echo "$FILE does not exist."
    exit 1
fi

### Start of PART 1

# Create a new namespace for ArgoCD components

oc create namespace argocd

# Apply the ArgoCD Install Manifest

oc -n argocd apply -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Get the ArgoCD Server password

ARGOCD_SERVER_PASSWORD=$(oc -n argocd get pod -l "app.kubernetes.io/name=argocd-server" -o jsonpath='{.items[*].metadata.name}')

### End of PART 1
sleep 5
### Start of PART 2
# Patch ArgoCD Server so no TLS is configured on the server (--insecure)

PATCH='{"spec":{"template":{"spec":{"$setElementOrder/containers":[{"name":"argocd-server"}],"containers":[{"command":["argocd-server","--insecure","--staticassets","/shared/app"],"name":"argocd-server"}]}}}}'

oc -n argocd patch deployment argocd-server -p $PATCH

# Expose the ArgoCD Server using an Edge OpenShift Route so TLS is used for incoming connections

oc -n argocd create route edge argocd-server --service=argocd-server --port=http --insecure-policy=Redirect

### End of PART 2
sleep 5

### Start of PART 3
# Get ArgoCD Server Route Hostname

ARGOCD_ROUTE=$(oc -n argocd get route argocd-server -o jsonpath='{.spec.host}')

# Login with the current admin password

#argocd --insecure --grpc-web login ${ARGOCD_ROUTE}:443 --username admin --password ${ARGOCD_SERVER_PASSWORD}

# Update admin's password

#argocd --insecure --grpc-web --server ${ARGOCD_ROUTE}:443 account update-password --current-password ${ARGOCD_SERVER_PASSWORD} --new-password $NEW_ARGOCD_PASSWORD

echo 'Password for argo admin is: '$ARGOCD_SERVER_PASSWORD
echo 'Login at: https://'$ARGOCD_ROUTE 

exit 0

