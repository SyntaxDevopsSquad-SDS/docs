# Noter – Uge 02: Conventions, OpenAPI & DotEnv

---

## Resumé


Ugen fokuserede på at etablere gode vaner og standarder for projektet. Vi lærte hvilke filer der aldrig må committes til Git (secrets, binaries, dependencies), hvordan man skriver ordentlige commit messages med Conventional Commits, og vigtigheden af naming conventions på tværs af Go, SQL og Git. OpenAPI blev introduceret som metode til API-dokumentation med både Design-First og Code-First approaches. Environment variables blev implementeret via `.env` filer og `godotenv` i Go for at holde secrets ude af kodebasen. Endelig valgte vi en monorepo-struktur for at holde alt samlet og muliggøre atomic commits på tværs af kode, docs og CI.

---

## Vigtige pointer


### Files NEVER to Push to Git

**De kritiske kategorier:**

**1. Secrets & Credentials**
```gitignore
.env
*.env
secrets.json
credentials.yaml
```

**Hvorfor det er kritisk:**

Når en `.env` fil med passwords committes, er den permanent i Git history — selv efter sletning. Git gemmer alt. GitHub-bots scanner aktivt for leaked API keys og finder dem på sekunder.

**Vores løsning i WhoKnows:**

`.env` er i `.gitignore` fra dag 1. Vi bruger `.env.example` til at vise struktur uden rigtige værdier:

```env
# .env.example - SAFE to commit
SECRET_KEY=replace-with-a-long-random-secret
DB_PATH=dbpath/path
CSRF_RELAXED=false
```

Alle teammedlemmer kopierer til `.env` og indsætter deres egne værdier.

**2. Database Files**
```gitignore
*.db
*.sqlite
*.sqlite3
whoknows.db
```

**Problemer ved commit af database-filer:**
- Binary format — Git håndterer ikke binære diff'er effektivt
- Størrelse — kan blive gigantiske og sinke clone/pull
- Dynamisk data — produktionsdata hører ikke i version control
- Isolering — hver udvikler skal have sin egen testdatabase

**I stedet:** Vi bruger `schema.sql` til at genskabe strukturen:
```bash
sqlite3 whoknows.db < schema.sql
```

**3. Dependencies & Build Artifacts**
```gitignore
# Go
vendor/
*.exe
*.test

# Python (legacy)
__pycache__/
venv/
```

Dependencies installeres via `go mod download`. Vi committer kun `go.mod` og `go.sum` — det sikrer version-locking uden at bloate repository.

**4. IDE/OS Files**
```gitignore
.idea/       # IntelliJ
.vscode/     # VS Code
.DS_Store    # macOS
Thumbs.db    # Windows
```

Teamet bruger forskellige editors (VS Code, GoLand). Vi skal ikke tvinge konfiguration på hinanden.

---

### Conventional Commits

**Før denne uge:**
```bash
git commit -m "fixed stuff"
git commit -m "updates"
```

**Nu:**
```bash
git commit -m "feat: add integration tests for API endpoints"
```


**Types vi bruger:**

| Type | Anvendelse | Eksempel |
|------|------------|----------|
| `feat` | Ny feature | `feat: add user authentication` |
| `fix` | Bug fix | `fix: resolve CSRF token validation` |
| `refactor` | Code cleanup uden funktionel ændring | `refactor: simplify error handling` |
| `docs` | Dokumentation | `docs: update README with setup instructions` |
| `ci` | CI/CD changes | `ci: add golangci-lint to pipeline` |
| `test` | Tests | `test: add login integration tests` |
| `style` | Formattering (ingen logic change) | `style: run gofmt on all files` |
| `chore` | Maintenance | `chore: update dependencies` |

**Eksempel fra vores projekt:**
```bash
feat: add integration tests for API endpoints

- Created integration_test.go with 6 test scenarios
- Updated database.go to support :memory: database for tests
- Code coverage increased from 7.8% to 43.3%

Test results:
- 6 tests passing
- 3 tests skipped with FIXME comments

Closes #104
```

