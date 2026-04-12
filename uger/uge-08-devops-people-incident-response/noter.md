# Noter – Uge 08: DevOps is People & Incident Response

## Resumé
Ugen fokuserede på DevOps som kultur snarere end værktøjer. Vi lærte om The Three Ways (Flow, Feedback, Continuous Learning), vigtigheden af blameless postmortems, og hvordan mennesker er kernen i DevOps. Continuous Deployment strategier blev gennemgået inkl. quality gates, rollback-mekanismer og deployment patterns som shadow deployment. Nginx som reverse proxy blev introduceret med hands-on konfiguration. Kernepunktet: DevOps handler om at bryde siloer, skabe psykologisk tryghed og bygge systemer der tillader hurtig feedback og kontinuerlig forbedring.

## Vigtige pointer
(Hvad ville du fremhæve til eksamen?)

### DevOps som kultur
- **DevOps er IKKE kun værktøjer** - det er fundamentalt en kulturændring der bryder muren mellem Dev og Ops
- **The Three Ways fra DevOps Handbook**:
  - **Flow**: Gør arbejde synligt, begræns WIP, reducer batch sizes, eliminer waste
  - **Feedback**: Se problemer når de opstår, swarm sammen om løsninger, push kvalitet mod kilden
  - **Continuous Learning**: Institutionaliser daglig forbedring, transformer lokale opdagelser til globale forbedringer
- **PPT Framework**: People, Process, Technology - balance mellem alle tre er kritisk
- **SPACE Framework**: Holistisk produktivitetsmåling (Satisfaction, Performance, Activity, Communication, Efficiency) - bedre end overfladiske metrics som commit count

### DevOps is People
- **Andon Cord princippet**: Stop arbejdet når problemer opdages, teamet "swarmer" for at løse det sammen
  - Excella case: Reducerede "almost dones" og cycle time ved at implementere Slack bot + fysisk signal
- **Psychological Safety**: Kritisk for at folk tør dele problemer, fejle og bede om hjælp
- **Knowledge Silos er enden på DevOps**: Den største reflektion fra eksamen er mangel på knowledge sharing
  - Information silos: Afdelinger deler ikke data
  - Knowledge silos: Ekspertise isoleres og deles ikke
- **Mennesker er ikke maskiner**: DevOps skal ikke udnytte folk, men fjerne friction og pain points

### Incident Response & Postmortem
- **Blameless Postmortem**: Fokuserer på systemfejl, ikke individer - essentielt for læringskulturen
- **Humans should be expected to fail**: Systemer skal designes til at håndtere menneskelige fejl
- **Eksempler fra virkeligheden**: AWS, GitHub, Cloudflare incidents viser vigtigheden af:
  - Transparent kommunikation
  - Hurtig response
  - System-level controls
  - Learning from failures

### Continuous Deployment
- **Big Bang Deployment**: Deploye alt på én gang - risikabelt og skal undgås
- **Full CD**: Både kode OG konfiguration (docker-compose) deployes automatisk
- **Deployment strategier**:
  1. Git pull → Docker Compose (kræver codebase på server)
  2. Docker pull image → Docker run (codebase aldrig på server)
  3. SCP docker-compose → docker compose pull/up (works on new server)
- **Quality Gates**: 
  - Inden for job: Steps er sekventielle, hver step er en gate
  - Mellem jobs: `needs: [job1, job2]` sikrer dependencies
  - Mellem workflows: `workflow_run` trigger
- **Rollback capability**: Kritisk for hurtig recovery - skal være mulig ved hvert trin

### Deployment Patterns fra store virksomheder
- **GitHub**: Deployments dozens of times per day, direkte fra master efter tests
- **Amazon (2011)**: Deployment hver 11.6 sekund i peak, 75% reduction i outages
- **Facebook**: 
  - Tiered deployment: A1 (internal) → A2 (small %) → A3 (all)
  - Facebook Gatekeeper for feature targeting
  - Shadow Deployment / Dark Launching for testing uden user impact
- **Feature Toggling**: Deploy features der eksisterer i DOM men er usynlige - test production load

### Reverse Proxies & Nginx
- **Reverse Proxy fordele**: Load balancing, HTTP caching, centraliseret sikkerhed (port protection, TLS)
- **Nginx konfiguration**:
  - Directives (key-value pairs med semicolon)
  - Contexts (blocks af directives)
  - `server` block: Define virtual hosts
  - `location` blocks: Path-based routing
  - `root` vs `alias`: root appender path, alias erstatter
  - MIME types: Kritisk for correct Content-Type headers
- **Nginx i Docker**: Volume mounts for config og static files
- **Proxy headers**: Host, X-Real-IP, X-Forwarded-For, X-Forwarded-Proto bevarer original request info

## Forbindelser til WhoKnows-projektet

