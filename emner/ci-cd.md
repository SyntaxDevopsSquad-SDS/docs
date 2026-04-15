# 🧩 Emne: CI/CD

## Hvad er det?
CI/CD er en metode til automatiseret softwarelevering der opdeles i tre faser: Continuous Integration (CI) samler og tester kode automatisk ved hvert push, Continuous Delivery (CD) sikrer at koden altid er i en deploybar tilstand, og Continuous Deployment (CD) deployer automatisk til produktion uden manuel godkendelse. Målet er at reducere lead time og eliminere Big Bang Deployments.

## Hvorfor er det vigtigt i DevOps?
CI/CD er kernen i The First Way — Flow. Det gør arbejdet synligt, reducerer batch sizes og eliminerer manuelle handoffs. Det er det tekniske fundament der gør det muligt at deploye mange gange om dagen som Amazon og GitHub gør.

## Centrale begreber

| Begreb | Forklaring |
|--------|-----------|
| Continuous Integration | Automatisk build og test ved hvert push til version control |
| Continuous Delivery | Koden er altid i deploybar tilstand — kræver manuel godkendelse til prod |
| Continuous Deployment | Automatisk deploy til produktion uden manuel godkendelse |
| Full CD | Deploy virker på en frisk server uden manuelle trin — kursets mål |
| Pipeline | Sekvens af automatiserede trin fra kode til produktion |
| Quality Gate | Et trin der stopper pipelinen hvis det fejler |
| Artifact | Output fra CI — f.eks. Docker image, binary, tar-arkiv |
| GHCR | GitHub Container Registry — bruges til at opbevare Docker images |
| Semantic Versioning | MAJOR.MINOR.PATCH — standard for versionering |
| Git Tagging | Mærkning af specifikke commits som releases |
| Smoke Test | Hurtig sanity check efter deployment — tjekker at systemet virker |
| Rollback | Mulighed for at rulle tilbage til en tidligere version |
| Big Bang Deployment | Deploy alt på én gang — det CI/CD prøver at undgå |

## Typer af deployment

| Type | Beskrivelse |
|------|-------------|
| `git pull` + run | Koden er på serveren — simpelt men manuelt |
| `docker compose pull/up` | Ingen kode på serveren — puller image fra registry |
| `scp` + `docker compose` | Filer kopieres til server + compose kører — Full CD |
| Shadow Deployment | Requests dubleres til ny version for at teste den i prod |
| Feature Toggling | Features deployes usynligt og aktiveres gradvist (Facebook) |

## Forbindelser til andre emner
- **Docker** — Images bygges i CI og deployes i CD
- **GitHub Actions** — Vores CI/CD platform
- **DevOps kultur** — CI/CD er The First Way i praksis
- **Monitoring** — Smoke tests og metrics bekræfter succesfuld deployment
- **Branching Strategies** — Trunk-based development understøtter hyppige deploys

## Eksempel fra WhoKnows-projektet
Vores CD pipeline i `.github/workflows/cd.yml`:
1. Bygger Go Docker image og pusher til GHCR
2. Kopierer `docker-compose.prod.yml` og scripts til serveren via `scp`
3. SSH'er ind og kører `deploy_compose.sh`
4. Smoke test kører automatisk bagefter og verificerer HTTP 200

Dette er "Full CD" — virker på en frisk server uden manuelle trin.

## Læringsmål
- [ ] Kan bruge grundlæggende git-kommandoer: clone, add, commit, push og pull
- [ ] Kan SSH'e ind på en server og bruge grundlæggende Linux-kommandoer
- [ ] Kan fejlsøge netværk, processer og server (nmap, ps, lsof, netstat)
- [ ] Kan identificere problemer i en arvet codebase
- [ ] Forstår forskellen på Continuous Integration, Delivery og Deployment
- [ ] Kan forklare hvad "Full CD" betyder i kursets kontekst
- [ ] Kender forskellige typer af deployment og deres fordele/ulemper
- [ ] Kan forklare hvad quality gates er og hvordan de fungerer i GitHub Actions
- [ ] Forstår hvordan rollback kan opnås i hvert trin af pipelinen
- [ ] Kan forklare semantic versioning og git tagging

## Mulige eksamensspørgsmål
- [ ] Hvad er forskellen på Continuous Delivery og Continuous Deployment?
- [ ] Hvad er "Full CD" og hvordan har I implementeret det?
- [ ] Hvordan fungerer jeres deployment pipeline trin for trin?
- [ ] Hvad er en quality gate og hvordan bruger I det i GitHub Actions?
- [ ] Hvordan kan I rulle tilbage hvis en deployment fejler?
- [ ] Hvad er forskellen på `docker compose build` og `docker compose pull`?
- [ ] Hvad er semantic versioning og hvornår bruger man det?
- [ ] Hvordan deployer GitHub og Amazon — og hvad kan vi lære af det?

## Relevante uger
- Uge 2 (Legacy project, Source code archaeology, Git tagging)
- Uge 5 (Docker, Continuous Delivery, The Simulation)
- Uge 6 (Docker Compose, Continuous Delivery, GHCR)
- Uge 8 (Continuous Deployment, Full CD, Smoke Testing)
