# Download the argocd binary, place it under /usr/local/bin and give it execution permissions

curl -L https://github.com/argoproj/argo-cd/releases/download/v1.2.2/argocd-linux-amd64 -o /usr/local/bin/argocd

chmod +x /usr/local/bin/argocd