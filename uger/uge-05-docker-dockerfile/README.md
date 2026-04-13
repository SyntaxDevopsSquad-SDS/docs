# Uge 05 – Docker, Dockerfile, Build Tools & Virtualization
📅 Dato: 26. februar

---

## 🎯 Læringsmål

- [ ] Forstår forskellige niveauer af build tools — fra OS-niveau til sprogspecifikke
- [ ] Forstår forskellen på packaging og virtualization/containerization
- [ ] Forstår hvordan Docker adskiller sig fra sine forgængere og moderne alternativer
- [ ] Kan læse og forklare simple Dockerfiles for forskellige sprog (Python, Node.js)

---

## 📌 Kernebegreber

| Begreb | Kort forklaring |
|--------|-----------------|
| Image | Blueprint/opskrift for en container — en uforanderlig pakke med alt koden behøver for at køre |
| Container | En kørende instans af et image — isoleret proces på host-maskinen |
| Volume | Ekstern, persistent storage til containers — data overlever selv om containeren slettes |
| Docker Networking | Gør det muligt for containers at kommunikere med hinanden og med omverdenen via porte og netværk |
| Dockerfile | Tekstfil med instruktioner til at bygge et Docker image trin for trin |
| FROM | Angiver base image — udgangspunkt for alle øvrige instruktioner |
| WORKDIR | Sætter arbejdsmappe inde i containeren — efterfølgende kommandoer kører herfra |
| COPY | Kopierer filer fra host (build context) ind i image-laget |
| RUN | Eksekveres under build-fasen for at installere dependencies, opsætte miljø etc. — kan bruges flere gange |
| CMD | Standard-kommando der køres når containeren starter — kan overrides ved `docker run` |
| ENTRYPOINT | Definerer hoved-kommandoen ved opstart — kan kombineres med CMD for fleksibilitet |
| EXPOSE | Dokumenterer hvilken port containeren lytter på — publicerer den ikke faktisk |
| .dockerignore | Fil der ekskluderer filer/mapper fra build context — som .gitignore men for Docker |
| Docker Layers | Hvert Dockerfile-trin skaber et lag. Uændrede lag genbruges fra cache ved rebuild (optimering) |
| Alpine Linux | Meget letvægts Linux-distribution — bruges ofte som base image for at minimere image-størrelse |
| Non-root User | Best practice: opret en dedikeret systembruger i Dockerfile for privilege separation (sikkerhed) |
| Virtualization | Softwarebaseret repræsentation af hardware/OS — kræver separat OS per VM via hypervisor |
| Containerization | Deler host-kernelen — containers er letvægts-alternativer til VMs (ingen fuld OS per app) |
| Hypervisor | Software/firmware der skaber og kører virtuelle maskiner (VMM) |
| Namespaces | Linux-kernel feature der isolerer ressourcer (netværk, filsystem, processer) per container |
| cgroups | Linux Control Groups — begrænser CPU, memory og I/O-forbrug per container |
| Semantic Versioning | MAJOR.MINOR.PATCH — MAJOR ved brud på API, MINOR ved ny funktionalitet, PATCH ved bugfixes |
| Packaging | Distribution af kode som source, binary, container eller library |
| Artifact Repository | Registry til at gemme og distribuere pakker/images — fx DockerHub, GitHub Packages (GHCR) |
| Build Tools | Værktøjer til at bygge, teste og pakke kode — OS-niveau (apt, brew), sprogniveau (pip, npm, go) |

---

## 📝 Egne noter

Se [noter.md](./noter.md)

---

## 🔗 Ressourcer

- **Docker slides:** https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/05._Docker_and_Dockerfile/
- **Dockerfile reference:** https://docs.docker.com/reference/dockerfile/
- **Opgave – Begin Dockerization:** https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/01._Assignments/05._Docker/

---

## 🧩 Se også i emner/

- [Docker & Containerization](../../emner/docker.md)
- [CI/CD](../../emner/ci-cd.md)
