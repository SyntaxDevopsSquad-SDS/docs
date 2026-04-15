# 🧠 Quiz – Uge 04: Software Quality, Linting & CI/CD

> **Mundtlig øvelse:** Svar højt uden at kigge. Sæt kryds når du kan forklare det flydende.

- [ ] Hvad er det centrale begreb i denne uge og hvorfor er det vigtigt?
- [ ] Kan du give et konkret eksempel fra WhoKnows-projektet?
- [ ] Hvad er fordele og ulemper ved den tilgang I valgte?
- [ ] Hvad ville du gøre anderledes næste gang?

---

### 🎯 Uge-specifikke spørgsmål

- [ ] **ISO 25010 & Kvalitet**: Kan du forklare forskellen på funktionelle og non-funktionelle krav ("the ilities"), og hvilke vi har prioriteret i WhoKnows?
- [ ] **Technical Debt**: Hvad er "teknisk gæld", og hvordan kan en CI-pipeline (Quality Gate) forhindre, at "renterne" (Cost of Change) stiger?
- [ ] **Analyse-typer**: Hvad er forskellen på statisk og dynamisk analyse? Giv et eksempel på et værktøj til hver fra vores workflows.
- [ ] **CI/CD/CD definitioner**: Forklar kursets specifikke 3-deling af pipelinen. Hvornår udfører vi "Delivery", og hvornår udfører vi "Deployment"?
- [ ] **Branching Rejsen**: Hvorfor valgte vi at droppe en kompleks branching-model til fordel for Feature Branching (GitHub Flow)? Hvilke "unødvendige trin" fjernede vi?
- [ ] **Linting-strategi**: Hvorfor er det vigtigt at køre linters i CI-pipelinen, selvom man måske kører dem lokalt via Git Hooks?
- [ ] **Feedback-loops**: Hvordan fungerer vores Smoke Test som en "Andon Cord", og hvilken type feedback giver den os efter en deployment?
- [ ] **Infrastruktur-validering**: Hvordan bruger vi `sqlite3` i vores CI-pipeline til at tjekke for "Infrastructure debt"?
- [ ] **Automatisering**: Forklar hvordan et Cron-job kan bruges til Continuous Deployment, og hvordan man optimerer det, så det ikke genstarter applikationen unødvendigt. 