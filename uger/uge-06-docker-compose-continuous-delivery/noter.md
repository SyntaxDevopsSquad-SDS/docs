# Noter – Uge 06: Docker Compose, Continuous Delivery & Agile

---

## Resumé

Ugen byggede videre på Docker ved at introducere Docker Compose til multi-container setups og sætte det i kontekst af Continuous Delivery. Vi skelner skarpt mellem `docker-compose` (gammel, Python) og `docker compose` (ny plugin, Go) — de er ikke interchangeable. Live reload i Docker kræver bind mounts + et dev-specifikt setup (separat Dockerfile og compose-fil). Continuous Delivery handler om at holde koden deployerbar til enhver tid — med automatik til staging og manuel godkendelse til produktion. Agile og DevOps blev introduceret historisk: Agile Manifesto (2001) som reaktion på vandfaldsmodellen, DevOps som kulturel forlængelse der bryder Dev/Ops-siloer. Ugens princip: **Automate everything** (A i CALMS).

---

## Vigtige pointer

### Docker Compose — hvad og hvorfor

Docker Compose giver ét YAML-interface til at definere, starte og stoppe alle services i en applikation:

```bash
docker compose up --build    # Start alle services
docker compose down          # Stop og fjern containers
docker compose logs app      # Se logs for specifik service
docker compose ps            # Se kørende services
docker compose ps -a         # Se alle services inkl. stoppede
docker compose exec app env  # Kør kommando i container
```

**Fordele over rene Dockerfiles:**
- Multi-container management med ét kommando
- Netværk oprettes automatisk — services taler via service-navn
- Volumes og environment variables defineres centralt
- Nem at skelne dev- og prod-setup med separate filer

### `docker-compose` vs. `docker compose` — VIGTIGT

De er **ikke** interchangeable — image-navngivning er forskellig:

```bash
docker-compose build web   # → image: node_project_web  (underscore)
docker compose build web   # → image: node_project-web  (hyphen)
```

Dette påvirker scripts og CI/CD der refererer til image-navne. I kurset bruges konsekvent `docker compose` (med mellemrum).

### Networking i Compose

Compose opretter automatisk et default-netværk (`<mappenavn>_default`). Services kan kommunikere via service-navn:

```yaml
services:
  app:
    build: .
    ports:
      - "3000:80"
  db:
    image: postgres
    environment:
      POSTGRES_USER: root
      POSTGRES_PASSWORD: pass123
```

Her kan `app` forbinde til `db` via hostname `db` — ingen IP-adresser nødvendigt. Hvis services er på **separate** definerede netværk, kan de ikke nå hinanden (som vi så i debug-øvelsen).

### Volumes vs. Bind Mounts

| | Volumes | Bind Mounts |
|---|---|---|
| Styret af | Docker | Host-filsystem |
| Brug | Produktion, database-data | Development, live reload |
| Portabilitet | Høj | Afhænger af host-sti |
| Performance | Bedre på Docker Desktop | Kan være langsommere |

### Hot Reload i Docker (development-setup)

Live reload kræver:
1. Et dev-specifikt tool (`nodemon`, `air` til Go)
2. Bind mount så container ser host-filændringer
3. Separat `Dockerfile.dev` og `docker-compose.dev.yml`

```yaml
# docker-compose.dev.yml
services:
  backend:
    build:
      context: ./app
      dockerfile: Dockerfile.dev
    ports:
      - "8080:8080"
    volumes:
      - ./app:/usr/src/app            # Bind mount — live reload
      - backend_node_modules:/usr/src/app/node_modules  # Cache node_modules

volumes:
  backend_node_modules:
```

```bash
docker compose -f docker-compose.dev.yml up --build
```

**Vigtigt**: Dette setup er KUN til development — ikke til produktion.

### Continuous Delivery — definitioner og distinktioner

```
CI → CD (Delivery) → CD (Deployment)
```

- **CI**: Automatisk build + test ved hvert push
- **Continuous Delivery**: Automatisk til staging, **manuel** godkendelse til prod — koden er altid klar
- **Continuous Deployment**: Fuldt automatisk hele vejen til produktion

Definitionen er flydende og varierer mellem organisationer — vigtigst er at forstå *intentionen*: altid have deployerbar kode.

**GitHub Packages / GHCR:**

```yaml
# I docker-compose.yml — image navngives under org-namespace
services:
  backend:
    build: ./backend
    image: ghcr.io/<org_name>/<image_name>:latest
```

CI/CD-pipeline builder og pusher image til GHCR, production-server puller derfra.

### Agile og Vandfaldsmodellen

**Vandfaldsmodellen** (sekventiel):
Feasibility → Krav → Design → Implementation → Test → Deploy

Problemer: Svær at ændre undervejs, feedback kommer sent og dyrt.

**Agile Manifesto (2001)** — fire værdier:
1. **Individer og interaktioner** over processer og værktøjer
2. **Fungerende software** over udtømmende dokumentation
3. **Samarbejde med kunden** over kontraktforhandling
4. **Reagere på ændringer** over at følge en plan

