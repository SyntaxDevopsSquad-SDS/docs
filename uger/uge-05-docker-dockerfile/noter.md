# Noter – Uge 05: Docker, Dockerfile, Build Tools & Virtualization

---

## Resumé

Ugen introducerede Docker som containeriseringsplatform og satte det i kontekst af en bredere historik — fra chroot (1979) over FreeBSD Jail til moderne container-runtimes. Vi skelner klart mellem virtualization (fuld OS per VM via hypervisor) og containerization (delt kernel, letvægts). Docker muliggøres af to Linux-kernel-features: **namespaces** (isolation) og **cgroups** (ressourcebegrænsning). Vi gennemgik Dockerfile-instruktioner (FROM, WORKDIR, COPY, RUN, CMD, ENTRYPOINT), Docker layer-caching som optimeringsmekanisme, volumes til persistent data, og netværk til container-kommunikation. Build tools og packaging-typer (source, binary, container, library) samt semantic versioning blev gennemgået som kontekst for distribution.

---

## Vigtige pointer

### Virtualization vs. Containerization

- **Virtualization**: Kræver en hypervisor og et fuld OS per VM — tungt og langsomt at starte op
- **Containerization**: Containers deler host-kernelen — ingen fuld OS per app. Letvægts og hurtigt
- Docker muliggøres af **namespaces** (isolerer processers syn på filsystem, netværk, PID) og **cgroups** (begrænser CPU/memory/I/O)
- Containers løser "works on my machine"-problemet: samme image kører identisk på dev, staging og prod

### Docker-historik (eksamensrelevant)
- **1979-82**: `chroot` i Unix — første primitive isolation
- **1999**: FreeBSD Jail — containers kaldes stadig "jails" nogle steder
- **2001-2008**: Linux VServer, OpenVZ, cgroups (Google), LXC
- **2013**: Docker lanceres — skrevet i Go, demokratiserer containerization

### Dockerfile — instruktioner og rækkefølge

```dockerfile
FROM python:3.9-slim        # Base image — altid første linje
WORKDIR /usr/src/app        # Sætter arbejdsmappe
COPY requirements.txt ./    # Kopiér kun det nødvendige først (layer-optimering)
RUN pip install -r requirements.txt  # Kør under build
COPY . .                    # Kopiér resten af koden
EXPOSE 8080                 # Dokumentation (publisher ikke porten)
CMD ["python", "app.py"]    # Default-kommando ved opstart
```

**RUN vs CMD vs ENTRYPOINT:**
- `RUN` → build-tid, kan bruges mange gange (installer dependencies, setup)
- `CMD` → runtime default-kommando, kan overrides med `docker run <image> <cmd>`
- `ENTRYPOINT` → runtime hoved-kommando, kan kombineres med CMD for fleksibilitet

### Docker Layer Caching — optimering

Docker genbruger uændrede lag fra cache. **Kopiér dependencies-filen INDEN koden** så npm/pip install ikke gentages ved ren kode-ændring:

```dockerfile
# ❌ Uoptimeret — npm install kører ved HVER kode-ændring
COPY . .
RUN npm install

# ✅ Optimeret — npm install kører kun når package.json ændres
COPY package*.json ./
RUN npm install
COPY . .
```

### Non-root User (sikkerhed)

Best practice: kør ikke som root i containeren. Opret en dedikeret system-bruger:

```dockerfile
RUN adduser --system --home /home/appuser appuser
# ... install dependencies ...
USER appuser
```

### .dockerignore

Ekskluder filer der ikke skal med i image — reducerer build context og forhindrer at secrets lækker:

```
**/.git
**/.venv
**/__pycache__
**/*.db
**/*.sqlite
**/secrets.dev.yaml
```

### Volumes — brug cases

- Database-data (SQLite/MySQL-filer persisteres uden for containeren)
- Konfigurationsfiler (nginx.conf mountes ind)
- Delt data mellem containers (shared volume)
- Logfiler, SSL-certifikater, backup

