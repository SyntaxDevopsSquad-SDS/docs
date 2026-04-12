# Noter – Uge 09: DevSecOps, SAST/DAST & fail2ban

## Resumé
DevSecOps integrerer sikkerhed i hele DevOps-cyklussen som automatiseret ansvar for alle, ikke kun security teams. Shift-Left betyder tidlig security testing (SAST i CI, dependency scanning), mens Shift-Right er monitoring i produktion. Continuous Testing spænder fra unit tests over integration/E2E tests til A/B testing i produktion, guidet af Test Pyramid. Docker bypasser UFW firewalls (løsning: IP range limiting), fail2ban beskytter mod brute-force attacks, og Dependabot automatiserer dependency updates. Kritisk: hash-pin third-party GitHub Actions, og brug aldrig third-party extensions til credentials.

## Vigtige pointer
*(Hvad ville du fremhæve til eksamen?)*

### DevSecOps Kerneprincip
- **Sikkerhed er ALLES ansvar**, ikke kun security team - alle developers bliver ansvarlige gennem automation
- **DevSecOps Figure 8**: Sikkerhed integreres i hver fase (Plan → Code → Build → Test → Release → Deploy → Operate → Monitor → tilbage til Plan)
- **Security Gates**: Pre-commit (SAST), Pre-merge (code review), Pre-deployment (DAST), Post-deployment (monitoring)
- **100:10:1 ratio problem**: Typisk 100 Dev : 10 Ops : 1 Infosec - derfor SKAL sikkerhed automatiseres

### SAST vs DAST
- **SAST (Static)**: White-box, analyserer source code tidligt (SonarQube, Checkmarx) - shift-left
- **DAST (Dynamic)**: Black-box, tester running application (OWASP ZAP, Burp Suite) - shift-right  
- **Best practice**: Brug BEGGE for comprehensive coverage

### Continuous Testing Strategi
- **Test Pyramid**: Mange unit tests (base), færre integration tests (middle), få E2E tests (top)
- **CI**: Unit tests + linting + SAST
- **CD Staging**: Integration tests + smoke tests + DAST
- **Production**: Monitoring + smoke tests + A/B testing
- **Quality Gates er KRITISKE**: Tests skal stoppe deployment ved fejl - ellers bliver broken tests ignored

### Shift-Left vs Shift-Right
- **Shift-Left**: Test tidligt i udvikling (billigere at fixe, hurtigere feedback) - unit/integration/SAST
- **Shift-Right**: Test i produktion (real-world conditions) - monitoring, A/B testing, canary deployments
- **Balance**: Begge er nødvendige for comprehensive quality assurance

### Playwright E2E Testing
- **Cross-browser**: Chromium, Firefox, WebKit support
- **Codegen**: Optag tests automatisk med `npx playwright codegen`
- **Headed/headless**: Debug i browser eller kør i CI headless
- **HTML reports**: Automatisk genereret test rapport i `playwright-report/`

### Docker Security KRITISK Problem
- **Docker bypasser UFW firewall**: `-p 9200:9200` åbner port til VERDEN, ignorerer UFW rules
- **Løsning**: IP range limiting - `127.0.0.1:8080:8080` (internal only) vs `80:80` (public)
- **Fallback**: Cloud provider firewall (Azure NSG) som ekstra sikkerhedslag

### fail2ban
- **Beskytter mod brute-force**: Banner IP'er efter X failed login attempts (siden 2004)
- **Konfiguration**: `/etc/fail2ban/jail.local` - definer maxretry, bantime, findtime
- **Monitoring**: `sudo fail2ban-client status sshd` for at se banned IPs

### GitHub Actions Security
- **Undgå third-party actions med credentials**: Brug native `ssh`/`scp` i `run:` steps i stedet
- **Hash-pinning**: Brug commit hash (`@8e5e7e5...`) ikke version tags (`@v3`) for third-party actions - tags er mutable
- **Secrets management**: Aldrig commit secrets, brug GitHub Secrets, roter regelmæssigt

### Dependabot
- **Auto dependency updates**: Weekly PRs for outdated dependencies (`dependabot.yml`)
- **Security alerts**: Notifikationer ved kendte vulnerabilities med auto-fix PRs
- **2020 Octoverse**: Keeping software current er bedste måde at secure codebase
- **Auto-merge workflow**: Kan automatisere merge af Dependabot PRs efter tests passes

### TLS/SSL
- **Certbot**: Gratis Let's Encrypt certificates for HTTPS
- **Nginx TLS termination**: Centraliseret encryption mellem client og reverse proxy
- **HTTP → HTTPS redirect**: Altid force HTTPS i produktion

### Breach Response
- **Automated backups**: Data er mest precious asset
- **GDPR**: Inform users + authorities (Datatilsynet) ved data breach
- **Blameless postmortem**: Fokus på systemic fixes, ikke blame individuals
- **Preparedness**: Breach response script, postmortem template, incident procedures

## Forbindelser til WhoKnows-projektet
*(Hvordan relaterer dette sig til jeres eget projekt?)*

### Allerede Implementeret ✅
- **SAST**: golangci-lint i CI finder Go security issues
- **Dependency Scanning**: Dependabot enabled med auto-merge workflow
- **Unit Tests**: `database_test.go` white-box testing
- **Integration Tests**: `integration_test.go` tester komponenter sammen
- **Security Hardening**: CSRF protection, middleware, session management
- **Server Security**: fail2ban konfiguration i `server-config/fail2ban-jail.local`
- **Breach Response**: `scripts/breach_response.sh` for incident handling

