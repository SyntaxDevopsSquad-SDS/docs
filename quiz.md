# 🧠 Quiz – Mundtlig Eksamensforberedelse

> Brug `<details>` til at skjule svaret. Prøv at svare højt FØR du åbner!
> Fordeling: Hver person udfylder quiz for de uger de har ansvar for.

---

## Uge 01 — Introduktion, Git & Legacy Project
*(Ansvarlig: Najib)*

<details>
<summary>Hvad er source code archaeology og hvorfor er det relevant?</summary>

Processen med at analysere og forstå gammel/arvet kode. Relevant fordi vi overtog WhoKnows-projektet fra 2009 og skulle forstå det inden vi kunne modernisere det.
</details>

<details>
<summary>Hvilke kommandoer bruger du til at finde hvad der kører på en server?</summary>

`ps aux | grep <navn>` — find processer, `lsof -i -nP` — find åbne netværksforbindelser og porte, `netstat -tuln` — vis åbne porte.
</details>

<details>
<summary>Hvad er forskellen på `scp` og `ssh`?</summary>

`ssh` bruges til at logge ind på en server og køre kommandoer. `scp` bruges til at kopiere filer sikkert til/fra en server.
</details>

---

## Uge 02 — Conventions, OpenAPI, DotEnv, Monorepo
*(Ansvarlig: Marcus)*

<!-- Marcus udfylder spørgsmål her -->

---

## Uge 03 — GitHub Actions, Azure, Cloud, Deploy
*(Ansvarlig: Marcus)*

<!-- Marcus udfylder spørgsmål her -->

---

## Uge 04 — Software Quality, Linting, CI/CD, Branching
*(Ansvarlig: Daniel)*

<!-- Daniel udfylder spørgsmål her -->

---

## Uge 05 — Docker, Dockerfile, Build Tools, Virtualization
*(Ansvarlig: Najib)*

<details>
<summary>Hvad er forskellen på en container og en virtuel maskine?</summary>

En VM kræver et fuldt OS per instans og er tung. En container deler hostens kernel og er letvægts. Containers starter hurtigere og bruger færre ressourcer.
</details>

<details>
<summary>Hvad er forskellen på RUN, CMD og ENTRYPOINT i en Dockerfile?</summary>

RUN køres under build-fasen. CMD er standardkommandoen ved opstart og kan overrides. ENTRYPOINT definerer hovedkommandoen og kan ikke overrides nemt.
</details>

<details>
<summary>Hvad er Docker layers og hvorfor er de vigtige?</summary>

Hvert Dockerfile-instruktion skaber et lag. Docker cacher layers så kun ændrede lag rebuildes. Optimering: kopier package-filer FØR kode så npm/pip install caches.
</details>

---

## Uge 06 — Docker Compose, Continuous Delivery, Agile
*(Ansvarlig: Najib)*

<details>
<summary>Hvad er fordelen ved Docker Compose over kun Dockerfiles?</summary>

Docker Compose definerer og kører multi-container applikationer med én kommando. Det håndterer netværk, volumes og environment variables på tværs af services.
</details>

<details>
<summary>Hvad er Continuous Delivery vs. Continuous Deployment?</summary>

Continuous Delivery: koden er altid i deploybar tilstand men kræver manuel godkendelse til produktion. Continuous Deployment: deployer automatisk til produktion uden manuel godkendelse.
</details>

<details>
<summary>Hvad er Agile og hvorfor blev det skabt?</summary>

Agile er en iterativ softwareudviklingsmetode skabt i 2001 som modreaktion på tunge waterfall-processer. Fokus på små teams, hyppige leverancer og tilpasning til forandringer.
</details>

---

## Uge 07 — DevOps Historie, Psychological Safety
*(Ansvarlig: N/A — Gæsteforelæsning, ingen quiz)*

---

## Uge 08 — DevOps is People, Postmortem, Continuous Deployment
*(Ansvarlig: Abdul)*

<!-- Abdul udfylder spørgsmål her -->

---

## Uge 09 — DevSecOps, SAST/DAST, Shift-Left
*(Ansvarlig: Abdul)*

<!-- Abdul udfylder spørgsmål her -->

---

## Uge 10 — Databaser, ORM, Migrations, Web Scraping
*(Ansvarlig: Daniel)*

<!-- Daniel udfylder spørgsmål her -->

---

## Uge 11 — Logging, Monitoring, KPIs, Prometheus + Grafana
*(Ansvarlig: Najib)*

<details>
<summary>Hvad er forskellen på logging og monitoring?</summary>

Logging viser hvad der skete og hvorfor — tekstbaserede records til debugging. Monitoring viser hvad der sker nu — numeriske metrics til alerting og dashboards.
</details>

<details>
<summary>Hvad er ELK stacken og hvad gør hver komponent?</summary>

Elasticsearch gemmer og indekserer logs. Logstash indsamler og transformer logs fra forskellige kilder. Kibana visualiserer data fra Elasticsearch.
</details>

<details>
<summary>Hvad er et KPI og hvad er forskellen på et KPI og en metric?</summary>

En metric er en målbar værdi (f.eks. CPU %). Et KPI er en forretningsmæssig nøglemåling der viser om man når sine mål (f.eks. antal aktive brugere, månedlige omkostninger).
</details>

<details>
<summary>Hvad er Prometheus og hvordan fungerer scraping?</summary>

Prometheus er et open-source monitoring tool der med faste intervaller henter (scraper) metrics fra applikationer via HTTP endpoints. Data gemmes som tidsserier og kan visualiseres i Grafana.
</details>
