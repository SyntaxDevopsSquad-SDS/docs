# Kubernetes

## Hvad er Kubernetes?

Kubernetes (forkortet K8s) er et open source container orchestration-system udviklet af Google og doneret til CNCF (Cloud Native Computing Foundation) i 2014. Det er i dag industri-standarden for at køre containeriserede applikationer i produktion.

Navnet kommer fra det græske ord for "rorsmand" eller "styringsmand" — en der holder styr på et skib.

## De grundlæggende begreber

### Pod
Den mindste deployerbare enhed i Kubernetes. En pod indeholder én eller flere containers der deler netværk og storage.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: whoknows-pod
spec:
  containers:
    - name: whoknows
      image: ghcr.io/syntaxdevopssquad-sds/whoknows-go:latest
      ports:
        - containerPort: 8080
```

### Deployment
Beskriver den ønskede tilstand — fx "kør 3 replicas af denne pod". Kubernetes sørger for at den faktiske tilstand matcher den ønskede.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: whoknows
spec:
  replicas: 3
  selector:
    matchLabels:
      app: whoknows
  template:
    spec:
      containers:
        - name: whoknows
          image: ghcr.io/syntaxdevopssquad-sds/whoknows-go:latest
```

### Service
Eksponerer pods til netværket. Da pods kan komme og gå (og skifte IP), giver en Service et stabilt endpoint.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: whoknows-service
spec:
  selector:
    app: whoknows
  ports:
    - port: 80
      targetPort: 8080
  type: LoadBalancer
```

### Namespace
Logisk adskillelse inden for et cluster. Fx kan `staging` og `production` leve i samme cluster men i hvert sit namespace.

### ConfigMap og Secret
ConfigMap til ikke-sensitiv konfiguration. Secret til passwords og tokens (base64-encoded).

## Arkitektur

Et Kubernetes cluster består af:

**Control Plane (master):**
- `kube-apiserver` — API-serveren, alt kommunikerer igennem den
- `etcd` — key-value store der gemmer cluster-state
- `kube-scheduler` — beslutter hvilken node en pod skal køre på
- `kube-controller-manager` — holder øje med at ønsket tilstand opretholdes

**Worker Nodes:**
- `kubelet` — agent der kører på hver node og kommunikerer med control plane
- `kube-proxy` — håndterer netværkstrafik
- Container runtime (fx containerd eller Docker)

## Kubernetes på Azure — AKS

Azure Kubernetes Service (AKS) er Azures managed Kubernetes-løsning. Microsoft styrer control plane — du betaler kun for worker nodes.

```bash
az aks create --resource-group myRG --name myAKS --node-count 3
az aks get-credentials --resource-group myRG --name myAKS
kubectl get nodes
```

## Nøglekommandoer

```bash
kubectl get pods                    # List alle pods
kubectl get deployments             # List alle deployments
kubectl get services                # List alle services
kubectl describe pod <navn>         # Detaljeret info om en pod
kubectl logs <pod-navn>             # Se logs
kubectl apply -f deployment.yaml    # Anvend en konfigurationsfil
kubectl delete -f deployment.yaml   # Slet ressourcer
kubectl scale deployment whoknows --replicas=5  # Skaler op
```

## Hvornår giver Kubernetes mening?

Kubernetes er kraftfuldt men komplekst. Det giver mening når du:
- Har mange microservices der skal orchestreres
- Har behov for automatisk skalering
- Har krav om høj availability
- Har et team der kan vedligeholde det

For et lille projekt som WhoKnows er Docker Compose på én VM sandsynligvis nok — men at kende K8s er vigtigt for erhvervslivet.
