# DevOps Refleksion – WhoKnows (SyntaxDevopsSquad-SDS)

---

## Opgave 1 – Version Control & Branching Strategi

### Nuværende strategi
Vi har primært kørt **GitHub Flow** gennem hele projektet: feature branches oprettes fra `main`, arbejdet sker isoleret, og ændringer merges ind via pull requests. I en kort periode testede vi **Git Flow** med separate `develop`- og `release`-branches, men det blev hurtigt klart at den overhead ikke gav mening i et studieprojekt med et lille team og hurtige iterationer - vi droppede det igen efter få dage.

### Hvad har virket godt
Vi enforcer et **branch protection ruleset på `main`**, som kræver godkendt PR før merge. Det eliminerede i praksis merge-konflikter, fordi ingen arbejdede direkte på `main`. Vi aftalte derudover at følge **Conventional Commits**-standarden (dokumenteret i vores README) og en konsistent branch-navngivningskonvention - begge dele har holdt commit-historikken læsbar og CI-pipelines forudsigelige.

### Eksempler fra vores repo
- [PR #130](https://github.com/SyntaxDevopsSquad-SDS/devops-syntaxsquad/pull/130)
- [PR #132](https://github.com/SyntaxDevopsSquad-SDS/devops-syntaxsquad/pull/132)
- [PR #141](https://github.com/SyntaxDevopsSquad-SDS/devops-syntaxsquad/pull/141)

### Refleksion
GitHub Flow har passet godt til vores arbejdsrytme - vi deployede løbende og havde ikke behov for langtidslevende branches. I et større team eller med flere samtidige releases ville **Trunk Based Development** med feature flags have været interessant at undersøge nærmere, da det presser endnu mere på kontinuerlig integration. Git Flow-eksperimentet var alligevel ikke spildt: det gav os hands-on forståelse for, hvornår en strategi skalerer - og hvornår den bare skaber bureaukrati.

---

## Opgave 2 – How are you DevOps?

### Hvor er vi DevOps?
Vi er ikke 100 % DevOps - og det er heller ikke et mål i sig selv. DevOps er en kultur, ikke en tjekliste. Som Eficode-gæsteforelæserne understregede, handler det om mennesker først: ingen *people*, ingen *process* - og uden process intet fungerende produkt. Det afspejler sig direkte i de 4 P'er, og det er der vi startede.

I WhoKnows-projektet har vi konkret implementeret flere af faserne i DevOps-livscyklussen:

| Fase | Hvad vi har gjort |
|------|-------------------|
| **Plan → Code** | Feature branches, PR-reviews og Conventional Commits strukturerer vores udviklingsflow |
| **Build → Test** | GitHub Actions builder automatisk ved push; smoke tests rammer produktionsserveren efter deploy |
| **Release → Deploy** | Ingen manuel `ssh` og `git pull` - GitHub Actions håndterer hele deploy-processen |
| **Operate → Monitor** | Prometheus + Grafana dashboards på auth, requests og uptime |

### Hvad holder os fra at være fully DevOps?
Vores testdækning er begrænset - vi dækker ikke hele kodebasen, og vores observability er reaktiv snarere end proaktiv (ingen alerting, ingen on-call-setup). Derudover har vi arbejdet i et lille team, så risikoen for siloer har været lav - men vi har ikke formaliseret incident response, som hører til ops-siden af infinity-loopet.

### Refleksion
Vi er gået fra nul kendskab til at navigere DevOps-principperne i praksis - uge for uge, iteration for iteration. Eficode-forelæsningen satte det i perspektiv: DevOps i den virkelige verden er ikke et værktøj man installerer, men en måde et team modnes på over tid. WhoKnows har været vores læringsarena for præcis det.

---

## Opgave 3 – Software Quality

> 🔄 **Følges op** – Vi vender tilbage til denne opgave efter SonarCloud-analyse er gennemført og findings er diskuteret som gruppe.

**Opsætning (SonarCloud):**
1. Log ind på [sonarcloud.io](https://sonarcloud.io) via GitHub
2. Klik `+` → `Analyze new project` → vælg WhoKnows-repoet
3. Tilføj SonarCloud-step i GitHub Actions CI-pipeline så det kører ved fremtidige pushe

---

## Opgave 4 – Monitoring Realization

### Hvad vores Grafana dashboards viser

Vi har tre dashboards i Grafana (WhoKnows Auth, WhoKnows Overview, WhoKnows Requests) der tracker trafik, login-adfærd og uptime over de seneste 7 dage.

#### 🔴 Anomali: Massivt antal failed logins
Det mest markante signal i vores data er et **vedvarende og voksende antal fejlede login-forsøg** - over 7 dage akkumulerer vi fra ~1.000 til ~1.500 fejlede logins, mens succesfulde logins tæller på én hånd (maks. 3 i samme periode).

Det er ikke støj - det er et mønster. Det indikerer med høj sandsynlighed **automatiserede login-forsøg (credential stuffing eller brute force)** mod vores `/login`-endpoint.

På 24-timers-vinduet ser vi samme billede: 210–260 failed logins per rullende dag, med en opadgående trend mod slutningen.

#### 🟡 Registrations Failing/Validation
Registreringsfejl (validation-fejl) ligger stabilt på 700–800 over 7 dage, med et mindre fald og en ny stigning. Det tyder på automatiserede registreringsforsøg der rammer vores valideringslogik - enten bots der prøver at oprette konti, eller forkert formatterede requests fra simulerede brugere.

Succesfulde registreringer: tilnærmelsesvis nul i hele perioden.

#### 🟢 Uptime & Latency
Backend uptime holder **99.8–100 %** over hele perioden. Request latency p95 er under **0.1 sekunder** på stort set alle endpoints - med én enkelt spike der hurtigt normaliserede sig. Go-migrationen fra Python har tydeligt haft effekt her.

####  Top Search Terms
Dashboardet tracker reelle søgetermer: *"apple app store 12-month subscription"*, *"bernie sanders"*, *"is the weather app down"*, *"ja morant team"* - det bekræfter at vores FTS5-søgning bliver ramt af rigtige (eller simulerede) brugere.

### Hvad vi indså - og hvad der bør fixes

| Observation | Konklusion | Handling |
|-------------|------------|----------|
| ~1.500 failed logins over 7 dage | Sandsynlig brute force / credential stuffing | Rate limiting på `/login`, evt. CAPTCHA eller account lockout |
| 0 succesfulde registreringer | Enten broken flow eller ingen reelle brugere | Verificér registreringsflow end-to-end |
| 99.8% uptime | Go-migrationen virker stabilt i prod | Ingen akut handling nødvendig |
| p95 latency under 0.1s | FTS5 performer godt under load | Behold FTS5, overvåg ved højere traffic |

> *Screenshots fra Grafana (WhoKnows Auth, WhoKnows Overview, WhoKnows Requests) er vedlagt som dokumentation.*

---

## Opgave 5 – Postmortem (valgfrit)

### Titel: Datagendannelse efter SQLite → PostgreSQL migrering

---

### Hvad skete der?
Under overgangen fra SQLite til PostgreSQL i vores Go-backend forsvandt eksisterende brugerdata (25 brugere). Applikationen blev omkonfigureret til at pege på en ny, tom PostgreSQL-instans, uden at de eksisterende data fra den lokale `whoknows.db`-fil var blevet overført.

---

### Tidslinje

| Tidspunkt | Hændelse |
|-----------|----------|
| T+0 | PostgreSQL-container startes og backend omkonfigureres til ny DB |
| T+0 | Applikationen er oppe - men brugerbasen er tom |
| T+1 | Fejl opdages: 25 brugere mangler, ingen kan logge ind |
| T+2 | `whoknows.db` lokaliseres på VM under `/opt/whoknows/implementations/go/backend/` |
| T+3 | Manuelt migreringsscript påbegyndes |
| T+4 | Data transformeret og importeret til PostgreSQL-container |
| T+5 | Verificeret: brugere tilgængelige og login virker |

---

### Root Cause
Ingen datamigreringsplan var en del af deployment-processen. Skiftet fra SQLite til PostgreSQL blev behandlet som en ren konfigurationsændring - ikke som en datamigrering. Den eksisterende `whoknows.db`-fil blev efterladt på filsystemet uden at blive overført til den nye instans.

---

### Impact
- **25 brugere** mistede adgang
- Applikationen var funktionel men ubrugelig for eksisterende brugere i en periode
- Ingen tab af applikationsdata (sider/indhold) - kun brugerdata

---

### Teknisk løsning

**Trin 1 – Identificering af kildedata**

Den originale SQLite-fil blev lokaliseret på serveren:
```
/opt/whoknows/implementations/go/backend/whoknows.db
```

**Trin 2 – Data-transformation**

SQLite bruger heltal (`0`/`1`) for boolean-værdier; PostgreSQL kræver `false`/`true`. Data blev transformeret on-the-fly med `sed` inden import:

```bash
sqlite3 whoknows.db ".dump users" \
  | sed "s/\b0\b/false/g; s/\b1\b/true/g" \
  | docker exec -i <postgres-container> psql -U <user> -d <db>
```

**Trin 3 – Verificering**

Efter import blev det verificeret at alle 25 brugere var tilgængelige og at login-flowet fungerede korrekt.

---

### Hvad vi lærte
- En databasemigrering er ikke det samme som en konfigurationsændring - det kræver en **eksplicit dataplan**
- SQLite og PostgreSQL er ikke drop-in replacements: datatypeforskelle (boolean, timestamps) skal håndteres
- Docker-isolering gør det sværere at flytte data ad hoc - en **migration-container eller init-script** ville have løst dette automatisk

---

### Forebyggelse fremover
- Tilføj et **migreringsscript** som del af deployment-processen (fx via `docker-compose` init-container)
- Brug **Flyway** eller tilsvarende til at versionere og automatisere databasemigreringer
- Aldrig deploy en ny databaseinstans uden først at verificere at eksisterende data er overført og testet
- Tilføj et smoke test der checker at brugercount > 0 efter deploy

---

*Dokument udarbejdet af SyntaxDevopsSquad-SDS – WhoKnows projektet, 2026*
