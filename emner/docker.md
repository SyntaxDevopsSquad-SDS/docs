# 🧩 Emne: Docker & Containerization

## Hvad er det?
Docker er en platform til at bygge, distribuere og køre applikationer i containers. En container er en isoleret, letvægts eksekverbar enhed der indeholder alt hvad en applikation skal bruge for at køre — kode, runtime, libraries og settings. Containers deler hostens kernel i modsætning til virtuelle maskiner der kræver et helt OS per miljø.

## Hvorfor er det vigtigt i DevOps?
Containers løser "It Works on My Machine"-problemet ved at sikre konsistente miljøer fra development til production. De understøtter hurtig deployment, skalering og isolation — centrale DevOps-principper. Docker abstraherer infrastruktur, specialisering og automation, hvilket øger produktiviteten markant.

## Centrale begreber

| Begreb | Forklaring |
|--------|-----------|
| Image | Blueprint/opskrift til en container — uforanderlig |
| Container | En kørende instans af et image |
| Volume | Persistent ekstern storage der overlever container-sletning |
| Dockerfile | Fil der definerer hvordan et image bygges |
| Docker Hub | Offentligt registry til Docker images |
| GHCR | GitHub Container Registry — privat/offentligt registry |
| Namespace | Linux-kernel feature der isolerer processer |
| cgroups | Linux-kernel feature der begrænser ressourceforbrug (CPU, memory) |
| Hypervisor | Software der kører virtuelle maskiner (VMware, VirtualBox) |
| .dockerignore | Fil der ekskluderer filer fra build context (ligesom .gitignore) |
| Layer | Hvert Dockerfile-instruktion skaber et lag — caches for hurtigere builds |
| ENTRYPOINT | Definerer hovedkommandoen i containeren — kan ikke overrides nemt |
| CMD | Standardkommando ved opstart — kan overrides ved `docker run` |
| RUN | Køres under build-fasen til at sætte imaget op |

## Forbindelser til andre emner
- **CI/CD** — Docker images bygges og pushes i pipelines (GitHub Actions)
- **Cloud & Azure** — Containers deployes til cloud via Docker Compose eller Kubernetes
- **DevSecOps** — Non-root users i Dockerfile, .dockerignore for secrets
- **Monitoring** — ctop og lazydocker til at monitorere containers

## Eksempel fra WhoKnows-projektet
Vi har Dockeriseret vores Go-applikation med en Dockerfile i `implementations/go/`. Docker Compose bruges til at køre applikationen med en volume der persister SQLite-databasen på `/data`. I CD-pipelinen bygges og pushes imaget til GHCR, hvorefter det deployes på vores Azure-server via SSH.

```dockerfile
# Vores setup i docker-compose.yml
services:
  whoknows:
    image: ghcr.io/syntaxdevopssquad-sds/whoknows-go:latest
    volumes:
      - /opt/whoknows/implementations/go/backend:/data
    ports:
      - "8080:8080"
```

## Mulige eksamensspørgsmål
- [ ] Hvad er forskellen på en container og en virtuel maskine?
- [ ] Hvad er forskellen på RUN, CMD og ENTRYPOINT i en Dockerfile?
- [ ] Hvad er Docker layers og hvordan optimerer man dem?
- [ ] Hvad er et Docker volume og hvornår bruger man det?
- [ ] Hvad er namespaces og cgroups og hvilken rolle spiller de i containerization?
- [ ] Hvorfor er det vigtigt at bruge en non-root user i en Dockerfile?
- [ ] Hvad er forskellen på `docker build` og `docker compose`?
- [ ] Hvad er semantic versioning og hvordan bruges det i Docker image tags?
- [ ] Hvordan sikrer man at databasen ikke lækkes i et public Docker image?

## Læringsmål
- [ ] Forstår forskellige niveauer af build tools — fra OS-niveau (apt, brew, choco) til sprog-specifikke (pip, npm, go mod)
- [ ] Forstår forskellen på packaging og virtualization/containerization
- [ ] Forstår hvordan Docker adskiller sig fra forgængere (chroot, FreeBSD jail, LXC) og moderne alternativer (Podman, containerd, Kata Containers)
- [ ] Kan læse og forstå simple Dockerfiles for forskellige sprog (Python, Node.js, Go)

## Relevante uger
- Uge 5 (Docker, Continuous Delivery, The Simulation)
- Uge 6 (Docker Compose, Dockerization af WhoKnows)
