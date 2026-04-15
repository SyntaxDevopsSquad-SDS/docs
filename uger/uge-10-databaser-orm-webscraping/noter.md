# Noter – Uge 10: Databases, ORM & Web Scraping

---

## 📝 Resumé
Uge 10 fokuserede på arkitekturen bag datalagring, persistens og automatiseret dataindsamling. Vi har lært at navigere i valget mellem forskellige database-paradigmer (SQLite vs. PostgreSQL vs. MySQL) og forstået vigtigheden af at vælge værktøj ud fra den specifikke "use case". Centralt i ugen stod begreberne **Migrations** (versionsstyring for data) og **Seeding**, som er essentielle for at kunne vedligeholde systemer i drift uden datatab. Slutteligt dækkede vi **Web Scraping** og **Crawling** som metoder til dataindsamling, herunder de tekniske udfordringer med JavaScript-rendering (Headless Browsers) og de juridiske rammer for etisk dataudvinding.

---

## 🚀 Vigtige pointer (Baseret på undervisningsmateriale)

### 1. Det strategiske databasevalg & ACID
Det vigtigste princip er, at databasen skal vælges ud fra applikationens specifikke behov frem for vane eller hype.
- **SQLite: "The serverless powerhouse"**: Som gennemgået i undervisningen er SQLite ofte undervurderet. Da den er fil-baseret, eliminerer den netværks-latency. Selvom den er letvægts, overholder den fuldt ud **ACID**-principperne:
    - **Atomicity**: Transaktioner er "alt eller intet".
    - **Consistency**: Databasen validerer regler (fx UNIQUE eller FOREIGN KEY).
    - **Isolation**: Samtidige brugere låser ikke hinandens data uhensigtsmæssigt.
    - **Durability**: Data gemmes permanent, selv ved strømsvigt.
- **MySQL Problematikken**: MySQL er proprietært ejet (Oracle). Mange avancerede scalability-features er låst bag Enterprise-licenser. Desuden er supporten for moderne JSON-datatyper begrænset sammenlignet med PostgreSQL.
- **PostgreSQL**: Den moderne "industry standard" for open-source databaser. Den understøtter **JSONB** (binært JSON), hvilket gør den ekstremt hurtig til at søge i ustruktureret data. PostgreSQL anses som den mest komplette open-source database med avancerede features inkluderet gratis.

### 2. ORM-debatten: Impedance Mismatch & Performance
En **Object-Relational Mapper (ORM)** fungerer som bro mellem objektorienteret kode og SQL, men det kommer med en pris.
- **Object-Relational Impedance Mismatch**: Termen for den iboende konflikt mellem at gemme objekter i kode (grafer/træer) og data i tabeller (relationer/flade rækker). En ORM forsøger at skjule denne kompleksitet, hvilket kan føre til ineffektiv SQL.
- **N+1 Problemet**: En klassisk ORM-faldgrube, hvor applikationen sender 1 query for at hente en liste og derefter N queries for at hente relateret data for hver række. Dette dræber performance, hvis man ikke er opmærksom.
- **Vurdering**: En ORM er ikke nødvendigvis hurtigere eller mere sikker end rå SQL. I projekter med stramme deadlines og fastlåst data-scope kan det ofte være spild af tid at opsætte en kompleks ORM.

### 3. Migrations & Schema Evolution (DDL vs. DML)
Migrationer erstatter delingen af statiske SQL-filer og fungerer som versionsstyring for din database.
- **DDL (Schema migration)**: Data Definition Language. Ændrer strukturen (fx `CREATE TABLE`, `ALTER TABLE`). Det handler om selve fundamentet.
- **DML (Data migration / Seeding)**: Data Manipulation Language. Ændrer indholdet (fx `INSERT` af test-brugere eller migrering af data fra et format til et andet).
- **Up/Down Lifecycle**: En professionel migration indeholder altid en `up` (opgradering) og en `down` (fortrydelse/rollback). Dette sikrer, at man kan rulle tilbage til en kendt tilstand, hvis en udrulning i produktion fejler.
- **Transaktionssikkerhed**: I avancerede setups køres migrationer i transaktioner. Hvis én linje fejler, rulles alt tilbage, så databasen ikke efterlades i en korrupt eller "halv-færdig" tilstand.

### 4. Indexing & Full-Text Search (FTS5)
Standard indeksering (B-Tree) er god til præcise matches (`id = 5`), men ekstremt langsom til søgning i fritekst (`LIKE %query%`).
- **FTS5 (Full-Text Search)**: Et specialiseret modul i SQLite til lynhurtig søgning. Det bygger et omvendt indeks (Inverted Index) over ordene i teksten, præcis som en søgemaskine.
- **Virtual Tables**: FTS5 bruger virtuelle tabeller, der fungerer som en søge-optimeret skygge af de rigtige data.
- **Triggers**: For at automatisere vedligeholdelse bruger man database-triggers, der kopierer data ved hver `INSERT`, `UPDATE` eller `DELETE`.

### 5. Web Scraping: Teknik, Etik & Forsvar
- **Headless Browsers (Playwright)**: Nødvendigt når sider kræver JavaScript for at renderes (Client-side rendering). Simple scrapere ser kun den rå HTML før JS har kørt, og vil derfor se en tom side.
- **Anti-scraping teknikker**: Vi har lært om forsvar som IP-blocking, CAPTCHAs og **Spider Traps** (usynlige links der fanger dumme bots i en uendelig løkke).
- **Politeness Rules**:
    - Respektér altid **Robots.txt** (Allow/Disallow).
    - Brug **Crawl-delay** for ikke at overbelaste mål-serveren.
    - Identificér dig via en korrekt **User-agent**.
