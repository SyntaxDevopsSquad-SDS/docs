# Migration: SQLite → PostgreSQL

## Hvorfor migrerede vi?

SQLite er en filbaseret database, der fungerer fint til udvikling og prototyper, men den har kritiske begrænsninger i produktion:

- **Ingen reel concurrent access** — SQLite låser hele databasefilen ved skrivninger, hvilket giver fejl under belastning
- **Ikke egnet til multi-server setups** — flere servere kan ikke dele en SQLite-fil
- **Mangler avancerede features** — fx native full-text search med `tsvector`, som vi bruger til søgefunktionaliteten

PostgreSQL løser alle disse problemer og er industristandardløsningen til produktionsdatabaser.

---

## Hvad blev ændret?

### `database.go`
- Fjernede `getDBPath()` og `checkDBExists()` — disse var SQLite-specifikke
- Tilføjede `getDatabaseURL()` som læser `DATABASE_URL` environment variablen
- `connectDB()` bruger nu `github.com/lib/pq` driveren i stedet for `modernc.org/sqlite`

### `schema.sql`
- `INTEGER PRIMARY KEY AUTOINCREMENT` → `SERIAL PRIMARY KEY`
- `INSERT OR IGNORE` → `INSERT ... ON CONFLICT DO NOTHING`
- Fjernede FTS5 virtual table (`pages_fts`) — erstattet med PostgreSQL native `tsvector` og GIN-indeks
- Tilføjede `search_vector tsvector` kolonne på `pages` tabellen

### `routes.go`
- Alle SQL query placeholders ændret fra `?` → `$1, $2, $3...`
- Full-text search ændret fra `MATCH` (FTS5) → `search_vector @@ to_tsquery('english', $2)`
- `force_password_reset` kolonne typen ændret fra `INTEGER` til `BOOLEAN` — scanner nu korrekt ind i Go `bool`

### `Dockerfile`
- Fjernede SQLite-afhængigheder
- Tilføjede `postgresql-client` til apt-install (bruges af `entrypoint.sh`)
- Fjernede `ENV DB_PATH`

### `entrypoint.sh`
- Fjernede SQLite filcheck-logik
- Bruger nu `pg_isready` til at vente på PostgreSQL
- Kører `psql "$DATABASE_URL" -f /app/schema.sql` ved opstart

### `docker-compose.yml` og `docker-compose.prod.yml`
- Tilføjede `postgres:16-alpine` service med healthcheck
- Backend-servicen afhænger af PostgreSQL via `depends_on: condition: service_healthy`
- Prod-setup bruger bind mount til `/opt/whoknows/postgres-data` for datapersistens

### CI Pipeline (`.github/workflows/ci.yml`)
- Tilføjede PostgreSQL service til både `go-ci` og `database-validation` jobs
- `DATABASE_URL` sættes automatisk i CI-miljøet
- Schema-validering kører nu mod PostgreSQL i stedet for SQLite

---

## Konfiguration

### Environment variabler

| Variabel | Beskrivelse | Eksempel |
|---|---|---|
| `DATABASE_URL` | PostgreSQL connection string | `postgres://whoknows:password@postgres:5432/whoknows?sslmode=disable` |
| `POSTGRES_DB` | Databasenavn | `whoknows` |
| `POSTGRES_USER` | Brugernavn | `whoknows` |
| `POSTGRES_PASSWORD` | Adgangskode | *(sat i .env)* |

### Connection string format
```
postgres://<user>:<password>@<host>:<port>/<database>?sslmode=disable
```

---

## Full-text search

SQLite brugte FTS5 virtual tables. PostgreSQL bruger `tsvector` med et GIN-indeks, som er hurtigere og mere fleksibelt.

**Søgequery:**
```sql
SELECT title, content, language, url
FROM pages
WHERE language = $1
AND search_vector @@ to_tsquery('english', $2)
```

`search_vector` opdateres automatisk via en trigger der kører ved `INSERT` og `UPDATE` på `pages` tabellen.

---

## Produktion: VM-setup

PostgreSQL-data gemmes i `/opt/whoknows/postgres-data` på app-serveren via bind mount. Dette sikrer at data overlever container-genstarter.

Monitoring-serveren kører på en separat VM, så data ikke går tabt hvis app-serveren fejler.

---

## Tests

Alle tests er migreret fra SQLite in-memory til PostgreSQL:

| Fil | Ændring |
|---|---|
| `database_test.go` | `setupTestDB` bruger nu PostgreSQL, `TestGetDBPath` → `TestGetDatabaseURL`, `TestCheckDBExists` fjernet |
| `integration_test.go` | `DB_PATH` → `DATABASE_URL`, schema og queries opdateret |
| `metrics_test.go` | SQLite in-memory → PostgreSQL, FTS5 → `tsvector` |
| `routes_test.go` | `?` → `$1/$2/$3`, `ALTER TABLE` syntaks opdateret til PostgreSQL |

Tests kræver en kørende PostgreSQL-instans med databasen `whoknows_test`. I CI klares dette automatisk af GitHub Actions service-definitionen.
