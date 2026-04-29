# Maintenance

## Hvad er maintenance i DevOps-kontekst?

Maintenance handler om at holde et system kørende og sundt over tid — efter det er deployet til produktion. Det er ikke en engangsopgave men en løbende proces.

I DevOps er vedligeholdelse en integreret del af udviklingsprocessen, ikke noget der sker "bagefter".

## Dependency Management

Dependencies (afhængigheder) — de biblioteker og pakker din kode bruger — bliver løbende opdateret med sikkerhedsrettelser og nye features. Hvis du ikke holder dem opdaterede, opbygges teknisk gæld og sikkerhedsrisici.

**Dependabot** — det vi allerede bruger i WhoKnows. GitHub's automatiske dependency-opdateringsværktøj der opretter PRs når der er nye versioner.

```yaml
# .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: "gomod"
    directory: "/implementations/go"
    schedule:
      interval: "weekly"
```

**Principper:**
- Opdater regelmæssigt — ikke alt på én gang
- Test altid opdateringer i CI før merge
- Brug semantic versioning til at forstå omfanget af en ændring

## Logging og observability

For at vedligeholde et system skal du kunne se hvad der foregår. Vi har:
- **Prometheus** — indsamler metrics
- **Grafana** — visualiserer metrics
- **Docker logs** — container-output

Godt log-setup giver dig svar på: hvad skete der, hvornår skete det, og hvorfor?

## Database vedligeholdelse

**Backup** — regelmæssige backups af PostgreSQL-data. I vores setup gemmes data i `/opt/whoknows/postgres-data` via bind mount.

```bash
# Manuel backup
pg_dump -U whoknows whoknows > backup_$(date +%Y%m%d).sql

# Restore
psql -U whoknows whoknows < backup_20260427.sql
```

**Vacuum og indexes** — PostgreSQL har en autovacuum-proces der rydder op i tabeller. Indexes skal løbende evalueres.

## Sikkerhedsopdateringer

Sikkerhedsopdateringer skal prioriteres højt. Vores setup har:
- `fail2ban` — blokerer brute-force forsøg
- CSRF-beskyttelse
- Dependabot til dependency-opdateringer

**Docker image scanning** — tjek images for kendte sårbarheder med fx `docker scout` eller Trivy.

```bash
docker scout cves ghcr.io/syntaxdevopssquad-sds/whoknows-go:latest
```

## Incident Management

Når noget går galt (som vores 502-fejl) er det vigtigt at:

1. **Detektere** — opdage fejlen (monitoring, alerts)
2. **Respondere** — komme ind og vurdere
3. **Fikse** — løse problemet (eller rollback)
4. **Dokumentere** — skrive en post-mortem/incident report
5. **Lære** — implementere forbedringer så det ikke sker igen

Vi lavede en incident report for vores 502-fejl som er et godt eksempel på dette flow.

## Teknisk gæld

Teknisk gæld er den akkumulerede pris af hurtige løsninger og genveje taget tidligere. Jo mere gæld, jo sværere er det at tilføje nye features og jo mere tid bruges på vedligeholdelse.

God vedligeholdelse inkluderer løbende at:
- Refaktorere kode der er svær at forstå
- Fjerne kode der ikke bruges
- Opdatere dokumentation
- Forbedre test coverage
