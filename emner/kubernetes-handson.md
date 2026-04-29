# Kubernetes — Hands-on

## Formål

Hands-on sessionen giver praktisk erfaring med at deploye en applikation til Kubernetes og forstå de grundlæggende kubectl-kommandoer.

## Minikube — Kubernetes lokalt

Minikube kører et enkelt-node Kubernetes cluster lokalt — perfekt til at lære og teste.

```bash
# Installer og start
minikube start

# Tjek status
minikube status
kubectl get nodes
```

## Øvelse: Deploy en applikation

### 1. Opret et Deployment

```bash
kubectl create deployment hello-nginx --image=nginx:latest
kubectl get deployments
kubectl get pods
```

### 2. Eksponer med en Service

```bash
kubectl expose deployment hello-nginx --port=80 --type=NodePort
kubectl get services
minikube service hello-nginx  # Åbn i browser
```

### 3. Skaler op

```bash
kubectl scale deployment hello-nginx --replicas=3
kubectl get pods  # Se at der nu er 3 pods
```

### 4. Rolling update

```bash
kubectl set image deployment/hello-nginx nginx=nginx:1.25
kubectl rollout status deployment/hello-nginx
kubectl rollout history deployment/hello-nginx
```

### 5. Rollback

```bash
kubectl rollout undo deployment/hello-nginx
kubectl rollout status deployment/hello-nginx
```

## Øvelse: Deploy med YAML

Opret filen `whoknows-deployment.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: whoknows
  labels:
    app: whoknows
spec:
  replicas: 2
  selector:
    matchLabels:
      app: whoknows
  template:
    metadata:
      labels:
        app: whoknows
    spec:
      containers:
        - name: whoknows
          image: nginx:latest
          ports:
            - containerPort: 80
          resources:
            requests:
              memory: "64Mi"
              cpu: "250m"
            limits:
              memory: "128Mi"
              cpu: "500m"
---
apiVersion: v1
kind: Service
metadata:
  name: whoknows-service
spec:
  selector:
    app: whoknows
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: NodePort
```

```bash
kubectl apply -f whoknows-deployment.yaml
kubectl get all
```

## Docker Swarm vs Kubernetes — praktisk sammenligning

Docker Swarm er enklere at komme i gang med:

```bash
# Swarm
docker swarm init
docker service create --replicas 3 -p 80:80 --name web nginx

# Kubernetes ækvivalent
kubectl create deployment web --image=nginx --replicas=3
kubectl expose deployment web --port=80 --type=NodePort
```

Swarm bruger Docker Compose-syntaks som vi kender, men Kubernetes er mere kraftfuldt og er industri-standarden.

## Nyttige kommandoer til fejlfinding

```bash
kubectl describe pod <pod-navn>       # Detaljeret status og events
kubectl logs <pod-navn>               # Container logs
kubectl logs <pod-navn> --previous    # Logs fra forrige crashed container
kubectl exec -it <pod-navn> -- bash   # Shell inde i container
kubectl get events --sort-by=.lastTimestamp  # Cluster events
```

## Cleanup

```bash
kubectl delete -f whoknows-deployment.yaml
# eller
kubectl delete deployment whoknows
kubectl delete service whoknows-service
minikube stop
```
