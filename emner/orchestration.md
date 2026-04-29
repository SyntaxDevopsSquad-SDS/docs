# Orchestration

## Hvad er orchestration?

Orchestration er automatisk styring af mange containers på tværs af flere maskiner. Når din applikation vokser ud over én server og én container, har du brug for noget der kan holde styr på det hele.

En orchestrator sørger for at:
- De rigtige containers kører på de rigtige maskiner
- Containers genstartes hvis de crasher
- Trafik fordeles mellem instanser
- Ny kode deployes uden downtime
- Ressourcer (CPU/RAM) udnyttes effektivt

## Hvorfor har vi brug for det?

Med Docker Compose på én server:
- Én server = single point of failure
- Manuel skalering — du skal selv bestemme hvor mange containers
- Ingen automatisk failover hvis serveren går ned

Med orchestration:
- Spredt over mange maskiner — én server kan gå ned uden nedbrud
- Automatisk skalering baseret på load
- Automatisk failover — containers genstartes på en anden maskine

## Docker Swarm vs Kubernetes

**Docker Swarm** er Dockers eget orchestration-system. Det er simpelt at sætte op da det bygger direkte på Docker Compose-syntaks. Det er dog ved at blive deprecated og erstattet af Kubernetes.

```bash
docker swarm init
docker service create --replicas 3 -p 80:80 nginx
```

**Kubernetes (K8s)** er industri-standarden. Det er mere komplekst men langt mere kraftfuldt og udbredt. Bruges af næsten alle store cloud-platforme (AKS på Azure, EKS på AWS, GKE på Google Cloud).

## Centrale begreber i orchestration

**Cluster** — en gruppe maskiner der arbejder sammen som ét system.

**Node** — en enkelt maskine i clusteret. Der er to typer: master (styrer) og worker (kører containers).

**Service** — en abstraktion der siger "kør X antal instanser af denne container og hold dem kørende".

**Load Balancer** — fordeler indkommende trafik mellem de kørende instanser.

**Health Check** — orchestratoren tjekker løbende om containers er raske. Hvis ikke, genstarter den dem.

## Sammenhæng til projektet

Vores WhoKnows-setup med Docker Compose på én VM er startpunktet. Orchestration er næste skridt — men det er ikke forventet at vi implementerer det i projektet. Det er dog vigtigt at forstå konceptet og kunne argumentere for hvornår det giver mening.
