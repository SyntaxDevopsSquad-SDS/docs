# Resilience

## Hvad er resilience?

Resilience (modstandsdygtighed) i softwaresystemer handler om et systems evne til at håndtere fejl og komme sig efter dem — uden at brugerne mærker det, eller i hvert fald med minimal påvirkning.

Et resilient system forudsætter at ting vil gå galt. Det er ikke et spørgsmål om *om* en server crasher, en database mister forbindelsen eller en ekstern API er nede — det er et spørgsmål om *hvornår*.

## Principper for resilience

### Fail fast
Opdage fejl hurtigst muligt og fejle eksplicit frem for at hænge stille. En fejl der fanges tidligt er billigere at håndtere end én der kaskaderer gennem systemet.

### Graceful degradation
Når en del af systemet fejler, fortsætter resten med at fungere — måske med reduceret funktionalitet. Fx: søgefunktionen er nede, men brugere kan stadig logge ind og browse.

### Circuit Breaker
Et mønster der stopper forsøg på at nå en service der konsekvent fejler, i stedet for at overbelaste den yderligere. Efter en timeout forsøges det igen.

### Retry med backoff
Ved midlertidige fejl — prøv igen, men vent lidt længere for hvert forsøg for ikke at overbelaste systemet.

### Health Checks
Løbende tjek af om services er raske. Det vi allerede gør med `pg_isready` i vores `docker-compose.yml`.

```yaml
healthcheck:
  test: ["CMD-SHELL", "pg_isready -U whoknows"]
  interval: 5s
  timeout: 5s
  retries: 5
```

### Redundancy
Kør flere instanser af kritiske services. Hvis én fejler, tager de andre over.

## Chaos Engineering

Chaos Engineering er praksis med at bevidst injicere fejl i et system for at teste dets resilience — og lære af det *inden* det sker i produktion.

Pioneret af Netflix med værktøjet **Chaos Monkey** der tilfældigt dræber produktionsservere — for at tvinge teamet til at bygge systemer der overlever det.

**Princip:** Opstil en hypotese om systemets opførsel under fejl, kør eksperimentet, observer hvad der faktisk sker.

**Eksempel på chaos-eksperimenter:**
- Dræb en container og se om den genstarter
- Bloker netværkstrafik mellem services
- Fyld disken op
- Inject latency på database-kald

**Værktøjer:**
- Netflix Chaos Monkey
- Chaos Toolkit
- Gremlin

## Sammenhæng til WhoKnows

Vi oplevede et reelt resilience-problem da vores nginx-container havde en forældet DNS-cache og ikke kunne nå app-containeren efter et deploy. Det er netop den slags fejl chaos engineering hjælper med at opdage og håndtere.

Forbedringer vi har implementeret:
- `depends_on: condition: service_healthy` — PostgreSQL skal være klar før appen starter
- `restart: unless-stopped` — containere genstarter automatisk ved crash
- nginx genstartes nu automatisk ved hvert deploy

## Monitorering som fundament for resilience

Du kan ikke have resilience uden observability. Hvis du ikke ved hvad der sker i dit system, kan du ikke reagere på fejl. Vores Prometheus + Grafana setup er fundamentet for at opdage problemer tidligt.
