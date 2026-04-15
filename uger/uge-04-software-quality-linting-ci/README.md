# Uge 04 – Software Quality, Linting & CI/CD

> 📅 Dato: 19. februar

---

## 🎯 Læringsmål
*Baseret på semesterplan og undervisningsmateriale*

- [ ] Understands the importance of software quality and tools to measure it (ISO/IEEE standarder).
- [ ] Understands why technical debt occurs and why it's important to avoid (CoC - Cost of Change).
- [ ] Can argue for the importance of linting (Static analysis vs. Error detection).
- [ ] Knows the difference between linting in a Git Hook vs. a CI/CD pipeline. Can argue for the pros and cons of each.
- [ ] Is familiar with different branching strategies (Gitflow, GitHub Flow, Trunk-based).

---

## 📌 Kernebegreber

| Begreb | Kort forklaring |
|--------|-----------------|
| **Software Quality** | Den samlede mængde af egenskaber ved et produkt, der tilfredsstiller både erklærede og underforståede behov (ISO 25010). |
| **DX (Developer Experience)** | Værdien af interne værktøjer og processer for udviklerne selv, selvom de ikke direkte bringer værdi til slutkunden. |
| **Non-Functional Requirements** | Også kaldet "The ilities" (Maintainability, Scalability, Security, etc.). Krav til systemets drift frem for specifikke funktioner. |
| **Technical Debt** | Metafor for de fremtidige omkostninger (Cost of Change), der opstår ved at vælge hurtige, beskidte løsninger frem for en korrekt arkitektur. |
| **Code Smells** | Overfladiske karakteristika i koden, der indikerer dybere arkitektoniske problemer (f.eks. "God Object" eller duplikeret kode). |
| **Static Analysis** | Analyse af kildekode uden eksekvering (fx linting). Finder syntaxfejl og sikkerhedshuller tidligt og billigt. |
| **Dynamic Analysis** | Analyse af kode mens den kører (fx unit tests). Finder logiske fejl, som statisk analyse ikke kan se. |
| **Linting** | En form for statisk analyse, der tjekker kode mod stilmæssige regler og potentielle fejl mønstre. |
| **Quality Gates** | Kontrolpunkter i pipelinen (fx "ingen linter-fejl"), der skal opfyldes for at koden må avancere mod produktion. |
| **CI (Continuous Integration)** | Praksis hvor udviklere hyppigt merger kode ind i en central repo, hvorefter automatiske builds og tests kører. |
| **CD (Continuous Delivery)** | At sikre, at koden altid er i en "releasable" tilstand. Fokus på levering af build artifacts (fx Docker images). |
| **CD (Continuous Deployment)** | Fuld automatisering af hele release-flowet, hvor hver ændring, der består tests, deployes direkte til produktion. |
| **Value Stream** | Det end-to-end sæt af aktiviteter, der kollektivt skaber værdi for kunden (fra idé til deploy). |
| **Git Hooks** | Scripts der trigges af Git-hændelser (fx `pre-commit`). Bruges ofte til at køre linters lokalt før en commit. |
| **Trunk-based Development** | Branching-strategi hvor alle udviklere arbejder direkte på (eller merger til) 'main' flere gange dagligt. |
| **GitHub Flow** | En simpel branching-model med fokus på feature-branches, Pull Requests og løbende deployment. |
| **Merge vs. Rebase** | To måder at integrere ændringer på: Merge bevarer historikken som den skete; Rebase skaber en lineær historik ved at "flytte" commits. |
| **Cron / Crontab** | Tidsbaseret job-scheduler i Unix. Bruges til periodiske opgaver (fx backup eller automatiserede pulls). |
| **Hadolint** | En specialiseret linter til Dockerfiles, der sikrer "best practices" for container-sikkerhed og -størrelse. |

---

## 📝 Egne noter
*Se [noter.md](./noter.md)*

---

## 🔗 Ressourcer
- **Course Material:** [https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring]
- **Slides:** 

Software Quality [https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/04._Sofware_Quality_Linting_CI/02._software_quality.md]
  
Linting [https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/04._Sofware_Quality_Linting_CI/04._linting.md]
   
---

## 🧩 Se også i emner/
- [CI/CD](../../emner/ci-cd.md)
- [Branching Strategies](../../emner/branching-strategies.md)
