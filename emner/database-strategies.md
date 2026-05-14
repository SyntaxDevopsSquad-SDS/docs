# Database Strategies & ORM

## Det vigtigste valg
Det absolut vigtigste at huske, når man vælger en database, er, at det skal være det rigtige valg til det specifikke **use case**. Selvom argumentet "det er den database, jeg kender bedst" ofte bruges, er det kun relevant, hvis databasen rent faktisk løser opgaven korrekt.

## SQLite: Mere end rigeligt
Man skal ikke undervurdere SQLite. For de fleste webapplikationer (især i Danmark) vil man aldrig løbe ind i de tekniske begrænsninger, som SQLite har.

**Insane SQLite Facts:**
*   **Udbredelse**: Det er den mest udbredte database i verden med over 1 billion (en million millioner) databaser i aktiv brug.
*   **Vedligeholdelse**: Hele projektet vedligeholdes af kun tre personer, som ikke tillader bidrag udefra.
*   **Oprindelse**: SQLite opstod på et amerikansk krigsskib (USS Oscar Austin) i år 2000. Udvikleren, Richard Hipp, ønskede en database, der kunne køre direkte fra disken uden en server-afhængighed, som kunne fejle under kritiske operationer.

## PostgreSQL vs. MySQL
Valget mellem de to store spillere i branchen har ændret sig over tid. Hvor MySQL historisk set var størst, er PostgreSQL i dag det foretrukne valg blandt udviklere.

| Feature | PostgreSQL | MySQL |
| :--- | :--- | :--- |
| **Type** | Open-source | Proprietær |
| **Popularitet (2024)** | 49% af udviklere | 44% (faldende fra 59% i 2018) |
| **Data typer** | Stærk support for JSON og JSONB | Begrænset support for JSON |
| **Skalering** | Inkluderet i open-source udgaven | High availability kræver ofte Enterprise Edition |

## Skal man bruge en ORM?
En **ORM (Object-Relational Mapping)** er et værktøj, der danner bro mellem kode og database, såsom Prisma eller Objection.js. Det er dog ikke altid det rigtige valg:

*   **Effektivitet**: En ORM er enten lige så effektiv eller *mindre* effektiv end at skrive rå SQL.
*   **Sikkerhed**: Det er en myte, at en ORM er "mere sikker" end korrekt skrevet SQL.
*   **MVPs**: For små projekter eller prototyper bør man ikke spilde tid på at sætte en kompliceret ORM op.

**Beslutningen i WhoKnows:**
I dette projekt gav det ikke mening at bruge en ORM grundet projektets omfang, den faste deadline og kompleksiteten af dataene. Ved eksamen accepteres det dog, hvis man har brugt en ORM udelukkende for at lære teknologien at kende.

## Mulige eksamensspørgsmål
- [ ] Hvorfor valgte I netop jeres database til dette specifikke use case?
- [ ] Hvad er fordelen ved at skrive rå SQL fremfor at bruge en ORM i WhoKnows?
- [ ] Hvordan adskiller PostgreSQL sig fra MySQL i forhold til licensering og features?
- [ ] Hvilken betydning har JSONB-support i PostgreSQL for moderne webudvikling?

## Relevante uger
*   Uge 10 (9. april) — Databases, ORM & Web Scraping.