**Hvorfor denne standard:**
1. **Changelog generation** — Automatisk generering af release notes
2. **Debugging** — Søg efter `fix:` commits når bugs opstår
3. **CI/CD triggers** — Workflows kan trigges baseret på type
4. **Professionalisme** — Klar struktur til eksamensdemonstration

**Regler:**
- Imperative mood: "add" ikke "added"
- Lowercase type: `feat:` ikke `Feat:`
- Ingen punktum til sidst
- Body forklarer *hvorfor*, ikke *hvad* (koden viser hvad)
- Reference issues: `Closes #104`

---

### Naming Conventions

**Go Functions & Variables:**

```go
// ✅ Exported (public) - Uppercase første bogstav
func ConnectDB() { }
func GetSessionUser() { }
type BaseData struct { }

// ✅ Unexported (private) - Lowercase første bogstav
func hashPassword() { }
func validateCSRFToken() { }
var db *sql.DB
```

**Visibility-regel:** Første bogstav afgør om identifier er synlig uden for package.
- **Uppercase** = Exported (kan importeres fra andre packages)
- **Lowercase** = Unexported (kun synlig internt i samme package)

**Vigtigt: Ingen snake_case i Go**
```go
// ❌ FORKERT - Python-stil
func connect_db() { }
var user_name string

// ✅ KORREKT - Go camelCase
func connectDB() { }
var userName string
```

**Go Filnavne:**
```
database.go              # lowercase
routes.go                # lowercase
integration_test.go      # underscore kun for _test suffix
```

**Database (SQL):**
```sql
-- ✅ Tables: lowercase, plural, snake_case
CREATE TABLE users (...);
CREATE TABLE password_reset_tokens (...);

-- ✅ Columns: snake_case
username TEXT
force_password_reset BOOLEAN
created_at TIMESTAMP
```

SQL bruger `snake_case` som standard. Go bruger `camelCase`. Konvertering håndteres i struct tags.

**Environment Variables:**
```bash
# ✅ ALL_CAPS_SNAKE_CASE
SECRET_KEY=abc123
DB_PATH=/data/whoknows.db
CSRF_RELAXED=false
```

Universal standard på tværs af alle programmeringssprog.

**Branch Names:**
```bash
# ✅ KORREKT - kebab-case
feature/database-indexing
fix/csrf-token-validation
ci/add-smoke-tests

# ❌ FORKERT
Feature/DatabaseIndexing     # PascalCase
fix_csrf_token              # snake_case
AddSmokeTests               # Mangler prefix
```

Vi bruger `<type>/<kebab-case-description>` — samme types som Conventional Commits.

---

### OpenAPI Specification

**Definition:**

En YAML/JSON-fil der beskriver REST API endpoints maskinlæsbart. Tidligere kendt som Swagger.

**Eksempel-struktur:**
```yaml
openapi: 3.0.0
info:
  title: WhoKnows API
  version: 1.0.0

paths:
  /api/login:
    post:
      summary: User login
      requestBody:
        required: true
        content:
          application/x-www-form-urlencoded:
            schema:
              type: object
              properties:
                username:
                  type: string
                password:
                  type: string
                  format: password
      responses:
        '302':
          description: Redirect to homepage on success
        '200':
          description: Re-render login form with error
```

**Fordele ved OpenAPI:**

**1. Interaktiv dokumentation**

Swagger UI genererer browsable API docs. Brugere kan teste endpoints direkte med live requests/responses.

**2. Type-safe client generation**

Frontend kan auto-generere TypeScript types fra spec — eliminerer mismatch mellem backend og frontend datamodeller.

**3. Contract testing i CI/CD**

CI kan validere at faktiske API responses matcher spec'en. Breaking changes opdages automatisk.

**4. Team alignment**

Dokumentationen fungerer som kontrakt mellem frontend og backend. Reducerer kommunikationsoverhead.

**To tilgange:**

**Design-First (Top-Down):**

Skriv OpenAPI spec først
Review med team (frontend + backend)
Generate server stubs fra spec
Implementer business logic


**Fordel:** API design diskuteret før implementation. Fejl opdages tidligt.

