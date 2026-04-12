# Uge 09 – DevSecOps, SAST/DAST & fail2ban

> 📅 Dato: 26. marts

## 🎯 Læringsmål
*(Kopiér de relevante punkter fra [læringsmål-master.md](../../læringsmål-master.md))*

- [ ] Kan forklare Shift-Left mentaliteten og sikkerhed i DevOps 8-infinity-loop
- [ ] Kan nævne forskellige typer sikkerhedstest — kan forklare SAST vs. DAST
- [ ] Ved hvordan man security-scanner et Docker-image
- [ ] Forstår IPTables-problemet med Docker og kan foreslå en løsning
- [ ] Forstår continuous testing-mentaliteten
- [ ] Kan forklare Shift-Left vs. Shift-Right testing med eksempler


## 📌 Kernebegreber
| Begreb | Kort forklaring |
|--------|----------------|
| **DevSecOps** | DevOps udvidet med sikkerhed som integreret del af hver fase - sikkerhed automatiseres og bliver alles ansvar, ikke kun security team |
| **Shift Left** | Princip om at flytte aktiviteter (testing, sikkerhed) tidligere i udviklingsprocessen for at fange problemer hurtigere og billigere |
| **Shift Right** | Princip om at teste og overvåge i produktion (A/B testing, monitoring, canary deployments) for at få real-world feedback |
| **SAST** | Static Application Security Testing - white-box testing der analyserer kildekode uden at køre den (tools: SonarQube, Checkmarx) |
| **DAST** | Dynamic Application Security Testing - black-box testing der tester running application udefra (tools: OWASP ZAP, Burp Suite) |
| **DevSecOps Figure 8** | Infinite loop model der viser hvordan sikkerhed integreres i hver fase af DevOps lifecycle (Plan → Code → Build → Test → Release → Deploy → Operate → Monitor) |
| **Security Gates** | Automated checkpoints i CI/CD pipeline: Pre-commit (static analysis), Pre-merge (code review), Pre-deployment (testing), Post-deployment (monitoring) |
| **fail2ban** | Tool fra 2004 der beskytter servere mod brute-force attacks ved at banne IP'er efter fejlede login-forsøg |
| **Red Team vs Blue Team** | Security øvelse hvor Red Team angriber (offensive security) og Blue Team forsvarer (defensive security) |
| **Continuous Testing** | Integration af tests gennem hele CI/CD: Unit tests i CI, integration/smoke tests i CD staging, monitoring/smoke tests i production |
| **Test Pyramid** | Model for test strategi - mange unit tests (base), færre integration tests (middle), få end-to-end tests (top) for optimal cost/speed/coverage |
| **Unit Testing** | Tests af individuelle komponenter isoleret fra resten af systemet - hurtige, mange, billige |
| **Integration Testing** | Tests af hvordan komponenter arbejder sammen - bruger faktiske dependencies, langsommere end unit tests |
| **End-to-End Testing** | Tests af hele user flows gennem applikationen - tools: Playwright, Selenium, Cypress, Puppeteer |
| **Test Coverage** | Metric der måler hvor meget af kodebasen der er dækket af tests - tools: Istanbul, Jest |
| **Performance/Load Testing** | Tests der måler system performance under load - tools: JMeter, Gatling, Locust, Grafana K6 |
| **A/B Testing** | Shift-right test hvor to versioner af feature vises til forskellige user groups for at måle hvilken performer bedst |
| **Quality Gate** | Automatisk stop i pipeline hvis tests fejler - forhindrer broken code i at nå production |
| **Happy Path vs Sad Path** | Happy path = expected/normal user flow, Sad path = error conditions og edge cases |
| **Boundary Testing** | Test af upper bound, lower bound og edge cases i input validation |
| **Playwright** | Modern end-to-end testing framework med codegen, headed/headless mode, cross-browser support, HTML reports |
| **GitHub Actions Matrix** | Strategi til at køre samme job på multiple runtime environments (fx Node 14, 16, 18) parallelt |
| **TLS/SSL** | Transport Layer Security - encryption protocol for HTTPS. Certbot bruges til at få gratis Let's Encrypt certificates |
| **iptables** | Low-level Linux firewall tool med granular control over network traffic rules |
| **ufw** | Uncomplicated Firewall - high-level interface til iptables, simplificerer firewall management |
| **Docker Firewall Bypass** | Problem hvor Docker circumventer UFW og ændrer iptables direkte ved port mapping - åbner ports til verden |
| **IP Range Limiting** | Løsning til Docker firewall issue: `127.0.0.1:8080:8080` (internal only) vs `80:80` (public) |
| **Hash-Pinning** | Security practice i GitHub Actions: brug commit hash i stedet for version tag for third-party actions for at undgå malicious updates |
| **Dependabot** | GitHub tool til automated dependency scanning og security updates - opretter PRs når vulnerabilities findes |
| **Dependabot Alerts** | Notifikationer når dependencies har kendte security vulnerabilities |
| **Dependabot Version Updates** | Automated PRs for at holde dependencies updated (configured i `dependabot.yml`) |
| **Security Monitoring** | Production monitoring af traffic, access, file changes - dashboard tools som Zabbix |
| **GDPR Breach Response** | Ved data breach: inform affected users, inform authorities (Datatilsynet), conduct postmortem, improve systems |
| **Andon Cord** | DevOps princip om at stoppe arbejdet når problemer opdages og "swarm" sammen om løsning - sikkerhed er alles ansvar |
| **Dependency Scanning** | Automated scanning af dependencies for known vulnerabilities - 2020 Octoverse report viser det er bedste måde at secure codebase |
| **White-Box Testing** | Testing med fuld knowledge om internal struktur (source code access) - synonym for SAST |
| **Black-Box Testing** | Testing uden knowledge om internal struktur (external perspective) - synonym for DAST |
| **Smoke Testing** | Quick sanity tests der verificerer basic functionality virker efter deployment - både i staging og production |
| **Exploratory Testing** | Manual testing uden predefined test cases - testeren lærer systemet mens de tester |


## 📝 Egne noter
*Se [noter.md](./noter.md)*

## 🔗 Ressourcer
- Slides:
- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/09._Testing_Security/02._devsecops.md
- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/09._Testing_Security/03._docker_firewalls.md
- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/09._Testing_Security/04._security_in_github.md
- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/09._Testing_Security/05_continuous_testing.md
- Opgaver:
- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/09._Testing_Security/01._introduction.md
- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/01._Assignments/09._Testing_Security/02._After/fail2ban.md
- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/01._Assignments/09._Testing_Security/02._After/harden_yourself.md
- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/01._Assignments/09._Testing_Security/02._After/security_breach.md
- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/01._Assignments/09._Testing_Security/02._After/setup_https.md
- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/01._Assignments/09._Testing_Security/02._After/implement_tests.md

## 🧩 Se også i emner/
*(Hvilke tværgående emner dækker denne uge?)*
