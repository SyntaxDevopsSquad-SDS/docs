# Uge 06 – Docker Compose, Continuous Delivery & Agile
📅 Dato: 5. marts

---

## 🎯 Læringsmål

- [ ] Kan argumentere for fordelene ved Docker Compose frem for kun Dockerfiles
- [ ] Forstår forskellige grundlæggende `docker-compose.yml`-filer
- [ ] Forstår behovet for volumes til live reload i Docker og at det kræver et separat dev-setup
- [ ] Forstår Continuous Delivery som defineret i kurset og har en generel idé om hvordan det fungerer
- [ ] Kan forklare hvad agile er og hvorfor det opstod
- [ ] Forstår DevOps's historie og forskellige måder at forstå det på

---

## 📌 Kernebegreber

| Begreb | Kort forklaring |
|--------|-----------------|
| Docker Compose | Værktøj til at definere og køre multi-container applikationer via én YAML-fil — starter, stopper og styrer alle services med ét kommando |
| `docker-compose` vs `docker compose` | Gammel CLI-tool (Python, bindestreg) vs. ny Docker plugin (Go, mellemrum) — ikke interchangeable: forskellig image-navngivning (underscore vs. hyphen) |
| Services | Individuelle containers defineret i compose-filen — fx `app`, `db`, `nginx` |
| Networks i Compose | Compose opretter automatisk et default-netværk — services kan kommunikere via service-navn som DNS |
| Volumes vs. Bind Mounts | Volumes er styret af Docker og lever uafhængigt af containeren. Bind mounts peger direkte på host-filsystem — bruges til dev/live reload |
| Hot Reload / Live Reload | Automatisk genstart af applikationen ved kodeændringer i development — kræver bind mount + tool som `nodemon` (Node) eller `air` (Go) |
| `Dockerfile.dev` | Separat Dockerfile til development med hot reload-tool installeret — adskilt fra produktions-Dockerfilen |
| `docker-compose.dev.yml` | Separat compose-fil til development med bind mounts og dev-Dockerfile |
| `depends_on` | Definerer rækkefølge for opstart af services — `condition: service_healthy` venter på at db er klar |
| Environment Variables | Sættes i compose-filen via `environment:` eller via `.env`-fil med `env_file:` — aldrig hardcodet eller i image |
| Continuous Integration (CI) | Automatisk build og test ved hvert push — sikrer at koden altid er i deployerbar stand |
| Continuous Delivery (CD) | Automatisk deployment til non-produktion + manuel godkendelse til produktion — koden er altid klar til release |
| Continuous Deployment | Fuldt automatisk deployment til produktion uden manuel godkendelse — kræver høj test-coverage og tillid |
| GitHub Packages / GHCR | GitHub Container Registry — artifact repository til Docker images, integrerer direkte med GitHub Actions |
| CR PAT | Container Registry Personal Access Token — bruges til at autentificere mod GHCR fra CI/CD pipeline |
| Agile | Iterativ softwareudviklingsmetode — reagerer på ændringer frem for at følge en fast plan |
| Vandfaldsmodellen | Lineær, sekventiel udviklingsproces (krav → design → impl → test → deploy) — svær at ændre undervejs |
| Agile Manifesto (2001) | Fire værdier: Individer over processer, Software over dokumentation, Samarbejde over kontrakt, Reagere på ændringer over plan |
| DevOps Möbius-strip | Visuelt symbol på det kontinuerlige flow mellem Dev og Ops — ingen start eller slut, konstant feedback |
| CALMS | Framework for DevOps: **C**ulture, **A**utomation, **L**ean, **M**easurement, **S**haring — ugens princip: **Automate everything** |
| Shooks model | "Change behavior to change culture" (John Shook, Toyota) — adfærd ændres først, kultur følger efter |
| Pair Programming | To udviklere arbejder sammen på én computer — 15% langsommere men 70→85% fejlfri kode (Williams, 2001) |
| Dev vs. Ops | Traditionel siloer: Dev vil release hurtigt, Ops vil have stabilitet — DevOps bryder denne mur |
| Makefile / task runners | Automatiserer gentagne kommandoer (fx `make up`, `make down`) — alternativer: `just`, `taskfile` |
| Fail fast, recover fast | Ugens DevOps-princip (uge 5): Opdage fejl tidligt og komme sig hurtigt — frem for at undgå fejl |

---

## 📝 Egne noter

Se [noter.md](./noter.md)

---

## 🔗 Ressourcer

- **Docker Compose slides + opgaver:** https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/06._Docker_Compose_Continuous_Delivery/
- **WhoKnows Variations – Continuous Delivery branch:** https://github.com/who-knows-inc/whoknows_variations/tree/continuous_delivery
- **Agile Manifesto:** https://agilemanifesto.org/

---

## 🧩 Se også i emner/

- [Docker & Containerization](../../emner/docker.md)
- [CI/CD](../../emner/ci-cd.md)
- [Agile & Flow](../../emner/agile-flow.md)