### Mangler/Skal Implementeres ⚠️

**E2E Testing med Playwright**:
```javascript
// tests/whoknows.spec.js
test('user can register and login', async ({ page }) => {
  await page.goto('/register');
  await page.fill('input[name="username"]', 'testuser');
  await page.fill('input[name="password"]', 'SecurePass123!');
  await page.click('button[type="submit"]');
  await expect(page).toHaveURL('/login');
});
```

**DAST med OWASP ZAP** (add til cd.yml):
```yaml
- name: ZAP Baseline Scan
  uses: zaproxy/action-baseline@v0.7.0
  with:
    target: 'http://whoknows-url.com'
```

**Container Scanning med Trivy** (add til ci.yml):
```yaml
- name: Scan Docker image
  uses: aquasecurity/trivy-action@master
  with:
    image-ref: 'ghcr.io/syntaxdevopssquad/whoknows:latest'
    format: 'sarif'
```

**Docker Security Audit**:
- Verify `docker-compose.prod.yml` bruger `127.0.0.1:8080:8080` (ikke `8080:8080`)
- Hvis Nginx reverse proxy: Go app skal være internal only
- Azure NSG: Allow 22 (SSH fra din IP), 80/443 (HTTP/HTTPS fra alle), deny resten

**TLS/HTTPS Setup** (hvis ikke allerede):
```bash
# På Azure VM:
sudo certbot --nginx -d whoknows.yourdomain.com
sudo systemctl restart nginx
```

**Nginx burde redirecte HTTP → HTTPS**:
```nginx
server {
    listen 80;
    return 301 https://$server_name$request_uri;
}
```

**GitHub Actions Security Audit**:
- Review alle third-party actions i `.github/workflows/`
- Hash-pin hver action: `actions/checkout@8e5e7e5...` ikke `@v3`
- Verify ingen credentials sendes til third-party actions
- Brug native `ssh`/`scp` i `run:` steps

**Test Coverage Metrics** (add til CI):
```bash
go test -coverprofile=coverage.out ./...
go tool cover -html=coverage.out
# Upload coverage til GitHub Actions artifacts
```

**Performance/Load Testing** (fremtidig):
- K6 eller Locust for load testing i staging
- Simulate concurrent users, measure response times
- Catch performance regressions før production

**Security Monitoring** (fremtidig):
- Prometheus + Grafana for metrics
- Monitor: failed login attempts, unusual traffic patterns, file changes
- Alerting ved anomalies

**Postmortem Template**:
- Create `docs/postmortem_template.md` for blameless incident analysis
- Practice: Document næste incident (deployment failure, bug i prod)
- Focus: Timeline, root cause, systemic fixes (ikke "vær mere forsigtig")

### DevSecOps Maturity for WhoKnows

**Styrker**:
- Shift-Left: SAST (linting), unit/integration tests, dependency scanning
- Automation: CI/CD med security checks, Dependabot auto-merge
- Application Security: CSRF, middleware, secure sessions
- Infrastructure: fail2ban, (forhåbentlig) TLS/HTTPS

**Forbedringspunkter**:
- Shift-Right: Missing DAST, production monitoring, A/B testing
- Test Coverage: Missing E2E tests (Playwright), performance tests
- Container Security: Ingen image scanning (Trivy)
- Docker Firewall: Verify port binding strategy
- Monitoring: Ingen production security dashboards

### Eksamen Talking Points

**"Vi følger DevSecOps principles"**:
- Sikkerhed integreret i CI/CD: golangci-lint (SAST), Dependabot (dependencies), fail2ban (infrastructure)
- Security er team ansvar: Alle kan review security i PRs, alle kører security checks lokalt
- Quality gates: Tests + linter skal passe før merge til main

**"Vi balancerer Shift-Left og Shift-Right"**:
- Shift-Left: Unit tests finder bugs tidligt (billigt), SAST finder security issues før commit
- Shift-Right: (Ville tilføje) Monitoring i production, DAST testing i staging
- Test Pyramid: Mange unit tests, færre integration tests, (ville tilføje E2E tests)

**"Docker security er critical for os"**:
- Aware of Docker firewall bypass problem
- Bruger IP range limiting i docker-compose.prod.yml (verify!)
- Azure NSG som fallback security layer
- (Ville tilføje) Trivy scanning for container vulnerabilities

**"Vi har breach preparedness"**:
- `breach_response.sh` script for incident handling
- Automated backups af SQLite database
- (Ville forbedre) Postmortem template, force password reset flow
- Blameless culture: Fix systems, ikke blame people

**"Continuous improvement via Dependabot"**:
- Weekly automated PRs for dependency updates
- Auto-merge efter CI passes (safe for minor/patch updates)
- Keeps us secure: 2020 Octoverse viser current software = secure software
- Reduces manual toil: No more manual dependency checking

**Næste Steps**:
1. Playwright E2E tests i CI (højeste prioritet for test pyramid)
2. OWASP ZAP DAST scanning i CD staging
3. Trivy container scanning i CI
4. Production monitoring med Prometheus/Grafana
5. Performance testing med K6 i staging før production deploy
