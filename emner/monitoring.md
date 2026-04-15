# 🧩 Emne: Monitoring

## Hvad er det?
Monitoring er processen med at indsamle, analysere og visualisere telemetri fra et system i realtid. Det giver indblik i hvordan systemet performer og hvordan brugere interagerer med det. Målet er at opdage problemer før brugerne gør det og forstå systemets adfærd over tid.

## Hvorfor er det vigtigt i DevOps?
Monitoring er en central del af Feedback-loopet i DevOps (The Three Ways). Uden monitoring er man blind — man ved ikke om en deployment har gjort tingene bedre eller værre. Det er fundamentet for kontinuerlig forbedring og hurtig incident response.

## Centrale begreber

| Begreb | Forklaring |
|--------|-----------|
| Prometheus | Open-source monitoring tool der scraper metrics fra applikationer via HTTP endpoints |
| Grafana | Visualiseringsværktøj der bruger Prometheus som datakilde og viser dashboards |
| Metrics | Målbare værdier over tid — f.eks. CPU, memory, antal requests |
| KPI | Key Performance Indicator — forretningsmæssige målemetrikker som antal brugere, searches per dag |
| Telemetry | Data indsamlet automatisk fra et system om dets tilstand og brug |
| OOMKiller | Linux-mekanisme der dræber processer ved out-of-memory situationer |
| Scraping | Prometheus' metode til at hente metrics fra applikationer med faste intervaller |
| Dashboard | Visuel repræsentation af metrics i Grafana |
| Datasource | Grafanas forbindelse til en datakilde, f.eks. Prometheus |

## Forbindelser til andre emner
- **CI/CD** — Monitoring bekræfter at en deployment var succesfuld (smoke test + metrics)
- **DevOps kultur** — Feedback-princippet: "See Problems as They Occur"
- **Logging** — Monitoring og logging supplerer hinanden — metrics viser *hvad* der sker, logs viser *hvorfor*
- **Docker** — Prometheus og Grafana kører typisk som Docker containers

## Eksempel fra WhoKnows-projektet
Vi har sat Prometheus op til at indsamle metrics fra vores Go-applikation og Grafana til at visualisere dem. Vi monitorerer:
- CPU load på serveren (`top`, `uptime`)
- Memory forbrug (`free -m`)
- Disk forbrug (`df -h`)
- Antal brugere i databasen
- Infrastruktur omkostninger (månedlig Azure/cloud udgift)

KPI rapport til venture capital investorer indeholder:
- CPU load på serveren
- Total antal brugere
- Månedlige infrastrukturomkostninger

## Mulige eksamensspørgsmål
- [ ] Hvad er forskellen på monitoring og logging?
- [ ] Hvorfor valgte I at monitorere de metrics I gjorde?
- [ ] Hvad er Prometheus og hvordan fungerer scraping?
- [ ] Hvad er forskellen på et KPI og en metric?
- [ ] Har monitoring gjort jer opmærksomme på noget i jeres system I efterfølgende har forbedret?
- [ ] Hvad er OOMKiller og hvornår er det relevant?
- [ ] Hvordan hænger monitoring sammen med Feedback-princippet i DevOps?

## Relevante uger
- Uge 11 (16. april 2026) — Logging, Monitoring, KPIs, Prometheus + Grafana
