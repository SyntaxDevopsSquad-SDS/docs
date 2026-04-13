# Noter – Uge 03: GitHub Actions, Azure & Deploy

## Resumé

Ugen introducerede CI/CD automation med GitHub Actions og cloud deployment på Azure. Vi lærte GitHub Actions terminologi (workflows, runners, jobs, steps, actions) og oprettede vores første CI workflow til automatisk build og test. Azure blev introduceret som cloud platform hvor vi deployede en VM, konfigurerede SSH-adgang med key-based authentication, og åbnede network ports via NSG rules. SSH key pairs (public/private) blev gennemgået med fokus på sikkerhed - private key må aldrig deles. Deployment strategier blev diskuteret: push-based (CI pusher til server) vs pull-based (server puller fra Git), samt fordele ved Docker-baseret deployment hvor kodebase aldrig eksisterer på serveren.

---

## Vigtige pointer

*(Hvad ville du fremhæve til eksamen?)*

### GitHub Actions Terminologi

**Workflow:**

YAML-fil i `.github/workflows/` der definerer automated proces.

```yaml
# .github/workflows/ci.yml
name: CI Pipeline

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run tests
        run: go test ./...
```

**Komponenter:**

| Komponent | Forklaring | Eksempel |
|-----------|------------|----------|
| **Workflow** | Hele YAML-filen | `ci.yml` |
| **Trigger** | Event der starter workflow | `on: push` |
| **Job** | Samling af steps | `test:` |
| **Runner** | Server der eksekverer | `runs-on: ubuntu-latest` |
| **Step** | Individuel task | `- name: Run tests` |
| **Action** | Genbrugelig kodeblok | `actions/checkout@v4` |

**Runner Types:**

- **GitHub-hosted:** Ubuntu, Windows, macOS - managed af GitHub, clean environment hver gang
- **Self-hosted:** Egen server - bedre performance, custom software, men kræver maintenance

**Matrix Build:**

Parallel eksekvering på tværs af versioner/OS:

```yaml
jobs:
  test:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest]
        go-version: [1.21, 1.22, 1.23]
    steps:
      - uses: actions/setup-go@v4
        with:
          go-version: ${{ matrix.go-version }}
```

Resulterer i 6 parallelle jobs (2 OS × 3 Go versioner).

---

### GitHub Secrets Management

**Hvorfor secrets:**

API keys, tokens og passwords må ALDRIG hardcodes i workflows. GitHub Secrets krypterer og injicerer dem sikkert.

**Opret secret:**
Repository → Settings → Secrets and variables → Actions → New repository secret

**Brug i workflow:**

```yaml
steps:
  - name: Deploy to server
    env:
      SSH_PRIVATE_KEY: ${{ secrets.SSH_PRIVATE_KEY }}
      SERVER_IP: ${{ secrets.SERVER_IP }}
    run: |
      echo "$SSH_PRIVATE_KEY" > key.pem
      chmod 600 key.pem
      ssh -i key.pem user@$SERVER_IP "git pull && systemctl restart app"
```

**Best practices:**

- Aldrig log secrets (GitHub masker dem automatisk, men vær forsigtig)
- Separate secrets per environment (dev, staging, prod)
- Roter secrets regelmæssigt
- Minimum permissions - kun giv adgang til workflows der skal bruge dem

---

### Cloud Computing Basics

**Definition:**

On-demand adgang til compute resources (CPU, RAM, storage, networking) over internet. Pay-as-you-go model.

**Cloud Service Models:**

| Model | Beskrivelse | Eksempel |
|-------|-------------|----------|
| **IaaS** | Infrastructure as a Service - VM, netværk, storage | Azure VMs, AWS EC2 |
| **PaaS** | Platform as a Service - runtime environment, ingen OS management | Azure App Service, Heroku |
| **SaaS** | Software as a Service - færdig applikation | Gmail, Salesforce |

**Fordele:**

