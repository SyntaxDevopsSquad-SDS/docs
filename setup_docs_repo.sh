#!/usr/bin/env bash
# =============================================================
#  SyntaxDevOpsSquad – DevOps Documentation Repo Setup
#  Kør fra roden af dit clonede documentation-repo:
#    chmod +x setup_docs_repo.sh && ./setup_docs_repo.sh
# =============================================================

set -e

echo "🚀 Opretter dokumentationsstruktur for DevOps-eksamen..."

# ─── Mapper ──────────────────────────────────────────────────
mkdir -p uger/uge-01-introduktion
mkdir -p uger/uge-02-conventions-openapi-dotenv
mkdir -p uger/uge-03-github-actions-azure-deploy
mkdir -p uger/uge-04-software-quality-linting-ci
mkdir -p uger/uge-05-docker-dockerfile
mkdir -p uger/uge-06-docker-compose-continuous-delivery
mkdir -p uger/uge-07-devops-history-agile
mkdir -p uger/uge-08-devops-people-incident-response
mkdir -p uger/uge-09-devsecops-security-testing
mkdir -p uger/uge-10-databaser-orm-webscraping
mkdir -p emner

# ═════════════════════════════════════════════════════════════
#  ROOT README.md  –  Hub-fil
# ═════════════════════════════════════════════════════════════
cat > README.md << 'EOF'
# 📚 SyntaxDevOpsSquad – DevOps Eksamensdokumentation

> **Formål:** Samle pensum, tracke læringsmål og øve os til mundtlig eksamen.
> Denne fil er jeres hub. Alt starter her.

---

## 🗺️ Navigation