**Code-First (Bottom-Up):**

Skriv kode først
Tilføj annotations til funktioner
Generate spec automatisk fra kode


**Fordel:** Hurtigere at komme igang. God til prototyper.

**Vores approach:** Hybrid — vi skrev kode først for momentum, men dokumenterer manuelt efterhånden som API stabiliseres.

---

### Environment Variables (.env)

**Problemet med hardcoded værdier:**

```go
// ❌ DÅRLIG PRAKSIS
secretKey := "my-super-secret-key-123"
dbPath := "/opt/whoknows/whoknows.db"
```

**Problemer:**
1. Secrets i kodebase → committes til Git → synlige på GitHub
2. Miljø-afhængig kode — skal ændres manuelt for dev vs prod
3. Manglende fleksibilitet — alle deler samme værdier

**Løsning med .env:**

**Development (lokal .env fil):**
```bash
# .env (IKKE i Git!)
SECRET_KEY=dev-secret-marcus-local
DB_PATH=./whoknows.db
CSRF_RELAXED=true
```

**Go implementation med godotenv:**
```go
// main.go
import "github.com/joho/godotenv"

func main() {
    // Load .env fil
    godotenv.Load()
    
    // Brug environment variables
    secretKey := os.Getenv("SECRET_KEY")
    if secretKey == "" {
        log.Fatal("SECRET_KEY environment variable required!")
    }
}
```

**Production (Azure VM via systemd):**
```ini
# /etc/systemd/system/whoknows.service
[Service]
Environment="SECRET_KEY=prod-generated-strong-key"
Environment="DB_PATH=/opt/whoknows/whoknows.db"
Environment="CSRF_RELAXED=false"
```

**Fordel:** Samme Go-kode virker i både dev og prod. `os.Getenv()` læser fra miljøet uanset kilde.

**Vores workflow:**
1. `.env.example` committes (viser struktur uden secrets)
2. Hver udvikler laver sin egen `.env` (ignoreret af Git)
3. Production sætter variables via systemd (ingen .env-fil på server)

**Twelve-Factor App Principle #3:**

*"Store config in the environment"*

Alt der varierer mellem deployments (dev/staging/prod) er "config":
- Database URLs
- API keys
- Hostnames
- Feature flags

**Test:** "Kan kodebasen open-sources lige nu uden at kompromittere credentials?"

I vores projekt: **JA** — vi er public på GitHub uden leaked secrets.

---

### Monorepo vs Polyrepo

**Vores valg: Monorepo**

Alt i ét Git repository:
```
devops-syntaxsquad/
├── implementations/
│   ├── go/          # Aktuel backend
│   └── python/      # Legacy reference
├── docs/            # Fælles dokumentation
├── .github/         # Fælles CI/CD workflows
└── server-config/   # Server setup scripts
```

**Fordele:**

✅ **Atomic commits**

Én commit kan ændre backend + docs + CI samtidig. Alt hænger sammen.

```bash
feat: add password reset endpoint

- Backend: Added /api/reset-password route (Go)
- Docs: Updated OpenAPI spec
- Database: Added password_reset_tokens table (SQL migration)
```

I polyrepo ville dette kræve 3 separate PRs i 3 repositories.

✅ **Shared tooling**

Én `.github/workflows/ci.yml` for hele projektet. Én `.gitignore`. Én Dependabot-config.

✅ **Refactoring**

Find alle steder koden bruges på tværs af services. Opdater alt atomisk.

**Ulemper:**

❌ Clone size — lidt større (ikke problem for os, ~50MB total)  
❌ Build time — skal bygge alt (mitigeres med caching)

**Polyrepo alternative:**
whoknows-backend/     # Separat repo
whoknows-frontend/    # Separat repo
whoknows-docs/        # Separat repo

**Hvornår ville polyrepo være bedre:**
- Separate teams per service (vi er kun 4 personer)
- Forskellige deployment cycles (vores er identiske)
- Granular permissions (vi har alle fuld adgang)

**Konklusion:** For vores lille team med tæt kobling er monorepo det rigtige valg.

---