- **Elasticity:** Scale up/down efter behov
- **Pay-as-you-go:** Betal kun for hvad du bruger
- **Global reach:** Deploy til datacenters worldwide
- **High availability:** Redundancy og failover built-in

**Ulemper:**

- **Vendor lock-in:** Svært at skifte cloud provider
- **Costs can spiral:** Nem at glemme at slukke ressourcer
- **Less control:** Begrænset adgang til underlying infrastructure

---

### Azure Virtual Machine Setup

**VM Creation Process:**

Vi brugte Azure CLI scripts fra [EK_Azure repository](https://github.com/anderslatif/EK_Azure):

```bash
# Login til Azure
az login

# Clone scripts
git clone https://github.com/anderslatif/EK_Azure.git
cd EK_Azure

# Rediger til gratis tier (Standard_B2ats_v2)
nano scripts/virtual_machine/vm_create.sh
# Ændr linje 108: --size Standard_B2ats_v2

# Kør creation script
./scripts/virtual_machine/vm_create.sh
```

**Inputs:**
- Resource Group: `vmtest2` (container for alle relaterede resources)
- VM Name: `vm2`
- Username: `adminuser`
- SSH Key: Default (`~/.ssh/id_rsa.pub`)
- Region: `Switzerland North`

**Output:**
VM running
PublicIpAddress: 51.103.136.200

**Gratis Tier Overvejelser:**

Azure for Students giver **Standard_B2ats_v2** gratis:
- 750 timer/måned (hele måneden!)
- 2 vCPU, 1 GB RAM
- Perfekt til development og små projekter

---

### SSH - Secure Shell

**SSH Key Pair Authentication:**

Asymmetrisk kryptering - mere sikkert end passwords.

**Generer key pair:**

```bash
# Generer RSA key pair (4096-bit)
ssh-keygen -t rsa -b 4096 -C "marcus@stud.ek.dk"

# Output:
# Private key: ~/.ssh/id_rsa (HEMMELIG!)
# Public key: ~/.ssh/id_rsa.pub (kan deles)
```

**Public vs Private Key:**

| Key Type | Placering | Funktion | Kan deles? |
|----------|-----------|----------|------------|
| **Public Key** | Server (`~/.ssh/authorized_keys`) | Krypterer challenge | ✅ JA |
| **Private Key** | Lokal (`~/.ssh/id_rsa`) | Dekrypterer challenge | ❌ ALDRIG |

**SSH Handshake Flow:**

Client: "Jeg vil logge ind som adminuser"
Server: "OK, jeg krypterer en challenge med din public key"
Server → Client: [encrypted challenge]
Client: Dekrypterer med private key → returnerer svar
Server: "Svar matcher! Du er authenticated ✓"


**SSH ind på Azure VM:**

```bash
# First time - verify fingerprint
ssh adminuser@(VORES_VM_IP)

# Permanent connection
ssh adminuser@(VORES_VM_IP)
```

**SSH Security Best Practices:**

- ✅ Disable password authentication (kun key-based)
- ✅ Change default SSH port (22 → andet)
- ✅ Use fail2ban til at blokkere brute-force attempts
- ✅ Restrict SSH til specific IP addresses hvis muligt
- ❌ ALDRIG commit private key til Git
- ❌ ALDRIG reuse keys på tværs af servere

---

### Network Security Groups (NSG)

**Problem:** VM'er er som default lukket for al indgående trafik (undtagen SSH port 22).

**Løsning:** NSG rules åbner specifikke ports.

**Første forsøg (fejlede):**

```bash
az vm open-port --resource-group vmtest2 --name vm2 --port 8080
```

**Fejl:**
SecurityRuleConflict: Security rule open-port-22 conflicts with rule open-port-8080

**Hvorfor:**
- Azure havde allerede regel med priority 900 (SSH)
- `az vm open-port` prøvede at lave ny regel med samme priority
- Azure tillader ikke duplicate priorities

**Løsning - manual NSG rule:**

```bash
az network nsg rule create \
  --resource-group vmtest2 \
  --nsg-name vm2NSG \
  --name allow-port-8080 \
  --priority 1001 \
  --destination-port-ranges 8080 \
  --access Allow \
  --protocol Tcp
```

**Parameter forklaring:**

| Parameter | Værdi | Forklaring |
|-----------|-------|------------|
| `--resource-group` | `vmtest2` | Resource group |
| `--nsg-name` | `vm2NSG` | Network Security Group (auto-genereret navn) |
| `--name` | `allow-port-8080` | Rule navn |
| `--priority` | `1001` | Højere end eksisterende (900, 1000) |
| `--destination-port-ranges` | `8080` | Port at åbne |
| `--access` | `Allow` | Tillad trafik |
| `--protocol` | `Tcp` | TCP protokol |

**NSG Priority System:**

- Lavere nummer = højere prioritet
- Regler evalueres i priority order
- Første match vinder
- Range: 100-4096

**Verificering:**

```bash
# Test fra lokal maskine
curl http://(VORES_VM_IP)0:8080

# Eller browser
http://(VORES_VM_IP):8080
```

---

### Deployment Strategies

**Push-based Deployment:**

CI/CD system pusher kode til server.

```yaml
# .github/workflows/cd.yml
- name: Deploy via SSH
  run: |
    ssh user@server "cd /app && git pull && systemctl restart app"
```

**Fordele:**
- ✅ Centraliseret kontrol (deployment fra CI)
- ✅ Deployment logs i CI/CD system
- ✅ Kan deploye til multiple servers fra ét sted

**Ulemper:**
- ❌ CI behøver SSH adgang til server (security risk)
- ❌ Firewall skal tillade inbound SSH fra CI IP
- ❌ Secrets management kompleksitet

**Pull-based Deployment:**

Server puller kode fra Git repository.

```bash
# På server (via cron eller webhook)
cd /app
git pull origin main
systemctl restart app
```

**Fordele:**
- ✅ Server initierer deployment (ingen inbound SSH nødvendig)
- ✅ Simplere security model
- ✅ Server beslutter hvornår den puller

**Ulemper:**
- ❌ Kodebase skal eksistere på server
- ❌ Git credentials på server
- ❌ Mindre centraliseret kontrol

**Docker-based Deployment (Hybrid):**

Bedste af begge verdener - vi bruger dette i WhoKnows!

```yaml
# CI: Build og push image
- name: Build Docker image
  run: docker build -t ghcr.io/org/app:latest .
- name: Push to registry
  run: docker push ghcr.io/org/app:latest

# CD: Pull og kør på server
- name: Deploy
  run: |
    ssh user@server "docker pull ghcr.io/org/app:latest && \
                     docker stop app && \
                     docker run -d --name app ghcr.io/org/app:latest"
```

**Fordele:**
- ✅ Kodebase aldrig på server (kun container image)
- ✅ Ingen Git credentials på server
- ✅ Consistent environment (image identisk overalt)
- ✅ Rollback = deploy tidligere image tag

---

### Static IP Addressing

**Problem:** Azure VM's public IP ændres ved VM restart (dynamic IP).

**Løsning:** Sæt IP til static.

```bash
# Find public IP resource navn
az network public-ip list --resource-group vmtest2

# Ændr allocation method til static
az network public-ip update \
  --resource-group vmtest2 \
  --name vm2PublicIP \
  --allocation-method Static
```

**Hvorfor vigtigt:**

- DNS records (A-record peger til IP)
- Firewall rules (whitelist specific IP)
- Configuration management (hardcoded IP i scripts)

**Verificering:**

```bash
# Restart VM
az vm restart --resource-group vmtest2 --name vm2

# Check IP er samme
az vm show -d --resource-group vmtest2 --name vm2 --query publicIps -o tsv
```

IP forbliver `51.103.136.200` ✓

---

## Forbindelser til WhoKnows-projektet

*(Hvordan relaterer dette til jeres eget projekt?)*

### Vores CI/CD Pipeline

**CI Workflow (`.github/workflows/ci.yml`):**

```yaml
name: CI Pipeline

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Set up Go
        uses: actions/setup-go@v4
        with:
          go-version: '1.23'
      
      - name: Install dependencies
        run: |
          cd implementations/go/backend
          go mod download
      
      - name: Run tests
        run: |
          cd implementations/go/backend
          go test -v ./...
      
      - name: Run linter
        run: |
          cd implementations/go/backend
          golangci-lint run
```

**Hvad sker der:**

1. Trigger ved push/PR til main
2. Checkout kode
3. Setup Go 1.23
4. Download dependencies
5. Kør unit + integration tests
6. Kør golangci-lint (code quality)

**CD Workflow (`.github/workflows/cd.yml`):**

Deployer til Azure VM efter successful CI.

```yaml
name: CD Pipeline

on:
  workflow_run:
    workflows: ["CI Pipeline"]
    types: [completed]
    branches: [main]

jobs:
  deploy:
    if: ${{ github.event.workflow_run.conclusion == 'success' }}
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to Azure VM
        env:
          SSH_PRIVATE_KEY: ${{ secrets.SSH_PRIVATE_KEY }}
          SERVER_IP: ${{ secrets.SERVER_IP }}
        run: |
          # Setup SSH
          mkdir -p ~/.ssh
          echo "$SSH_PRIVATE_KEY" > ~/.ssh/deploy_key
          chmod 600 ~/.ssh/deploy_key
          
          # Deploy (Docker pull strategy)
          ssh -i ~/.ssh/deploy_key -o StrictHostKeyChecking=no \
            adminuser@$SERVER_IP \
            "docker pull ghcr.io/syntaxdevopssquad-sds/whoknows:latest && \
             docker-compose -f /opt/whoknows/docker-compose.yml up -d"
```

**Deployment Flow:**

Developer push til main
CI workflow trigger
├─ Build Go binary
├─ Run tests
└─ Build Docker image → Push til GHCR
CD workflow trigger (kun hvis CI succeeds)
├─ SSH ind på Azure VM
├─ Docker pull latest image
└─ docker-compose up -d (restart containers)
WhoKnows kører med ny kode ✓


### Azure VM Configuration

**Vores VM specs:**

- **Size:** Standard_B2ats_v2 (gratis tier)
- **OS:** Ubuntu 22.04 LTS
- **IP:** Static (`51.103.136.200`)
- **Region:** Switzerland North
- **Ports open:** 22 (SSH), 8080 (HTTP)

**NSG Rules:**

| Priority | Name | Port | Protocol | Source | Action |
|----------|------|------|----------|--------|--------|
| 900 | allow-ssh | 22 | TCP | Any | Allow |
| 1001 | allow-port-8080 | 8080 | TCP | Any | Allow |

### SSH Setup

**Key pair genereret:**

```bash
ssh-keygen -t rsa -b 4096 -C "devops@syntaxsquad.dk"
```

**Public key uploaded til Azure under VM creation.**

**Private key gemt i:**
- Lokal: `~/.ssh/id_rsa`
- GitHub Secret: `SSH_PRIVATE_KEY` (til CD workflow)

**SSH config (`~/.ssh/config`):**
Host whoknows-prod
HostName 51.103.136.200
User adminuser
IdentityFile ~/.ssh/id_rsa
StrictHostKeyChecking no

Nu kan vi SSH med: `ssh whoknows-prod`

### Deployment Strategy Valgt

**Vi bruger Docker-based deployment:**

**Hvorfor ikke Git pull:**
- ❌ Kodebase skulle eksistere på server
- ❌ Git credentials på server
- ❌ Go build dependencies på server

**Hvorfor Docker:**
- ✅ Ingen kodebase på server (kun image)
- ✅ Consistent environment
- ✅ Easy rollback (`docker run ghcr.io/org/app:v1.2.3`)
- ✅ Separation of concerns (CI builder, server kører)

**Docker Compose på server:**

```yaml
# /opt/whoknows/docker-compose.yml
version: '3.8'

services:
  whoknows:
    image: ghcr.io/syntaxdevopssquad-sds/whoknows:latest
    container_name: whoknows-app
    ports:
      - "8080:8080"
    environment:
      - SECRET_KEY=${SECRET_KEY}
      - DB_PATH=/data/whoknows.db
    volumes:
      - ./data:/data
    restart: unless-stopped
```

**Deployment kommando:**

```bash
# Pull nyeste image
docker pull ghcr.io/syntaxdevopssquad-sds/whoknows:latest

# Genstart containers med ny image
docker-compose -f /opt/whoknows/docker-compose.yml up -d
```

### GitHub Secrets Configuration

**Secrets vi bruger:**

| Secret Name | Værdi | Bruges til |
|-------------|-------|------------|
| `SSH_PRIVATE_KEY` | Private SSH key | CD deployment til Azure VM |
| `SERVER_IP` | `51.103.136.200` | Azure VM IP address |
| `CR_PAT` | GitHub Personal Access Token | Push Docker images til GHCR |

**Sikret at:**
- ✅ Secrets aldrig logges i workflow output
- ✅ Kun CD workflow har adgang til SSH_PRIVATE_KEY
- ✅ CR_PAT har minimal permissions (packages:write)

---

## Eksamen Talking Points

**"Forklar GitHub Actions terminologi med eksempel fra jeres projekt"**

Vi har en CI workflow der trigger ved push til main. Workflowet definerer et job kaldet "test" der kører på en GitHub-hosted Ubuntu runner. Jobbet indeholder flere steps: checkout kode (med actions/checkout action), setup Go, download dependencies, run tests og run linter. Hvis alle steps succeeds, trigger vores CD workflow der deployer til Azure.

**"Hvad er forskellen mellem public og private SSH keys?"**

Public key kan deles frit og placeres på serveren i `~/.ssh/authorized_keys`. Den bruges til at kryptere challenges. Private key må ALDRIG deles og ligger kun lokalt i `~/.ssh/id_rsa`. Den bruges til at dekryptere challenges og bevise identitet. Hvis nogen får fat i din private key, har de fuld adgang til alle servere med din public key.

**"Hvordan åbnede I port 8080 på jeres Azure VM?"**

Vi brugte `az network nsg rule create` med priority 1001 (højere end eksisterende SSH rule på 900). Vi specificerede destination port 8080, protocol TCP og access Allow. Det oprettede en regel i vm2NSG (Network Security Group) der tillader indgående trafik på port 8080 fra alle IP-adresser.

**"Push-based vs pull-based deployment - hvad bruger I og hvorfor?"**

Vi bruger en hybrid Docker-baseret approach. CI builder og pusher Docker image til GitHub Container Registry (push-baseret build). CD workflow SSH'er ind på serveren og kører `docker pull` + `docker-compose up` (pull-baseret deployment). Det giver os fordelene ved begge: centraliseret build i CI, men serveren puller selv images. Kodebasen eksisterer aldrig på serveren, kun container images.

**"Hvorfor satte I VM IP til static?"**

Fordi dynamic IP ændrer sig ved VM restart. Vores DNS A-record peger til IP'en, og vores CD workflow SSH'er til IP'en. Hvis IP'en skiftede, skulle vi opdatere både DNS og GitHub Secrets hver gang. Static IP sikrer at `51.103.136.200` forbliver konstant.

**"Hvordan sikrer I at secrets ikke lækker i GitHub Actions?"**

Vi bruger GitHub Secrets til at kryptere SSH private key, server IP og GitHub tokens. I workflows refererer vi til dem med `${{ secrets.NAME }}` syntax. GitHub masker automatisk secret værdier i logs. Vi passer på aldrig at echo secrets eller gemme dem i filer der committes. CD workflow sletter SSH key efter brug.
