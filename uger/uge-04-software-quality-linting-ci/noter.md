# Noter – Uge 04: Software Quality, Linting & CI/CD

---

## 📝 Resumé
Uge 04 markerede skiftet fra individuel udvikling til industriel softwareproduktion gennem automatisering. Vi har defineret softwarekvalitet ud fra internationale standarder (ISO 25010) og lært at kvantificere systemets sundhed. Ved at implementere automatiserede pipelines har vi skabt "Quality Gates", der adskiller Continuous Integration (CI), Continuous Delivery (artifacts til GHCR) og Continuous Deployment (udrulning til VM). Vi har gennem eksperimenter med branching-strategier lært vigtigheden af at vælge en proces, der fremmer Developer Experience (DX) frem for unødvendigt bureaukrati.

---

## 🚀 Vigtige pointer (Baseret på undervisningsmateriale)

### 1. Hvad er Software Quality? (ISO 25010)
Kvalitet er ikke en subjektiv vurdering, men en teknisk standard:
- **ISO 8402/SQuaRE**: "Totality of characteristics of an entity that bear on its ability to satisfy stated and implied needs."
- **Software vs. Code Quality**: Software omfatter hele pakken — koden, dokumentationen og de konfigurationsdata, der kræves for drift (Sommerville).
- **The "ilities" (Non-functional requirements)**: Vi har lært, at mindst 20% af ressourcerne skal gå til NFRs for at undgå systemisk forfald:
    - **Maintainability**: Hvor let er koden at vedligeholde?
    - **Reliability**: Kan vi stole på systemet under belastning?
    - **Scalability**: Kan systemet vokse med opgaven?
    - **Security**: Er applikationen beskyttet mod sårbarheder?
- **Developer Experience (DX)**: Kvalitet handler også om de interne processer. Hvis pipelinen er hurtig og giver klar feedback, højnes DX.

### 2. Technical Debt (Den finansielle metafor)
- **Definition**: Den fremtidige omkostning ved at vælge en hurtig eller nem løsning nu frem for en mere robust tilgang.
- **Cost of Change (CoC)**: Jo længere teknisk gæld får lov at eksistere, jo dyrere bliver den at rette. Gælden akkumulerer "renter", der gør det sværere at implementere nye features.
- **Typer af teknisk gæld**:
    - **Code debt**: Rodet kode og "Code Smells".
    - **Infrastructure debt**: Manuelle processer eller forældet CI/CD.
    - **Testing debt**: Manglende testdækning der fører til usikkerhed.
- **Code Smells**: Karakteristika i koden (fx duplikeret logik eller "God Objects"), der indikerer dybere arkitektoniske problemer (Martin Fowler).

### 3. CI/CD/CD: Kursets fortolkning
Vi bruger en specifik tre-deling af pipelinen:
1. **Continuous Integration (CI)**: Hyppig merge af kode til VCS (Git). Hvert push trigger automatiske builds og tests for at fange integrationsfejl lynhurtigt.
2. **Continuous Delivery (CD)**: Automatisering af artifacts. Her pakkes koden som Docker images og publiceres til et registry (fx GHCR).
3. **Continuous Deployment (CD)**: Den fulde automatisering, hvor koden deployes direkte til produktion (VM) uden manuel indgriben efter succesfulde tests.

### 4. Statisk vs. Dynamisk Analyse
- **Statisk Analyse (Linting)**: Værktøjer som `golangci-lint` og `hadolint` læser koden uden at køre den. Det finder syntax-fejl, sikkerhedshuller og stil-brud ekstremt billigt (Shift-Left).
- **Dynamisk Analyse**: Værktøjer som `go test -race` verificerer koden under eksekvering. Det finder logiske fejl og runtime-problemer, som statisk analyse ikke kan se.

### 5. Cron & Automatisering
- **Cron terminology**: Cron (scheduler), Cron job (kommandoen), Crontab (konfigurationsfilen).
- **Syntax**: `* * * * *` repræsenterer Minut, Time, Dag, Måned, Ugedag.
- **Optimeret CD via Cron**: I stedet for blot at trække kode (`git pull`) periodisk, lærte vi at bruge logik, der tjekker for faktiske ændringer via `git fetch`, før vi genstarter applikationen.

### 6. Branching Strategies & Proces-optimering
Samarbejdsmodellen er afgørende for teamets hastighed:
- **Eksperimentet**: Vi forsøgte os oprindeligt med en mere kompleks strategi (inspireret af Trunk-based/GitFlow), som indebar mange manuelle trin og komplekse merge-procedurer.
- **Læring**: Vi fandt ud af, at de mange trin var ubenyttede og skabte unødvendig kompleksitet (bureaukrati), som bremsede vores udvikling uden at give mærkbar værdi.
- **Valget (GitHub Flow)**: Vi skiftede tilbage til Feature Branching/GitHub Flow. Det er mere "straightforward", praktisk og reducerer de trin, vi fandt unødvendige. Det lader os fokusere på koden fremfor proces-styring.

