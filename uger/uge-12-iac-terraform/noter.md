# Noter – Uge 12: Infrastructure as Code & Terraform

## Resumé

*(Skriv et kort resumé med egne ord — maks. 5 linjer)*

IaC løser problemet med manuelle, urepræducerbare infrastrukturopsætninger ved at behandle infrastruktur som kode der kan versionsstyres. Terraform er et deklarativt IaC-tool hvor man beskriver ønsket sluttilstand, og toolet beregner hvilke ændringer der skal til. Det adskiller sig fra Configuration Management tools som Ansible, der konfigurerer eksisterende ressourcer frem for at provisionere nye.

## Vigtige pointer

*(Hvad ville du fremhæve til eksamen?)*

- **IaC vs. CM**: IaC opretter infrastrukturen (hvad *eksisterer*), CM konfigurerer den (hvad den *indeholder*) – de bruges ofte sammen
- **Deklarativ vs. Imperativ**: Terraform er deklarativt – du siger hvad du vil have, ikke hvordan du gør det
- **State-filen** er kritisk i Terraform – den holder styr på hvad der er provisioneret. Mistes den, mister Terraform overblikket
- **Configuration drift** er præcis det problem IaC løser – alle miljøer holdes ensartede fordi de bygges fra samme kode
- `plan` før `apply` er god praksis – altid tjek hvad der vil ske

## Forbindelser til WhoKnows-projektet

*(Hvordan relaterer dette sig til vores eget projekt?)*

- Vores infrastruktur (Azure VM, Docker Compose, GHCR) er i dag opsat manuelt – IaC ville gøre den reproducerbar
- Vi brugte Terraform GitHub Provider til at administrere repo-indstillinger som kode
- Et realistisk next step ville være at Terraformere vores Azure VM og netværksopsætning, så hele stacken kan genskabes fra bunden
- Vores CD-pipeline (GitHub Actions → GHCR → SSH deploy) er allerede et skridt mod automation, som IaC ville komplimentere