Agile er ikke et universalmiddel — forskning viser at store organisationer har svært ved det og ender med hybridmodeller. Man skal være kritisk over for virksomheder der "claimer" agile uden at praktisere det.

### DevOps — historisk og kulturelt

**Dev vs. Ops-problemet**: Dev vil release hurtigt, Ops vil have stabilitet — resulterer i siloer og konflikt.

**DevOps løsningen**: Bryd siloerne via kultur, automation og delt ansvar.

**Shooks model**: Ændr adfærd → kultur følger efter (ikke omvendt). Man implementerer DevOps-praksisser og kulturen ændrer sig gradvist.

**CALMS-framework:**
- **C**ulture: Delt ansvar, psykologisk tryghed
- **A**utomation: Automate everything — ugens princip
- **L**ean: Eliminer spild, optimer flow
- **M**easurement: Mål alt — SPACE, DORA metrics
- **S**haring: Del viden på tværs af teams

**Pair Programming** (Williams, 2001):
- 15% langsommere end to separate udviklere
- Fejlfri kode: 70% → 85%
- Simplere design, færre design-defekter — fordi to hoder tænker

---

## Forbindelser til WhoKnows-projektet

### Vores Docker Compose setup

Vi har adskilt dev og prod:

```
docker-compose.dev.yml   → lokalt med bind mounts
docker-compose.prod.yml  → produktion med image fra GHCR
```

**Hot reload i Go med `air`:**

```dockerfile
# Dockerfile.dev
FROM golang:1.21-alpine
RUN go install github.com/air-verse/air@latest
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
CMD ["air"]
```

```yaml
# docker-compose.dev.yml
services:
  backend:
    build:
      dockerfile: Dockerfile.dev
    volumes:
      - .:/app  # Bind mount for live reload
```

**Continuous Delivery i vores pipeline:**

```
Push → ci.yml (lint → test → build → push til GHCR) → cd.yml (pull image → deploy til Azure VM)
```

Vi er tæt på **Continuous Deployment** men mangler automatisk deploy af `docker-compose.prod.yml` (se uge 08 noter).

**Environment variables:**

```yaml
# docker-compose.prod.yml
services:
  backend:
    env_file:
      - .env  # Aldrig committede secrets — lastes fra server
```

Databasefilen (SQLite) er ikke i image (offentligt GHCR) — den monteres som volume på serveren eller håndteres via backup-scripts.

**Networking:**

Vi eksponerer Go-backend direkte på port 8080 — fremtidigt bør vi tilføje Nginx som reverse proxy foran (se uge 08 noter).

### DevOps-kultur i teamet

- **Automate everything**: CI/CD pipeline, Dependabot auto-merge
- **Shooks model i praksis**: Vi indførte conventional commits og branch protection → adfærdsændringen skabte en fælles kultur om kode-kvalitet
- **Pair programming-tanken**: PR reviews er vores version — ingen merger til main uden review

---

## Eksamen Talking Points

**"Hvad er Docker Compose og hvorfor er det bedre end rene Dockerfiles?"**
Compose giver ét interface til multi-container setups. Med én YAML-fil og ét kommando (`docker compose up`) starter vi backend, database og eventuelt Nginx koordineret — med automatisk netværk og delt konfiguration. Rene Dockerfiles kan kun beskrive én container ad gangen og kræver mange manuelle kommandoer.

**"Hvad er forskellen på Continuous Delivery og Continuous Deployment?"**
Continuous Delivery: automatisk hele vejen til staging, manuel godkendelse til produktion — koden er altid klar til release. Continuous Deployment: fuldt automatiseret hele vejen inklusive produktion. Vi er tæt på Continuous Deployment i WhoKnows, men har stadig manuel komponent i vores `docker-compose.prod.yml`-håndtering.

**"Hvorfor kræver live reload et separat dev-setup?"**
Hot reload-tools (`nodemon`, `air`) er ikke egnet til produktion — de overvåger filsystemet og genstarter processer, hvilket er overhead. Bind mounts eksponerer desuden host-filsystemet, hvilket er en sikkerhedsrisiko i produktion. Derfor separat `Dockerfile.dev` og `docker-compose.dev.yml`.

**"Hvad er Agile og hvad var det en reaktion på?"**
Agile (Manifesto 2001) var en reaktion på vandfaldsmodellens rigiditet — store planer der ikke kunne tilpasses undervejs. Agile prioriterer fungerende software, samarbejde og evnen til at reagere på ændringer. Man skal dog være kritisk: mange virksomheder "claimer" agile uden at praktisere det, og forskning viser at store organisationer typisk ender med hybridmodeller.

**"Hvad er CALMS og hvad er A'et?"**
CALMS er et framework for DevOps-modenhed: Culture, Automation, Lean, Measurement, Sharing. A'et — Automation — handler om at fjerne manuel friction. I WhoKnows: CI/CD pipeline, Dependabot auto-merge, automatiske tests. Automation er det der gør DevOps skalerbart.