### 7. The Three Ways (DevOps Fundament)
Vores procesvalg understøtter de tre grundprincipper:
1. **Flow**: Vi optimerer bevægelsen fra Dev til Ops (via `cd.yml`).
2. **Feedback**: Vi skaber hurtige feedback-loops (via linters og smoke tests).
3. **Continuous Learning**: Vores skift af branching-strategi er et direkte resultat af at eksperimentere med og forbedre vores egen proces.

---

## 🔗 Forbindelser til WhoKnows-projektet

### Kvalitetsstyring i CI (`ci.yml`)
Vores CI-workflow fungerer som en automatiseret "Quality Gate":
- **Go Linting**: Vi tvinger en fælles standard via `gofmt -s -l`. Hvis koden ikke er formateret, dør pipelinen med beskeden: *"Run gofmt -s -w backend"*.
- **Database Validering**: Vi har valideret vores `schema.sql` i pipelinen ved hjælp af `sqlite3`. Dette fanger SQL-fejl, før de når vores VM, hvilket minimerer "Infrastructure debt".
- **Race Detection**: Vi kører `go test -race` for at sikre, at vores Go-backend er stabil under multitasking.

### Vores praktiske Branching Workflow
Efter at have droppet den komplekse model, følger vi nu dette simple flow:
1. **Feature Branch**: `git checkout -b feature/ny-funktion`.
2. **Push & CI**: Koden pushes, og alle linters/tests i `ci.yml` skal være grønne.
3. **PR & Review**: Vi bruger Pull Request-vinduet til vidensdeling og review (Four-eyes principle).
4. **Merge & CD**: Ved merge til `main` kører `cd.yml`, som udruller til Azure VM.

### Deployment & Artifacts (`cd.yml`)
- **Continuous Delivery**: Vi bygger Docker images og pusher dem til GHCR tagget med commit-SHA for fuld sporbarhed.
- **Continuous Deployment**: Vi bruger `appleboy/ssh-action` til automatisk at køre vores `deploy_compose.sh` på VM'en.

### Feedback via Smoke Testing (`smoke-test.yml`)
- Efter udrulning verificerer vi systemets sundhed med en automatiseret smoke-test mod IP `51.103.136.200:8080`.
- **Visuel Feedback**: Vi har implementeret ASCII-art i pipelinen. Succes giver en bekræftelse, mens fejl giver en rød alarm. Det er vores "Andon Cord", der giver lynhurtig besked ved fejl.

---

## 🎓 Eksamen Talking Points

**"Hvorfor skiftede I branching-strategi undervejs?"**
Vi eksperimenterede med en mere kompleks Trunk-based/GitFlow-model, men fandt ud af, at de mange trin føltes som unødvendigt bureaukrati for vores team. Vi skiftede tilbage til Feature Branching (GitHub Flow), fordi det er mere praktisk, "straightforward" og fjerner friktion, hvilket forbedrer vores DX.

**"Hvordan definerer vi Software Quality i vores projekt?"**
Vi læner os op ad ISO 25010. Det handler om "The ilities". Vi har automatiseret tjek af *Maintainability* (via linting) og *Reliability* (via vores automatiserede smoke tests).

**"Hvad er jeres strategi for teknisk gæld?"**
Vi bruger vores CI pipeline som en Quality Gate. Ved at fange stil-fejl og SQL-fejl tidligt (Shift-Left), sikrer vi, at vi ikke oparbejder gæld, der senere vil øge vores Cost of Change.

**"Forklar forskellen på Static og Dynamic Analysis i jeres projekt."**
`golangci-lint` og `hadolint` er statisk analyse (finder fejl uden kørsel). Vores unit tests og `smoke-test.yml` er dynamisk analyse, da de tjekker systemet i bevægelse.

**"Hvad er værdien af jeres Smoke Test?"**
Den er vores sidste sikkerhedsnet. Selvom koden er bygget korrekt (Delivery), verificerer smoke-testen, at systemet rent faktisk svarer i produktion efter udrulning (Deployment).

**"Hvorfor køre linting i CI fremfor kun lokalt?"**
Lokale Git Hooks kan omgås (`--no-verify`). Ved at have det i vores `ci.yml` sikrer vi, at teamets fælles regler altid bliver overholdt, uanset hvem der pusher koden.