#!/bin/bash
# Patch ArgoCD Server so no TLS is configured on the server (--insecure)

PATCH='{"spec":{"template":{"spec":{"$setElementOrder/containers":[{"name":"argocd-server"}],"containers":[{"command":["argocd-server","--insecure","--staticassets","/shared/app"],"name":"argocd-server"}]}}}}'

oc -n argocd patch deployment argocd-server -p $PATCH

# Expose the ArgoCD Server using an Edge OpenShift Route so TLS is used for incoming connections

oc -n argocd create route edge argocd-server --service=argocd-server --port=http --insecure-policy=Redirect
