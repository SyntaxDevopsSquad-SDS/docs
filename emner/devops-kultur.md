# 🧩 Emne: DevOps (Definitioner & Kultur)

## Hvad er det?
DevOps er en kultur, en bevægelse og et sæt af praksisser der nedbryder siloerne mellem Development og Operations. Det er resultatet af at anvende Lean-principper på IT-værdikæden med målet om at levere software hurtigere, mere sikkert og med højere kvalitet. Der er ingen enkelt definition — det er en konvergens af mange bevægelser.

## Hvorfor er det vigtigt i DevOps?
DevOps løser det fundamentale problem at Dev og Ops historisk har haft modstridende mål — Dev vil ændre ting, Ops vil stabilisere. DevOps forener dem ved at gøre deployment til alles ansvar og skabe en kultur af transparens, feedback og kontinuerlig forbedring.

## Centrale begreber

| Begreb | Forklaring |
|--------|-----------|
| The Three Ways | Flow, Feedback og Continual Learning — de tre principper bag DevOps (DevOps Handbook) |
| Value Stream | Sekvensen af aktiviteter der konverterer en business-idé til værdi for kunden |
| Lead Time | Tid fra request til levering — det kunden oplever |
| Process Time | Tid der faktisk bruges på arbejdet (ekskl. ventetid i kø) |
| %C/A | Percent Complete and Accurate — måler kvaliteten af output i hvert step |
| WIP | Work In Progress — begrænse WIP er centralt i Flow-princippet |
| CALMS | Culture, Automation, Lean, Measurement, Sharing — DevOps framework |
| PPT | People, Process, Technology — tre nøgler til organisatorisk succes |
| Andon Cord | Toyota-koncept: enhver kan stoppe produktionen ved et problem — brugt i DevOps til at "swarm" problemer |
| Psychological Safety | Trygt miljø hvor man tør fejle og lære — forudsætning for DevOps-kultur |
| Big Bang Deployment | Deploy alt på én gang — det DevOps prøver at undgå |
| Pair Programming | To udviklere arbejder sammen — 15% langsommere men 85% fejlfri kode (vs. 70%) |
| Knowledge Silo | Ekspertise isoleret hos enkeltpersoner — en af de største risici til eksamen |

## De Tre Ways

**First Way — Flow** (venstre mod højre: Dev → Ops → Kunde)
- Make work visible
- Limit WIP
- Reduce batch sizes
- Eliminate waste in the value stream

**Second Way — Feedback** (højre mod venstre feedback loop)
- See problems as they occur
- Swarm and solve problems
- Push quality closer to the source

**Third Way — Continual Learning**
- Institutionalize improvement of daily work
- Transform local discoveries into global improvements
- Leaders reinforce a learning culture

## DevOps Myter (vigtige til eksamen!)

| Myte | Sandheden |
|------|-----------|
| DevOps er kun for startups | Nej — store virksomheder som Amazon og Netflix har transformeret sig |
| DevOps erstatter Agile | Nej — DevOps er en naturlig fortsættelse af Agile |
| DevOps er uforeneligt med ITIL | Nej — de kan kombineres, mange ITIL-processer automatiseres |
| DevOps betyder ingen Ops | Nej — Ops' rolle ændres men forbliver vigtig |
| DevOps er kun automation | Nej — det kræver også kultur og arkitektur |

## Historisk overblik

- **2008** — Patrick Debois & Andrew Schafer: "Agile Infrastructure" på Agile-konference i Toronto
- **2009** — John Allspaw & Paul Hammond: "10 Deploys per Day" på Velocity-konference
- **2009** — Første DevOpsDays i Ghent, Belgien — termen "DevOps" opfindes
- **2009** — Jez Humble & David Farley: Continuous Delivery som begreb
- **Lean** — Toyota Production System, Kanban, Value Stream Mapping som fundament

## Forbindelser til andre emner
- **CI/CD** — The First Way i praksis: automatiseret flow fra Dev til Ops
- **Agile & Flow** — DevOps er en videreudvikling af Agile
- **Monitoring** — The Second Way i praksis: feedback fra production
- **Docker** — Containerization understøtter DevOps ved at abstraherer infrastruktur

## Eksempel fra WhoKnows-projektet
Vi praktiserer DevOps-principper ved at have fuld CD (push til main deployer automatisk), code reviews via PRs, smoke tests der giver feedback efter deployment, og ved at alle teammedlemmer har kendskab til både Dev og Ops (end-to-end responsibility). Vi bruger branching strategy og conventional commits for at gøre arbejdet synligt.

## Læringsmål
- [ ] Kan argumentere for fordelen ved Docker Compose over kun at bruge Dockerfiles
- [ ] Forstår forskellige grundlæggende docker-compose.yml filer
- [ ] Forstår behovet for volumes til live reload i Docker og at det kræver et separat development build
- [ ] Forstår Continuous Delivery som defineret i kurset og har en generel idé om hvordan det fungerer
- [ ] Kan forklare hvad Agile er og hvorfor det blev skabt
- [ ] Forstår historien bag DevOps og forskellige måder at forstå det på
- [ ] Har en klar forståelse af forskellige definitioner af DevOps og kan formulere sin egen
- [ ] Forstår principperne bag Flow, Feedback og Continual Learning
- [ ] Kan argumentere for vigtigheden af en postmortem og ved hvordan man udfører den
- [ ] Kan nævne forskellige måder at opnå continuous deployment

## Mulige eksamensspørgsmål
- [ ] Hvad er DevOps? Giv din egen definition
- [ ] Hvad er The Three Ways og hvad betyder de i praksis?
- [ ] Hvad er forskellen på lead time og process time?
- [ ] Hvad er et knowledge silo og hvordan tackler I det i jeres gruppe?
- [ ] Hvad er CALMS og hvad står det for?
- [ ] Hvad er Andon Cord og hvad er idéen bag det?
- [ ] Hvad er de mest udbredte myter om DevOps?
- [ ] Hvornår er Waterfall-modellen et bedre valg end Agile?
- [ ] Hvad er pair programming og hvad siger forskningen om det?
- [ ] Hvad er Big Bang Deployment og hvorfor er det problematisk?

## Relevante uger
- Uge 1 (Introduktion til DevOps, What is DevOps?)
- Uge 5 (Docker, Continuous Delivery, The Simulation)
- Uge 6 (Docker Compose, DevOps Kultur, Agile, Continuous Delivery)
- Uge 8 (DevOps is People, Incident Response, Postmortem)