| | |
|---|---|
| ✅ [Læringsmål Master-tjekliste](./læringsmål-master.md) | Se hvad der er styr på — og hvad der mangler |
| 🔗 [Ressourcer & Links](./ressourcer.md) | Artikler, docs, tools og litteratur |
| 📂 [Uger](#-uger) | Pensum og quiz per uge |
| 🧩 [Emner](#-tværgående-emner) | Eksamensrelevante emner på tværs af uger |

---

## 📅 Uger

| Uge | Dato | Emne | Status |
|-----|------|------|--------|
| [01](./uger/uge-01-introduktion/) | 29. jan | Introduktion, Git, Legacy Project | ✅ |
| [02](./uger/uge-02-conventions-openapi-dotenv/) | 5. feb | Conventions, OpenAPI, DotEnv, Monorepo | ✅ |
| [03](./uger/uge-03-github-actions-azure-deploy/) | 12. feb | GitHub Actions, Azure, Cloud, Deploy | ✅ |
| [04](./uger/uge-04-software-quality-linting-ci/) | 19. feb | Software Quality, Linting, CI/CD, Branching | ✅ |
| [05](./uger/uge-05-docker-dockerfile/) | 26. feb | Docker, Dockerfile, Build Tools, Virtualization | ✅ |
| [06](./uger/uge-06-docker-compose-continuous-delivery/) | 5. mar | Docker Compose, Continuous Delivery, Agile | ✅ |
| [07](./uger/uge-07-devops-history-agile/) | 12. mar | DevOps Historie, Psychological Safety | ✅ |
| [08](./uger/uge-08-devops-people-incident-response/) | 19. mar | DevOps is People, Postmortem, Continuous Deployment | ✅ |
| [09](./uger/uge-09-devsecops-security-testing/) | 26. mar | DevSecOps, SAST/DAST, fail2ban, Shift-Left | ✅ |
| [10](./uger/uge-10-databaser-orm-webscraping/) | 9. apr | Databaser, ORM, Migrations, Web Scraping | 🔄 |

> **Status-nøgle:** ✅ Gennemgået og noter klar · 🔄 I gang · ⬜ Ikke startet

---

## 🧩 Tværgående emner

Disse filer er jeres primære eksamenshjælp — censor spørger i *emner*, ikke uger.

| Emne | Fil |
|------|-----|
| CI/CD | [emner/ci-cd.md](./emner/ci-cd.md) |
| Docker & Containerization | [emner/docker.md](./emner/docker.md) |
| DevOps (definitioner & kultur) | [emner/devops-kultur.md](./emner/devops-kultur.md) |
| DevSecOps & Shift-Left | [emner/devsecops-shift-left.md](./emner/devsecops-shift-left.md) |
| Security Testing (SAST/DAST) | [emner/security-testing.md](./emner/security-testing.md) |
| GitHub Actions | [emner/github-actions.md](./emner/github-actions.md) |
| Branching Strategies | [emner/branching-strategies.md](./emner/branching-strategies.md) |
| Cloud & Azure | [emner/cloud-azure.md](./emner/cloud-azure.md) |
| Agile & Flow | [emner/agile-flow.md](./emner/agile-flow.md) |
| IPTables & Firewalls | [emner/iptables-firewalls.md](./emner/iptables-firewalls.md) |

---

## 💡 Workflow

1. **Åbn en uge-mappe** → læs noter og kryds læringsmål af
2. **Brug quiz.md** til at øve mundtlige svar (parvis eller alene)
3. **Opdater læringsmål-master.md** løbende
4. **Brug emner/-mappen** til dybere forståelse og eksamenstræning
EOF

# ═════════════════════════════════════════════════════════════
#  LÆRINGSMÅL-MASTER.md
# ═════════════════════════════════════════════════════════════
cat > læringsmål-master.md << 'EOF'
# ✅ Læringsmål – Master Tjekliste

> Sæt kryds efterhånden som du er tryg ved at forklare emnet mundtligt.
> Målet er ikke at læse — det er at **kunne forklare**.

---

## Uge 01 – Introduktion & Git
- [ ] Kan bruge `git clone`, `add`, `commit`, `push`, `pull`
- [ ] Kan SSH ind på en server og bruge basale Linux-kommandoer
- [ ] Kan fejlfinde netværk, processer og servere
- [ ] Kan identificere problemer i et arvet codebase

## Uge 02 – Conventions, OpenAPI, DotEnv
- [ ] Ved hvilke filtyper *ikke* må pushes og hvorfor (`.env`, secrets osv.)
- [ ] Kan lave korrekte commit messages (Conventional Commits)
- [ ] Forstår OpenAPI-specifikationen og kan forklare hvad den bruges til
- [ ] Kan oprette en `.env` fil og bruge environment variables
- [ ] Forstår forskellen på Monolith / Monorepo / Multirepo

## Uge 03 – GitHub Actions, Azure, Deploy
- [ ] Forstår terminologi: workflows, runners, jobs, steps, actions
- [ ] Kan oprette et GitHub Actions workflow (push + PR trigger)
- [ ] Forstår grundlæggende cloud-koncepter
- [ ] Kan oprette en VM i Azure og SSH ind på den
- [ ] Forstår forskellen på public/private SSH-nøgler
- [ ] Kan argumentere for/imod deployment-strategier
- [ ] Forstår pull-based vs. push-based deployment

## Uge 04 – Software Quality, Linting, CI/CD
- [ ] Forstår hvad software quality er og værktøjer til at måle det
- [ ] Forstår hvad teknisk gæld er og hvorfor det er vigtigt at undgå
- [ ] Kan argumentere for vigtigheden af linting
- [ ] Kender forskel på linting i Git Hook vs. CI/CD pipeline
- [ ] Kender til forskellige branching-strategier (GitHub Flow, Gitflow osv.)

## Uge 05 – Docker & Dockerfile
- [ ] Forstår forskellige niveauer af build tools
- [ ] Forstår forskellen på packaging og containerization
- [ ] Kan forklare hvad Docker er og hvad der gør det anderledes
- [ ] Kan læse og forstå simple Dockerfiles for forskellige sprog

## Uge 06 – Docker Compose, Continuous Delivery, Agile
- [ ] Kan argumentere for Docker Compose fremfor kun Dockerfiles
- [ ] Forstår grundlæggende `docker-compose.yml` filer
- [ ] Forstår Continuous Delivery som begreb i kurset
- [ ] Kan forklare hvad Agile er og hvorfor det opstod
- [ ] Forstår DevOps-historikken og forskellige måder at forstå det på

## Uge 07 – DevOps Historie & Psychological Safety
- [ ] Kender den historiske vinkel på DevOps og dets evolution
- [ ] Forstår de problemer DevOps søger at løse i moderne organisationer
- [ ] Forstår begrebet psychological safety og hvorfor det er vigtigt
- [ ] Forstår vigtigheden af at reducere pipeline-eksekveringstid
- [ ] Har læst kursets litteratur og kan tale om indholdet

## Uge 08 – DevOps is People, Postmortem, Continuous Deployment
- [ ] Har en klar forståelse af forskellige DevOps-definitioner
- [ ] Forstår principperne Flow, Feedback og Continuous Learning
- [ ] Kan argumentere for vigtigheden af postmortem og kender processen
- [ ] Kan nævne forskellige måder at opnå Continuous Deployment på

## Uge 09 – DevSecOps, Security, SAST/DAST
- [ ] Kan forklare Shift-Left mentaliteten og sikkerhed i DevOps 8-infinity-loop
- [ ] Kan nævne forskellige typer sikkerhedstest — kan forklare SAST vs. DAST
- [ ] Ved hvordan man security-scanner et Docker-image
- [ ] Forstår IPTables-problemet med Docker og kan foreslå en løsning
- [ ] Forstår continuous testing-mentaliteten
- [ ] Kan forklare Shift-Left vs. Shift-Right testing med eksempler

## Uge 10 – Databaser, ORM, Web Scraping
- [ ] Forstår valg af databaseopsætning baseret på applikationens behov
- [ ] Kan argumentere for/imod ORM — ved hvornår man *ikke* bør bruge det
- [ ] Kan give eksempler på forskellen på migrations og seeding
- [ ] Kender forskellen på web scraping og web crawling

---

## 📊 Fremgang

**Tip:** Tæl dine flueben og sæt et mål for eksamensdag.
Total læringsmål: ~50 | Bestået når du kan forklare dem alle mundtligt 🎯
EOF

# ═════════════════════════════════════════════════════════════
#  RESSOURCER.md
# ═════════════════════════════════════════════════════════════
cat > ressourcer.md << 'EOF'
# 🔗 Ressourcer & Links

## 📖 Kursuslitteratur
- [ ] DevOps Literature I *(tilføj link)*
- [ ] DevOps Literature II *(tilføj link)*
- [ ] Detecting Agile BS *(tilføj link)*

## 🛠️ Tools vi bruger
| Tool | Formål | Link |
|------|--------|------|
| GitHub Actions | CI/CD pipelines | https://docs.github.com/en/actions |
| Docker | Containerization | https://docs.docker.com |
| fail2ban | Server hardening | https://github.com/fail2ban/fail2ban |
| Hadolint | Dockerfile linter | https://github.com/hadolint/hadolint |
| Postman | API testing & monitoring | https://www.postman.com |

## 🌐 Vores projekt-links
- WhoKnows repo: *(tilføj link)*
- Azure VM: *(tilføj IP/hostname)*
- syntaxgophers.dev: https://syntaxgophers.dev

## 📚 Nyttige artikler
*(Tilføj løbende)*
EOF

# ═════════════════════════════════════════════════════════════
#  HJÆLPEFUNKTION – uge README + quiz skabelon
# ═════════════════════════════════════════════════════════════
create_uge() {
  local DIR=$1
  local UGE=$2
  local DATO=$3
  local EMNE=$4

  cat > "$DIR/README.md" << UGEOF
# Uge $UGE – $EMNE

> 📅 Dato: $DATO

## 🎯 Læringsmål
*(Kopiér de relevante punkter fra [læringsmål-master.md](../../læringsmål-master.md))*

- [ ] ...
- [ ] ...

## 📌 Kernebegreber
| Begreb | Kort forklaring |
|--------|----------------|
| ...    | ...            |

## 📝 Egne noter
*Se [noter.md](./noter.md)*

## 🔗 Ressourcer
- Slides: *(tilføj link fra underviserens repo)*
- Opgaver: *(tilføj link)*

## 🧩 Se også i emner/
*(Hvilke tværgående emner dækker denne uge?)*
UGEOF

  cat > "$DIR/noter.md" << NOTEOF
# Noter – Uge $UGE: $EMNE

## Resumé
*(Skriv et kort resumé med egne ord — maks. 5 linjer)*

## Vigtige pointer
*(Hvad ville du fremhæve til eksamen?)*

## Forbindelser til WhoKnows-projektet
*(Hvordan relaterer dette sig til jeres eget projekt?)*
NOTEOF

  cat > "$DIR/quiz.md" << QUIZEOF
# 🧠 Quiz – Uge $UGE: $EMNE

> **Mundtlig øvelse:** Svar højt uden at kigge. Sæt kryds når du kan forklare det flydende.

- [ ] Hvad er det centrale begreb i denne uge og hvorfor er det vigtigt?
- [ ] Kan du give et konkret eksempel fra WhoKnows-projektet?
- [ ] Hvad er fordele og ulemper ved den tilgang I valgte?
- [ ] Hvad ville du gøre anderledes næste gang?

---
*(Tilføj uge-specifikke spørgsmål her)*
QUIZEOF
}

# ═════════════════════════════════════════════════════════════
#  OPRET ALLE UGE-MAPPER
# ═════════════════════════════════════════════════════════════
create_uge "uger/uge-01-introduktion" "01" "29. januar" "Introduktion, Git & Legacy Project"
create_uge "uger/uge-02-conventions-openapi-dotenv" "02" "5. februar" "Conventions, OpenAPI & DotEnv"
create_uge "uger/uge-03-github-actions-azure-deploy" "03" "12. februar" "GitHub Actions, Azure & Deploy"
create_uge "uger/uge-04-software-quality-linting-ci" "04" "19. februar" "Software Quality, Linting & CI/CD"
create_uge "uger/uge-05-docker-dockerfile" "05" "26. februar" "Docker & Dockerfile"
create_uge "uger/uge-06-docker-compose-continuous-delivery" "06" "5. marts" "Docker Compose & Continuous Delivery"
create_uge "uger/uge-07-devops-history-agile" "07" "12. marts" "DevOps Historie & Psychological Safety"
create_uge "uger/uge-08-devops-people-incident-response" "08" "19. marts" "DevOps is People & Incident Response"
create_uge "uger/uge-09-devsecops-security-testing" "09" "26. marts" "DevSecOps, SAST/DAST & fail2ban"
create_uge "uger/uge-10-databaser-orm-webscraping" "10" "9. april" "Databaser, ORM & Web Scraping"

# ═════════════════════════════════════════════════════════════
#  EMNER – tværgående eksamensemner
# ═════════════════════════════════════════════════════════════
for EMNE in \
  "ci-cd" \
  "docker" \
  "devops-kultur" \
  "devsecops-shift-left" \
  "security-testing" \
  "github-actions" \
  "branching-strategies" \
  "cloud-azure" \
  "agile-flow" \
  "iptables-firewalls"
do
  cat > "emner/$EMNE.md" << EMNEEOF
# 🧩 Emne: $EMNE

## Hvad er det?
*(Definer emnet med egne ord — 2-3 sætninger)*

## Hvorfor er det vigtigt i DevOps?
*(Kontekst og formål)*

## Centrale begreber
| Begreb | Forklaring |
|--------|-----------|
| ...    | ...       |

## Forbindelser til andre emner
*(Hvad hænger dette emne sammen med?)*

## Eksempel fra WhoKnows-projektet
*(Konkret eksempel I kan bruge til eksamen)*

## Mulige eksamensspørgsmål
- [ ] ...
- [ ] ...

## Relevante uger
*(Hvilke uger dækkede dette emne?)*
EMNEEOF
done

# ─── Udfyld uge-09 quiz med eksamen-relevante spørgsmål ──────
cat >> uger/uge-09-devsecops-security-testing/quiz.md << 'SECQUIZ'

---
## Uge 09-specifikke spørgsmål

- [ ] Forklar Shift-Left mentaliteten — hvad betyder det i praksis?
- [ ] Hvad er forskellen på SAST og DAST? Giv et eksempel på hvert.
- [ ] Hvad er DevOps 8 (infinity loop) og hvor i den passer sikkerhed ind?
- [ ] Hvad er IPTables-problemet med Docker, og hvad er løsningen?
- [ ] Hvad gør fail2ban, og hvorfor har I implementeret det på jeres server?
- [ ] Forklar Shift-Right testing — hvornår giver det mening?
- [ ] Hvilke typer tests findes der, og hvor i CI/CD pipelinen hører de hjemme?
SECQUIZ

echo ""
echo "✅ Struktur oprettet! Her er hvad der blev lavet:"
echo ""
echo "  📄 README.md                  ← Hub med overblik og navigation"
echo "  📄 læringsmål-master.md       ← ~50 læringsmål med checkboxes"
echo "  📄 ressourcer.md              ← Links og tools"
echo "  📂 uger/ (10 mapper)          ← README + noter + quiz per uge"
echo "  📂 emner/ (10 filer)          ← Tværgående eksamensemner"
echo ""
echo "  Næste skridt:"
echo "  git add . && git commit -m 'docs: initial exam prep structure'"
echo "  git push"
echo ""
