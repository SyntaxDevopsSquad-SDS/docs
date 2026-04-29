# Course Conclusion

## Hvad har vi lært?

DevOps-kurset 2026 har taget os fra et legacy Python Flask-projekt til en moderne Go-applikation med fuld CI/CD-pipeline, containerisering og cloud-deployment. Her er de store linjer.

## Rejsen gennem kurset

**Week 1-2: Foundation**
Vi startede med at analysere en eksisterende kodebase, lave dependency graphs og vælge Go som nyt framework. Grundlaget for god DevOps-praksis: forstå hvad du har, inden du ændrer det.

**Week 3: Deployment & Cloud**
Første gang i skyen. Azure VM, SSH, GitHub Actions CI/CD og et virkeligt domæne. Det var her DevOps gik fra teori til virkelighed.

**Week 4-5: Quality & Containerization**
Docker, Docker Compose, linting med golangci-lint, integration tests og Dependabot. Vi lærte at kvalitet ikke er noget du tilføjer til sidst — det bygges ind fra starten.

**Week 6-7: Continuous Delivery**
CD-pipeline, database migrations, sikkerhedshærdning med fail2ban og CSRF, og password reset flow. Continuous Delivery betyder at main altid er deployerbar.

**Week 8+: Advanced Topics**
Monitoring med Prometheus og Grafana, PostgreSQL-migration fra SQLite, deployment strategies, orchestration og resilience.

## De vigtigste læringer

### DevOps er en kultur, ikke et værktøj
CI/CD, Docker og Kubernetes er midler — ikke målet. Målet er hurtigere, mere pålidelig levering af software med høj kvalitet.

### Automation er investering
Hver gang vi automatiserede noget — CI-pipeline, deployment, dependency updates — brugte vi tid på det. Men den investering betalte sig tilbage mange gange i tid sparet og fejl undgået.

### Fejl er læringsmuligheder
Vores 502-fejl efter PostgreSQL-migrationen var frustrerende i øjeblikket, men vi lærte mere af den end af mange succesfulde deploys. Post-mortems og incident reports er ikke skyldsfordeling — de er læring.

### Observability er ikke luksus
Du kan ikke vedligeholde noget du ikke kan se. Prometheus, Grafana og gode logs er fundamentet for at forstå hvad der sker i dit system.

### Sikkerhed er en proces
fail2ban, CSRF, environment variables til secrets, branch protection — sikkerhed er ikke noget du tilføjer til sidst. Det er en løbende praksis.

## Hvad kommer efter kurset?

**Terraform** — infrastructure as code til at provisione hele vores Azure-setup automatisk.

**Kubernetes** — næste skridt efter Docker Compose når projektet vokser.

**Avanceret monitoring** — alerting, SLOs (Service Level Objectives), tracing.

**GitOps** — deployment styret udelukkende af Git-historik med værktøjer som ArgoCD eller Flux.

## Vores stack ved kursets afslutning

| Lag | Teknologi |
|-----|-----------|
| Sprog | Go 1.25 |
| Database | PostgreSQL 16 |
| Containerisering | Docker + Docker Compose |
| CI | GitHub Actions (go build, tests, lint, schema validation) |
| CD | GitHub Actions → GHCR → Azure VM |
| Reverse Proxy | nginx (Docker container med TLS) |
| Monitoring | Prometheus + Grafana |
| Sikkerhed | fail2ban, CSRF, bcrypt passwords |
| Cloud | Azure VM (Ubuntu) |
| DNS | syntax-reborndev.com |

## Tak

Tak til Anders Latif for et kursus der kombinerede teori med rigtige produktionsproblemer. Der er stor forskel på at lære om DevOps og faktisk at opleve et 502-nedbrud midt i et semester.