## Forbindelser til WhoKnows-projektet

*(Hvordan relaterer dette til jeres eget projekt?)*

### Conventions Implementation

**.gitignore i praksis:**
```bash
# Vores .gitignore
.env
*.env
*.db
*.sqlite
__pycache__/
.vscode/
.DS_Store
```

Sikrer at secrets, database-filer og IDE-config aldrig committes.

**Conventional Commits:**

Alle commits følger standarden. Eksempler fra vores Git history:
```bash
feat: add integration tests for API endpoints
fix: resolve database connection pool exhaustion
docs: update README with installation steps
ci: add Docker image build to workflow
refactor: extract CSRF validation to middleware
```

**Naming conventions anvendt:**

Go kode:
- `ConnectDB()` — exported function (bruges i main.go)
- `getSessionUser()` — unexported (kun i routes.go)
- `database.go` — lowercase filnavn

Database:
- `users` table — lowercase plural
- `force_password_reset` column — snake_case

Git branches:
- `feature/integration-tests`
- `fix/csrf-validation`
- `ci/docker-build`

### Environment Variables Implementation

**.env.example (committed til Git):**
```bash
SECRET_KEY=anything
DB_PATH=dbpath/path
CSRF_RELAXED=false
```

**Lokal .env (ignored):**

Hver udvikler har sin egen med personlige værdier.

**Production (systemd service):**
```ini
[Service]
Environment="SECRET_KEY=prod-generated-key"
Environment="DB_PATH=/opt/whoknows/whoknows.db"
Environment="CSRF_RELAXED=false"
```

**Go implementation:**
```go
// routes.go
func getSecretKey() []byte {
    key := os.Getenv("SECRET_KEY")
    if key == "" {
        log.Fatal("SECRET_KEY environment variable required!")
    }
    return []byte(key)
}
```

Virker identisk i development og production.

### OpenAPI (planlagt)

Vi har strukturen klar i `docs/openapi.yaml`, men spec'en er ikke komplet endnu.

**Potentiel CI integration:**
```yaml
# .github/workflows/ci.yml (fremtidig forbedring)
- name: Validate OpenAPI spec
  run: |
    npm install -g @apidevtools/swagger-cli
    swagger-cli validate docs/openapi.yaml
```

Ville fange spec-fejl automatisk i CI før merge.

---

## Eksamen Talking Points

**"Hvorfor bruger I Conventional Commits?"**

Det giver en struktureret Git history der kan maskinprocesseres. Vi kan auto-generere changelogs, filtrere efter commit-type i debugging, og CI kan trigge forskellige flows baseret på type. Plus det ser professionelt ud og gør historikken læsbar for nye teammedlemmer.

**"Hvilke filer skal ALDRIG committes til Git?"**

Secrets (.env), database-filer (*.db), dependencies (vendor/, node_modules), og IDE-config (.vscode/). Secrets fordi de bliver permanente i Git history. Database-filer fordi Git er ineffektiv til binære filer og hver udvikler skal have isoleret testdata. Dependencies fordi de kan installeres via package managers.

**"Forklar jeres .env workflow"**

Vi har `.env.example` i Git der viser strukturen. Hver udvikler kopierer til `.env` og tilføjer sine egne værdier. `.env` er i `.gitignore`. Production bruger systemd environment variables. Samme Go-kode (`os.Getenv()`) virker begge steder. Det følger Twelve-Factor App princippet om strict separation mellem code og config.

**"Design-First vs Code-First for OpenAPI?"**

Design-First: Skriv spec først, så implementer. God til store teams og public APIs — alle er aligned før coding. Code-First: Skriv kode først, generer spec. Hurtigere til prototyper. Vi brugte hybrid — kode først for momentum, dokumenterer efterfølgende.

**"Hvorfor valgte I monorepo?"**

Vi er 4 personer med tæt kobling. Monorepo giver atomic commits på tværs af backend, docs og CI. Shared tooling reducerer overhead. Én `.github/workflows/ci.yml` for alt. Refactoring er nemmere når alt er samlet. For større teams med separate services kunne polyrepo give mere autonomi.
