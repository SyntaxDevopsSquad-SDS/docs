# Web Scraping & Ethics

## Hvad er det?
Web scraping (også kaldet data scraping) er processen med at downloade og udtrække specifik, struktureret data fra websider. Det er en central metode til automatiseret dataindsamling, som gør det muligt at fodre systemer med information fra eksterne kilder.

## Scraping vs. Crawling
Det er vigtigt at skelne mellem de forskellige metoder til at navigere på nettet:
*   **Web Scraping**: Udtræk af specifik data fra enkelte sider.
*   **Web Crawling**: Systematisk gennemgang og indeksering af hele websider ved at følge links (traversing).
*   **Data Mining**: Analyse af de indsamlede store datasæt for at finde mønstre og indsigt.

## Politeness og Etik (Rules of the road)
For ikke at overbelaste mål-serveren (DoS-angreb) eller blive blokeret, skal man følge "politeness rules":
*   **Robots.txt**: En fil på serveren, der definerer adgangsregler. Man skal altid respektere `Allow` og `Disallow` instrukser. Et eksempel er PriceRunner, der bruger disse regler til at styre bots.
*   **Crawl-delay**: Indlæggelse af forsinkelser mellem requests for at mindske belastningen på serveren.
*   **User-agent**: Identificér din bot via en header, så websitets ejer ved, hvem der scraper og kan kontakte teamet hvis nødvendigt.
*   **Spider Traps**: Vær opmærksom på uendelige loops af websider, der er designet til at fange og crashe dårligt konstruerede crawlere.

## Tekniske udfordringer (JavaScript-rendering)
Mange moderne websider bruger JavaScript til at indlæse indhold (Client-side rendering). Hvis man bruger en simpel scraper, vil man ofte kun se en tom side.
*   **Headless Browser**: Værktøjer som **Playwright** kører en browser uden grafisk interface. Dette gør det muligt at eksekvere JavaScript, før dataen udtrækkes.
*   **Network Idle**: Ved at bruge kommandoer som `waitUntil: 'networkidle'`, sikrer man, at alle requests er færdige, før man læser sidens indhold.

## Jura og Copyright
Scraping skal altid foregå inden for lovens rammer:
*   **Ophavsretsloven § 11b**: Den danske implementering af EU's **DSM-direktiv (Art. 4)**. Det tillader tekst- og datamining af offentligt tilgængeligt indhold til analysebrug, medmindre ejeren eksplicit har reserveret rettighederne.
*   **GDPR**: Hvis den indsamlede data indeholder personhenførbare oplysninger, skal behandlingen overholde databeskyttelsesreglerne.
*   **Offentlig tilgængelighed**: Man må generelt scrape data, der er tiltænkt offentligheden, men aldrig bryde logins eller omgå tekniske spærringer.



## Mulige eksamensspørgsmål
- [ ] Hvad er forskellen på web scraping og crawling i jeres projekt?
- [ ] Hvordan sikrer I, at jeres scraper ikke overbelaster eksterne servere (Politeness)?
- [ ] Hvad er en Headless Browser, og hvornår er den nødvendig?
- [ ] Hvordan navigerer I i de juridiske rammer omkring datamining (DSM-direktivet)?

## Relevante uger
*   Uge 10 (9. april) — Databases, ORM & Web Scraping.