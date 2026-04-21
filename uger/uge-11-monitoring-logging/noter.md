# Noter – Uge 11: Logging, Monitoring, KPIs & Prometheus + Grafana

## Resumé
Uge 11 handler om at forstå sit system bedre via telemetri. Monitoring (Prometheus + Grafana) viser hvad der sker nu via metrics og dashboards. Logging (ELK stack) viser hvad der skete og hvorfor via tekstbaserede records. KPIs er forretningsmæssige nøglemålinger som venture capital investorer efterspørger — f.eks. CPU load, antal brugere og månedlige infrastrukturomkostninger.

## Vigtige pointer
- Monitoring og logging supplerer hinanden — det ene erstatter ikke det andet
- Prometheus scraper metrics fra applikationer via HTTP endpoints med faste intervaller
- Grafana er agnostisk til programmeringssprog — det bruger bare Prometheus som datakilde
- KPIs skal man kunne argumentere for hvorfor man valgte dem til eksamen
- Tag screenshots af dashboards løbende — simulatoren kører igen før eksamen

## Forbindelser til WhoKnows-projektet
Vi har sat Prometheus op til at indsamle metrics fra vores Go-applikation og Grafana til at visualisere dem. Vores KPI rapport til venture capital investorer indeholder CPU load, total antal brugere og månedlige infrastrukturomkostninger på Azure.
