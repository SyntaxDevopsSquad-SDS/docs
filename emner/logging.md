# 🧩 Emne: Logging

## Hvad er det?
Logging er processen med at registrere hændelser i et system over tid. Logs er tekstbaserede records der beskriver hvad der er sket — hvornår, hvad og hvorfor. I modsætning til monitoring der viser *hvad* der sker nu, viser logs *hvad der skete* og *hvorfor*.

## Hvorfor er det vigtigt i DevOps?
Logging er fundamentet for debugging og incident response. Det er umuligt at finde årsagen til en fejl uden logs. Det understøtter The Second Way — Feedback: "See Problems as They Occur". God logging giver også indsigt i brugeradfærd og systemets sundhed over tid.

## Centrale begreber

| Begreb | Forklaring |
|--------|-----------|
| Log Level | Klassificering af logs: DEBUG, INFO, WARNING, ERROR, CRITICAL |
| ELK Stack | Elasticsearch + Logstash + Kibana — populær logging platform |
| Elasticsearch | Søgemaskine der indekserer og gemmer logs |
| Logstash | Indsamler og transformer logs fra forskellige kilder |
| Kibana | Visualiseringsværktøj til Elasticsearch data |
| Structured Logging | Logs i et struktureret format (f.eks. JSON) — nemmere at søge i |
| Log Aggregation | Samling af logs fra flere services ét sted |
| Retention Policy | Hvor længe logs gemmes før de slettes |

## Forskellen på Logging og Monitoring

| Logging | Monitoring |
|---------|-----------|
| Viser *hvad der skete* og *hvorfor* | Viser *hvad der sker nu* |
| Tekstbaserede records | Numeriske metrics over tid |
| Bruges til debugging | Bruges til alerting og dashboards |
| Elasticsearch, Kibana | Prometheus, Grafana |

## Forbindelser til andre emner
- **Monitoring** — Logging og monitoring supplerer hinanden
- **CI/CD** — Logs fra pipelines bruges til debugging af fejlede builds
- **DevSecOps** — Logs er vigtige for security auditing
- **Docker** — ELK stack kører typisk som Docker containers

## Eksempel fra WhoKnows-projektet
Vi bruger Go's indbyggede `log` pakke til server-side logging. Logs fra vores container kan tilgås med `docker compose logs whoknows`. Ved at kigge i logs kan vi se hvilke endpoints der kaldes og om der opstår fejl.

## Læringsmål
- [ ] Forstår forskellen på logging og monitoring
- [ ] Kender til ELK stacken og dens komponenter
- [ ] Forstår hvad log levels er og hvornår man bruger dem
- [ ] Forstår hvad structured logging er og hvorfor det er bedre end plain text logs
- [ ] Kan forklare hvad log aggregation er og hvorfor det er nødvendigt i distribuerede systemer

## Mulige eksamensspørgsmål
- [ ] Hvad er forskellen på logging og monitoring?
- [ ] Hvad er ELK stacken og hvad gør hver komponent?
- [ ] Hvad er log levels og hvornår bruger man dem?
- [ ] Hvad er structured logging og hvad er fordelene?
- [ ] Hvordan bruger I logging i jeres projekt?
- [ ] Hvad kan logs fortælle jer som metrics ikke kan?

## Relevante uger
- Uge 11 (Logging, Monitoring, KPIs, Prometheus + Grafana)