- **Jura**: I EU navigerer vi efter **DSM-direktivets artikel 4** (Ophavsretsloven § 11b). Her skelnes der mellem *Scraping* (ekstraktion) og *Data Mining* (analyse). Man må generelt scrape offentlig data til mining, men skal overholde GDPR og Copyright.

---

## 🔗 Forbindelser til WhoKnows-projektet

I **SyntaxDevOpsSquad** projektet har vi omsat uge 10's teori til en robust implementering:

### 1. Database Arkitektur & Persistence
- **SQLite & Go Driver**: Vi bruger `modernc.org/sqlite`, som er en pure-Go driver. Dette er et strategisk valg for vores **DX**, da vi undgår CGO-afhængigheder. Det gør vores Docker-builds uafhængige af host-systemets C-biblioteker, hvilket sikrer fuld portabilitet.
- **Persistence via Docker**: I vores `docker-compose.prod.yml` monterer vi databasen i `/opt/whoknows/`. Ved at bruge volumes (`whoknows-data:/data`) sikrer vi, at vores data persisterer, selvom vi sletter og genopretter vores containere i vores CD-pipeline.
- **QueryDB Utility**: Vi har implementeret vores egen `QueryDB` hjælpefunktion i Go. Den håndterer `rows.Next()` og scanning af data til maps, hvilket giver os maksimal gennemsigtighed uden kompleksiteten fra en ORM.

### 2. Manuel Migrations-strategi & Sikkerhed
Vi har valgt at styre vores database-evolution gennem nummererede SQL-scripts i `/migrations`:
- **Version Control for Data**: Ved at gemme vores schema-ændringer som commits, undgår vi "it works on my dev DB" problemer. Alle udviklere har det samme fundament.
- **Migration 001 (FTS5 & Schema Evolution)**: Her brugte vi "Table Rename" teknikken (`ALTER TABLE pages RENAME TO pages_old`). Dette er en sikker måde at opgradere en tabel-struktur på uden at miste data i SQLite, som ellers har begrænset support for visse `ALTER TABLE` kommandoer.
- **Migration 002 (Security Breach & Password Reset)**: Vi har udvidet vores `users` tabel med `force_password_reset` og tilføjet en dedikeret `password_reset_tokens` tabel. Ved at bruge `ON DELETE CASCADE` på vores foreign keys sikrer vi automatisk data-oprydning, når en bruger slettes, hvilket overholder GDPR-princippet om dataminimering.

### 3. Søge-optimering med Triggers (Advanced FTS5)
Vi har implementeret en sofistikeret søge-arkitektur i `schema.sql`:
- Vi bruger **Virtual Tables** (`pages_fts USING fts5`).
- Vi har automatiseret synkroniseringen via **Database Triggers** (`pages_ai`, `pages_ad`, `pages_au`). Det betyder, at vores søge-indeks altid er 100% up-to-date, uanset om data indsættes manuelt eller via en scraper. Dette fjerner risikoen for "stale data" i søgeresultaterne og reducerer den tekniske gæld i applikationslaget.

---

## 🎓 Eksamen Talking Points

**"Hvorfor er SQLite et validt valg til vores projekt fremfor MySQL?"**
SQLite fjerner behovet for at drifte en separat database-server (separation of concerns), hvilket passer perfekt til vores DevOps-mål om enkelthed. Vi undgår netværks-latency, og vores backup-strategi bliver så simpel som at kopiere én enkelt fil. Til WhoKnows-projektets nuværende skala vil vi aldrig ramme SQLite's begrænsninger, og vi nyder godt af dens ACID-compliance.

**"Forklar forskellen på DDL og DML i jeres projekt."**
Vi bruger DDL (Data Definition Language) i vores migrationer til at bygge og ændre strukturen (fx vores `pages` tabel). Vi bruger DML (Data Manipulation Language) i vores `schema.sql` til seeding (fx indlæsning af Wikipedia-artikler og admin-bruger). Det sikrer, at systemet er "ready-to-use" med det samme efter en frisk deployment i vores CI/CD flow.

**"Hvordan håndterer I 'Client-side rendering' når I scraper data?"**
Hvis vi scraper sider bygget med moderne frameworks som React, bruger vi en Headless Browser som **Playwright**. Vi bruger kommandoen `page.goto(url, { waitUntil: 'networkidle' })`, som sikrer, at JavaScript'en er færdig med at hente og rendere dataen, før vores scraper forsøger at læse indholdet.

**"Hvad er fordelen ved jeres trigger-baserede FTS5 løsning?"**
Den sikrer absolut datakonsistens på databaseniveau. Ved at lade databasen selv stå for synkroniseringen af søge-indekset, fjerner vi risikoen for, at vores applikations-logik (Go-koden) glemmer at opdatere indekset efter en skrivning. Det er en "set-and-forget" løsning, der øger systemets pålidelighed.

**"Hvad er 'Object-Relational Impedance Mismatch' og hvordan påvirker det jeres valg af ORM?"**
Det er udfordringen ved at mappe objektorienterede modeller til relationelle tabeller. Vi har valgt at undgå en ORM for at minimere denne kompleksitet og bevare fuld kontrol over vores SQL, især da vi bruger avancerede SQLite-features som FTS5, som mange ORM'er ikke understøtter indfødt uden "raw SQL escape hatches".

**"Hvorfor er 'idempotens' vigtigt i jeres migrations-scripts?"**
Det er vigtigt i en CI/CD-kontekst, fordi vores workflows kan køre flere gange. Hvis et script ikke er idempotent (fx bruger `CREATE TABLE IF NOT EXISTS`), ville det fejle ved det andet kørsel, hvilket ville blokere vores pipeline unødvendigt.