### Flow Principles i praksis
- **Make Work Visible**: Vi bruger GitHub Projects Kanban board til at synliggøre alt arbejde
- **Limit WIP**: Branch protection rules og PR reviews sikrer fokus
- **Reduce Batch Sizes**: 
  - Conventional commits giver små, fokuserede changes
  - Feature branches (feat/*, fix/*) holder scope begrænset
- **Continuous Deployment**: 
  - CI/CD pipelines (ci.yml, cd.yml) automatiserer flow fra commit til deployment
  - Dependabot auto-merge holder dependencies opdateret automatisk

### Feedback Loops
- **See Problems as They Occur**: 
  - golangci-lint i CI giver øjeblikkelig feedback på code quality
  - Integration tests (integration_test.go) fanger problemer før merge
  - fail2ban på server giver security feedback
- **Swarm and Solve**: 
  - PR reviews er vores Andon Cord - når nogen blocker, hele teamet kan hjælpe
  - 4 developers samarbejder tæt = knowledge sharing by default
- **Quality Closer to Source**: 
  - Unit tests (database_test.go) i Go kode
  - Branch protection rules forhindrer broken code i main

### Continuous Learning
- **Institutionalize Improvement**: 
  - Migration system (migrations/) gør database changes reproducible og auditable
  - Technical audit (technical_audit.md) dokumenterer learnings
  - BRANCHING_STRATEGY.md formaliserer vores workflow
- **Transform Local to Global**: 
  - Documentation i docs/ deler knowledge om architecture (dependency_graph), API (openapi.yaml)
  - Breach response script (breach_response.sh) formaliserer incident procedures
- **Inject Resilience**: 
  - CSRF protection og middleware hardener systemet
  - Docker isolation giver failure containment
  - Migration rollback capability i database

### Deployment Strategy
Vores nuværende CD er **næsten** Full CD:
- ✅ Docker images bygges og pushes i CI
- ✅ CD pipeline deployer automatisk til Azure VM
- ✅ docker-compose.prod.yml deployed via scripts (deploy.sh, deploy_compose.sh)
- ⚠️ Men: Kræver docker-compose.prod.yml allerede er på server
- 🎯 **Forbedring til Full CD**: Implementer `scp docker-compose.prod.yml` i CD pipeline

**Quality Gates i vores pipeline**:
```yaml
ci.yml:
  - Lint → Test → Build → Push
  (hver step er gate)
  
cd.yml:
  needs: ci success
  - Deploy only if CI passes
```

### Rollback Capability
- **Git level**: Kan revert commits, rollback til tidligere tag
- **Docker level**: Kan deploye tidligere image tag fra ghcr.io
- **Database level**: Migration system understøtter down migrations
- **Missing**: Mangler formaliseret rollback procedure i scripts - kunne forbedres

### People & Culture
- **Breaking Knowledge Silos**: 
  - GitHub Flow (ikke GitFlow) holder det simpelt - alle kan bidrage til alle dele
  - Go migration var team effort - alle lærte Go sammen
  - Conventional commits gør det nemt at forstå hinandens work
- **Psychological Safety**: 
  - Dependabot auto-merge fjerner "blame" for dependency issues
  - Blameless approach: Når noget fejler, fix systemet (add test, improve CI), ikke bebrejd person
- **Sustainability**: 
  - Docker Compose gør local dev nem = mindre frustration
  - Automated pipelines = mindre manual toil = mere tid til features
  - WSL/Linux standardisering = færre "works on my machine" issues

### Nginx som Reverse Proxy (fremtidig forbedring)
Lige nu eksponerer vi Go direkte på port 8080. Vi burde:
- ✅ Tilføje Nginx som reverse proxy foran Go backend
- ✅ Load balancing hvis vi scaler til multiple Go instances
- ✅ TLS termination i Nginx (HTTPS)
- ✅ Static file serving (style.css) direkte fra Nginx
- ✅ Rate limiting og security headers i central location

**Potentiel Nginx config for WhoKnows**:
```nginx
events {}

http {
    upstream whoknows_backend {
        server go-app:8080;
    }

    server {
        listen 80;
        server_name whoknows.example.com;

        location /static/ {
            alias /usr/share/nginx/html/static/;
        }

        location / {
            proxy_pass http://whoknows_backend;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }
    }
}
```

### Incident Response
- **Breach Response Tooling**: Vi har allerede `breach_response.sh` script
- **Next Step**: Lave blameless postmortem template i docs/
- **Practice**: Næste gang noget går galt (deployment failure, bug i prod), dokumenter det som postmortem
  - Hvad skete? Timeline
  - Hvorfor skete det? Root cause
  - Hvordan løste vi det? Actions taken
  - Hvad lærer vi? Preventive measures (ikke "vær mere forsigtig" - systemic fixes!)

### DevOps Maturity Assessment for WhoKnows
**Hvor er vi gode:**
- ✅ Automation: CI/CD, Dependabot
- ✅ Containerization: Docker/Compose dev + prod
- ✅ Testing: Unit + integration tests
- ✅ Version Control: Conventional commits, branch protection
- ✅ Documentation: OpenAPI, architecture diagrams, strategy docs

**Hvor kan vi forbedre:**
- ⚠️ Monitoring & Observability: Ingen metrics, logs, eller alerting endnu
- ⚠️ Infrastructure as Code: Terraform nævnt men ikke implementeret
- ⚠️ Full CD: Næsten der, men mangler automated docker-compose deployment
- ⚠️ Incident Response: Breach script findes, men ingen postmortem praksis
- ⚠️ Load Balancing/Scaling: Ingen reverse proxy, single instance
- ⚠️ Security: CSRF done, men mangler HTTPS, rate limiting, comprehensive security audit

### Action Items til Eksamen
1. **Implementer Full CD**: SCP docker-compose i CD pipeline
2. **Tilføj Nginx**: Reverse proxy med HTTPS
3. **Monitoring**: Prometheus + Grafana for metrics
4. **Terraform**: Codify Azure infrastructure
5. **Postmortem Practice**: Dokumenter næste incident
6. **SPACE Metrics**: Track team satisfaction & communication quality, ikke kun commits

### Eksamen Talking Points
- **"Vi følger DevOps Handbook's Three Ways"**: Konkrete eksempler fra vores projekt
- **"Knowledge sharing er vores fokus"**: Docs/, pair programming, PR reviews
- **"Vi bygger resilience ind"**: CSRF, migrations, fail2ban, Docker isolation
- **"Continuous Learning"**: Migration fra Python til Go = massiv learning curve men vi tackled it sammen
- **"People over Process"**: Branch strategy er simpel (GitHub Flow) fordi vi er 4 personer - ville skalere den hvis teamet voksede
