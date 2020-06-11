#!/bin/bash

read -p "Existing Password: " ARGOCD_SERVER_PASSWORD
read -p "Password: " NEW_PASSWORD

ARGOCD_ROUTE=$(oc -n argocd get route argocd-server -o jsonpath='{.spec.host}')

# Login with the current admin password

argocd --insecure --grpc-web login ${ARGOCD_ROUTE}:443 --username admin --password ${ARGOCD_SERVER_PASSWORD}

# Update admin's password

argocd --insecure --grpc-web --server ${ARGOCD_ROUTE}:443 account update-password --current-password ${ARGOCD_SERVER_PASSWORD} --new-password $NEW_PASSWORD

exit 0
