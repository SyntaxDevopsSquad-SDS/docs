# Uge 08 – DevOps is People & Incident Response

> 📅 Dato: 19. marts

## 🎯 Læringsmål
*(Kopiér de relevante punkter fra [læringsmål-master.md](../../læringsmål-master.md))*

- [ ] Har en klar forståelse af forskellige DevOps-definitioner
- [ ] Forstår principperne Flow, Feedback og Continuous Learning
- [ ] Kan argumentere for vigtigheden af postmortem og kender processen
- [ ] Kan nævne forskellige måder at opnå Continuous Deployment på

## 📌 Kernebegreber
| Begreb | Kort forklaring |
|--------|----------------|
| **DevOps** | En kultur og praksis der bryder siloen mellem Development og Operations, med fokus på samarbejde, automation og kontinuerlig forbedring |
| **The Three Ways** | DevOps Handbook's tre principper: Flow (optimere arbejdsgang), Feedback (hurtig feedback-loop), Continuous Learning (læring og eksperimentering) |
| **Flow** | Princippet om at optimere arbejdsgangen fra dev til prod ved at gøre arbejde synligt, begrænse WIP, reducere batch sizes og eliminere spild |
| **Feedback** | Princippet om at skabe hurtige feedback-loops, se problemer når de opstår, og løse dem ved at "swarm" sammen |
| **Continuous Learning** | Princippet om at institutionalisere daglig forbedring, dele lokale opdagelser globalt, og bygge en læringskultur |
| **Big Bang Deployment** | At deploye hele applikationen på én gang - en risikabel praksis der kan føre til store problemer |
| **Full CD** | Komplet Continuous Deployment hvor både kode OG konfiguration (docker-compose) deployes automatisk til serveren |
| **Quality Gates** | Kontrolpunkter i pipeline der sikrer at kun kode der lever op til kvalitetskrav går videre til næste fase |
| **Rollback** | Evnen til hurtigt at kunne vende tilbage til en tidligere, fungerende version af systemet |
| **Shadow Deployment** | Teknik hvor requests duplikeres til en shadow API/feature for at teste hvordan den håndterer traffic uden at påvirke brugere |
| **Feature Toggling** | Teknik til at deploye features til produktion der er usynlige for brugere, så man kan teste dem graduelt |
| **Reverse Proxy** | Server (fx Nginx) der modtager requests og videresender dem til backend-servere - bruges til load balancing, caching og sikkerhed |
| **Nginx** | Populær web server og reverse proxy der kan håndtere HTTP requests, serve static content og route traffic |
| **Location Block** | Nginx konfiguration der definerer hvordan forskellige URL paths skal håndteres |
| **MIME Types** | File type mappings (fx text/css for .css filer) der fortæller browseren hvordan content skal behandles |
| **Postmortem** | Dokument der analyserer en incident - hvad skete, hvorfor, hvordan blev det løst, og hvad kan forbedres |
| **Blameless Postmortem** | Postmortem der fokuserer på systemfejl frem for at bebrejde individer - essentielt for DevOps kultur |
| **Andon Cord** | Koncept fra Toyota om at stoppe produktionen når der opdages problemer - i DevOps: teamet "swarmer" for at løse problemer sammen |
| **Cycle Time** | Tid fra arbejde påbegyndes til det er færdigt og deployet - vigtig metric for flow |
| **PPT Framework** | People, Process, Technology - tre nøgler til organisatorisk succes der alle skal balanceres |
| **SPACE Framework** | Holistisk framework til at måle produktivitet: Satisfaction, Performance, Activity, Communication, Efficiency |
| **Information Silos** | Afdelinger der er isolerede og ikke deler data eller information |
| **Knowledge Silos** | Ekspertise der er isoleret og ikke deles på tværs af teams - en af de største hindringer i DevOps |
| **Psychological Safety** | Miljø hvor team members føler sig trygge ved at dele problemer, fejle og bede om hjælp uden frygt for straf |

## 📝 Egne noter
*Se [noter.md](./noter.md)*

## 🔗 Ressourcer
- Slides:
- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/08._Continuous_Deployment/02._devops.md
- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/08._Continuous_Deployment/03._devops_is_people.md
- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/08._Continuous_Deployment/04._incident_response_postmortem.md
- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/08._Continuous_Deployment/05._continuous_deployment.md
- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/08._Continuous_Deployment/06._reverse_proxies.md
- Opgaver: 
- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/01._Assignments/01._Introduction/02._After/problems_with_the_codebase.md?plain=1#L19

## 🧩 Se også i emner/
*(Hvilke tværgående emner dækker denne uge?)*
