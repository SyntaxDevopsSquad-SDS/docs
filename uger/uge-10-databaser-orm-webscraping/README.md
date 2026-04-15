# Uge 10 – Databases, ORM & Web Scraping

> 📅 Dato: 9. april

---

## 🎯 Læringsmål
*Baseret på semesterplan og undervisningsmateriale*

- [ ] Understand choosing a database setup based on the application’s needs. Knows when not to use an ORM.
- [ ] Can argue why MySQL is a problematic choice for a database and can list additional features that other databases offer.
- [ ] Can give examples to illustrate the difference between migrations and seeding and recall how we did it in Knex.js.
- [ ] Knows about the difference between web scraping and web crawling. Has an overall idea of different ways to implement it with different tools / libraries / frameworks.
- [ ] Follows good web scraping / web crawling practices such as legality and politeness.

---

## 📌 Kernebegreber

| Begreb | Kort forklaring |
|--------|-----------------|
| **Database Choice** | At vælge DB ud fra use case. SQLite er ofte "godt nok" til de fleste web-apps, mens PostgreSQL er den moderne standard. |
| **ORM (Object-Relational Mapping)** | Bro mellem kode og DB. Kan være mindre effektiv end rå SQL og er ikke nødvendigvis mere sikker. Bruges ofte til hurtig prototyping. |
| **Migrations** | Versionsstyring for databasen. Et alternativ til én stor SQL-fil, der gør det muligt at propagere ændringer i teamet. |
| **DDL (Schema migration)** | Data Definition Language. Migrationer der ændrer selve strukturen (tabeller, kolonner). |
| **DML (Data migration/Seeding)** | Data Manipulation Language. Processen med at populere databasen med initial data (fx test-brugere). |
| **Rollback** | Evnen til at fortryde en migration og rulle databasen tilbage til en tidligere tilstand (fx `knex migrate:rollback`). |
| **JSONB** | Binært JSON-format i PostgreSQL, der tillader hurtig søgning og indeksering i dokument-data, hvilket MySQL har begrænset support for. |
| **Web Scraping** | Udtræk af specifik, struktureret data fra websider. Ofte kaldet "Data scraping". |
| **Web Crawling** | Systematisk gennemgang (traversing) og indeksering af hele websider ved at følge links. |
| **Data Mining** | Analyse af store datasæt for at finde mønstre. Juridisk adskilt fra scraping i DSM-direktivet. |
| **Politeness Rules** | Etik ved scraping: Brug af `Crawl-delay`, respekt for `Allow/Disallow` regler og identifikation via `User-agent`. |
| **Robots.txt** | Fil på serveren der definerer adgangsregler for bots. Skal altid respekteres for at undgå at overbelaste (break) sitet. |
| **DSM-direktivet Art. 4** | (Ophavsretsloven § 11b) Den juridiske ramme for tekst- og datamining i EU, som man skal navigere efter ved scraping. |
| **Headless Browser** | En browser uden GUI (fx Playwright/Chromium). Nødvendig når data kræver Client-side rendering (JavaScript) for at loade. |
| **Knex.js** | SQL query builder til Node.js, der håndterer migrationer og seeding via en JavaScript API. |
| **Alembic** | Et letvægts migrations-værktøj til Python, der bruges sammen med SQLAlchemy til at styre database-schemaer. |

---

## 📝 Egne noter
*Se [noter.md](./noter.md)*

---

## 🔗 Ressourcer
- **Course Material:** [https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring]
- **Slides:** - Databases & ORM: [https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/10._Databases_ORM_Data_scraping_Web_crawling/02._databases_orm.md]
    - Migrations: [https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/10._Databases_ORM_Data_scraping_Web_crawling/03._migrations.md]
    - Web Scraping: [https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/10._Databases_ORM_Data_scraping_Web_crawling/05._web_scraping_web_crawling.md]

---

## 🧩 Se også i emner/
- [Logging](../../emner/logging.md)
- [Monitoring](../../emner/monitoring.md)