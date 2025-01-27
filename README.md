# Kubernetes + Cue + ArgoCD Tutorial

```
# Install cue on Mac
brew install cue-lang/tap/cue

cue eval --expression output --out yaml

# Configure Golang modules and packages
go mod init github.com/skywalker-nick/presentation-cue
go mod tidy
cue mod init github.com/skywalker-nick/presentation-cue
cue get go k8s.io/api/core/v1
cue get go k8s.io/api/apps/v1

# Deploy templates
cue eval --expression output --out yaml | k apply -f-

# Verify deployment
k get svc
http://localhost:{NodePort}

# Install ArgoCD Locally
k create namespace argocd
k apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Install ArgoCD CLI
brew install argocd

# Patch ArgoCD and Expose it to Public (Port: 80)
k patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

# Get ArgoCD Admin Credentials
k -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# Login to ArgoCD from CLI
argocd login localhost

# Register your local K8S cluster into ArgoCD
argocd cluster add docker-desktop

# Deploy ArgoCD Integration
k apply -n argocd -f cmp-cue.yaml
k -n argocd patch deployments/argocd-repo-server --patch-file cmp-cue-sidecar.yaml

# Deploy Nginx Example Application
argocd app create -f nginx-app.yaml
```

# Build Cue Image
```
docker build . -t cuelang:latest
docker tag cuelang:latest skywalker25/cuelang:latest
docker push skywalker25/cuelang:latest
```

# Test Cue Image
```
docker-compose -f docker-compose.yml up
docker-compose exec test bash
```