### Docker Networking

Containers på samme network kan kommunikere via container-navn (DNS):

```bash
docker network create mynetwork
docker run --name container1 --network mynetwork alpine
docker run --name container2 --network mynetwork alpine
# container1 kan pinge container2 ved navn
```

Port-mapping: `-p <host>:<container>` — fx `-p 8080:80` eksponerer containerens port 80 på host-port 8080.

### Packaging og distribution

| Type | Eksempler |
|------|-----------|
| Source code | `.zip`, `.tar.gz`, `requirements.txt` |
| Binary | `.exe`, `.jar`, `.deb`, `.rpm` |
| Container | Docker image (DockerHub, GHCR) |
| Library | npm packages, pip packages, Go modules |

### Semantic Versioning

`MAJOR.MINOR.PATCH`:
- **PATCH**: Bugfix, bagudkompatibel
- **MINOR**: Ny funktionalitet, bagudkompatibel
- **MAJOR**: Breaking changes

---

## Forbindelser til WhoKnows-projektet

### Vores Dockerfile-setup

Vi har Dockerized vores Go backend. Relevante overvejelser i vores kontekst:

**Layer-optimering i Go:**
```dockerfile
FROM golang:1.21-alpine
WORKDIR /app
COPY go.mod go.sum ./    # Kopiér module-filer først
RUN go mod download      # Download dependencies — cached hvis go.mod uændret
COPY . .
RUN go build -o main .
CMD ["./main"]
```

**Database-problemet:**
SQLite-databasen må IKKE inkluderes i image (image er offentligt på GHCR). Løsning: database-filen monteres som volume på serveren, eller backups håndteres via scripts uden for image.

**Non-root user:**
Bør implementeres i vores Go Dockerfile for privilege separation — reducerer skadeomfanget ved eventuel exploit.

**.dockerignore:**
Vi bør ekskludere `.db`/`.sqlite`-filer, `.env`, og eventuelle secrets fra build context — forhindrer at data lækker ind i det offentlige image.

**Artifact Repository:**
Vi publisher vores images til **GHCR (GitHub Container Registry)** via CI/CD pipeline — integrerer direkte med vores GitHub Actions workflows.

**Containerization som DevOps-enabler:**
- Løser "works on my machine": alle kører identisk miljø via Docker
- Portabilitet: samme image fra lokal dev til Azure VM
- Isolering: Go backend, database og eventuel Nginx kan køre i separate containers

---

## Eksamen Talking Points

**"Hvad er forskellen på virtualization og containerization?"**
VMs kræver en hypervisor og et fuldt OS per instans — tungt og langsomt. Containers deler host-kernelen og er letvægts. Docker bruger Linux namespaces til isolation og cgroups til ressourcestyring. Containere starter på sekunder, VMs på minutter.

**"Hvorfor containerize?"**
Portabilitet (kører ens overalt), reproducerbarhed (løser works-on-my-machine), isolation (separate dependencies), skalerbarhed, og hurtig opsætning af komplekse miljøer med ét kommando.

**"Forklar vores Dockerfile"**
Vi kan gennemgå vores Go Dockerfile linje for linje: base image, WORKDIR, dependency-kopiering og download (layer-cache optimering), kode-kopiering, build og CMD. Vi kører (eller bør køre) som non-root user.

**"Hvad er Docker layer caching og hvorfor er det vigtigt?"**
Hvert Dockerfile-trin skaber et lag. Uændrede lag genbruges fra cache. Hvis man kopierer kode FØR man installerer dependencies, kører install-steget ved ENHVER kode-ændring. Korrekt rækkefølge (COPY dependencies → RUN install → COPY kode) sparer markant build-tid i CI/CD.

**"Hvad er semantic versioning?"**
MAJOR.MINOR.PATCH. PATCH for bugfixes, MINOR for ny bagudkompatibel funktionalitet, MAJOR ved breaking changes. Vi bruger det til at versionere vores Docker images i GHCR.
