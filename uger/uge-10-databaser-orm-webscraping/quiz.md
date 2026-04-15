# 🧠 Quiz – Uge 10: Databases, ORM & Web Scraping

> **Mundtlig øvelse:** Svar højt uden at kigge. Sæt kryds når du kan forklare det flydende.

- [ ] Hvad er det centrale begreb i denne uge og hvorfor er det vigtigt?
- [ ] Kan du give et konkret eksempel fra WhoKnows-projektet?
- [ ] Hvad er fordele og ulemper ved den tilgang I valgte?
- [ ] Hvad ville du gøre anderledes næste gang?

---

### 🎯 Uge-specifikke spørgsmål

- [ ] **Databasevalg**: Hvorfor er argumentet "det kender jeg bedst" ugyldigt? Kan du nævne nogle grunde til, at SQLite faktisk er "good enough" til de fleste danske web-apps?
- [ ] **MySQL vs. PostgreSQL**: Hvorfor anses MySQL som "problematisk" i DevOps-kredse (tænk på ejerskab og enterprise-låse), og hvad er fordelen ved PostgreSQL's JSONB-support?
- [ ] **ORM Dilemmaet**: Forklar begrebet "Object-Relational Impedance Mismatch". Hvorfor valgte vi i SyntaxDevOpsSquad at køre uden en ORM?
- [ ] **N+1 Problemet**: Kan du forklare, hvad N+1 problemet er i forbindelse med ORM'er, og hvordan det påvirker performance?
- [ ] **Migrations (DDL)**: Hvad er formålet med en migration, og hvorfor er det bedre end bare at dele en `schema.sql` fil i teamet?
- [ ] **Seeding (DML)**: Hvad er forskellen på en schema-migration og en data-migration? Giv et eksempel på, hvad vi har "seeded" i vores database.
- [ ] **Rollback**: Hvorfor er det kritisk for en DevOps-pipeline, at en migration har en `down`-funktion?
- [ ] **Indexing & Search**: Hvad er fordelen ved **FTS5** (Full-Text Search) fremfor en standard `LIKE %query%` søgning?
- [ ] **Database Triggers**: Hvordan bruger vi triggers i vores projekt til at holde vores søge-indeks opdateret helt automatisk?
- [ ] **Scraping vs. Crawling**: Forklar forskellen mellem de to begreber. Hvornår er man nødt til at bruge en **Headless Browser** (som Playwright)?
- [ ] **Anti-scraping**: Hvad er en "Spider Trap", og hvordan kan "Rate Limiting" påvirke jeres scraping-scripts?
- [ ] **Politeness**: Hvad skal man tjekke i en `robots.txt` fil, og hvorfor skal man identificere sig med en `User-agent`?
- [ ] **Jura**: Hvad siger Ophavsretslovens § 11b om scraping og data mining i Danmark?