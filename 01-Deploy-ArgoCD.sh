# Create a new namespace for ArgoCD components

oc create namespace argocd

# Apply the ArgoCD Install Manifest

oc -n argocd apply -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Get the ArgoCD Server password

ARGOCD_SERVER_PASSWORD=$(oc -n argocd get pod -l "app.kubernetes.io/name=argocd-server" -o jsonpath='{.items[*].metadata.name}')