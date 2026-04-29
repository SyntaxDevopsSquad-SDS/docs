# Introduction — Uge 13

## Hvad handler ugen om?

Uge 13 er den næstsidste uge af DevOps-kurset og samler trådene fra hele forløbet. Fokus er på at tage applikationer fra simpel containerisering til egentlig produktion med orchestration, skalerbarhed og resilience.

Ugen bygger videre på det vi allerede kender — Docker, CI/CD og deployment — og introducerer det næste niveau: hvad sker der når én server og én container ikke er nok?

## De store spørgsmål denne uge

- Hvordan deployer vi infrastruktur som kode frem for at konfigurere manuelt?
- Hvad sker der med vores brugere når vi deployer ny kode?
- Hvad er orchestration og hvornår har vi brug for det?
- Hvad er Kubernetes og hvorfor er det blevet standarden?
- Hvad gør vi når vores system fejler — og hvordan tester vi at det kan komme sig?

## Sammenhæng til projektet

I WhoKnows-projektet kører vi i øjeblikket en enkelt app-container og en PostgreSQL-container på én Azure VM. Det fungerer, men det er sårbart:

- Én VM = single point of failure
- Nyt deploy = kort nedbrud (som vi oplevede med 502-fejlen)
- Manuel konfiguration af serveren = svært at reproducere

Orchestration og deployment strategies er svarene på disse problemer i en større skala.

## Læringsmål

- Kender forskellige deployment strategier og hvordan de fungerer
- Forstår begrebet orchestration og kan argumentere for vigtigheden af det
- Kender de grundlæggende begreber i Kubernetes
- Forstår vigtigheden af resilience i systemer og idéen bag chaos engineering
