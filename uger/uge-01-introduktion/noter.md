# Noter – Uge 01: Introduktion, Git & Legacy Project

## Resumé
Vi arvede et legacy Python 2 projekt kaldet "WhoKnows" fra 2009 - en søgemaskine med Wikipedia-artikler om programmering. Vi SSH'ede ind på en gammel server, fandt koden via `ps`, `lsof` og `netstat`, kopierede den lokalt med `scp` og begyndte at analysere problemerne i kodebasen. Kursets mål er at modernisere dette projekt ved hjælp af CI/CD og DevOps-principper.

## Vigtige pointer
- DevOps er ikke kun teknologi - det er kultur og samarbejde
- Legacy kode skal analyseres systematisk: dependency graph, problemliste sorteret efter prioritet
- `lsof -i -nP` og `netstat -tuln` er go-to kommandoer til at finde hvad der kører på en server
- Kurset slutter med eksamensspørgsmålet: "Hvad gjorde jer til DevOps - og hvad gjorde jer ikke?"

## Forbindelser til WhoKnows-projektet
Vi overtog det originale WhoKnows-projekt og har siden migreret det fra Python til Go, opgraderet databasen, tilføjet CI/CD og fuld continuous deployment. Den dependency graph vi lavede i uge 1 gav os overblik over hvad der skulle reimplementeres.
