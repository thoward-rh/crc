#!/bin/bash
# Download the argocd binary, place it under /usr/local/bin and give it execution permissions

VERSION=$(curl --silent "https://api.github.com/repos/argoproj/argo-cd/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')

curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/$VERSION/argocd-linux-amd64

#curl -L https://github.com/argoproj/argo-cd/releases/download/latest/argocd-linux-amd64 -o /usr/local/bin/argocd

chmod +x /usr/local/bin/argocd
