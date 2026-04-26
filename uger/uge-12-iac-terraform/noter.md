# Noter – Uge 12: Infrastructure as Code & Terraform

## Resumé
*(Skriv et kort resumé med egne ord — maks. 5 linjer)*

IaC løser problemet med manuelle, urepræducerbare infrastrukturopsætninger ved at behandle infrastruktur som kode der kan versionsstyres. Terraform er et deklarativt IaC-tool hvor man beskriver ønsket sluttilstand, og toolet beregner hvilke ændringer der skal til. Det adskiller sig fra Configuration Management tools som Ansible, der konfigurerer eksisterende ressourcer frem for at provisionere nye.

## Vigtige pointer
*(Hvad ville du fremhæve til eksamen?)*

- **IaC vs. CM**: IaC opretter infrastrukturen (hvad *eksisterer*), CM konfigurerer den (hvad den *indeholder*) – de bruges ofte sammen
- **Deklarativ vs. Imperativ**: Terraform er deklarativt – du siger hvad du vil have, ikke hvordan du gør det
- **State-filen** er kritisk i Terraform – den holder styr på hvad der er provisioneret. Mistes den, mister Terraform overblikket
- **State-filen må IKKE committes til Git** – den kan indeholde secrets, og merge-konflikter på den kan korruptere hele state
- **Configuration drift** er præcis det problem IaC løser – alle miljøer holdes ensartede fordi de bygges fra samme kode
- **Idempotens**: Terraform er idempotent – du kan køre `apply` flere gange og få samme resultat, fordi den sammenligner med state
- **`features {}`-blokken** er obligatorisk i `provider "azurerm"` fra version 2.0+ – mangler den, fejler både `plan` og `apply`
- `plan` før `apply` er god praksis – altid tjek hvad der vil ske

## Det fulde Terraform-workflow

terraform init        # Downloader providers, initialiserer projektet
terraform fmt         # Formaterer .tf filer til canonical stil
terraform validate    # Tjekker konfigurationen for fejl (rammer ikke API'en)
terraform plan        # Forhåndsvisning af hvad der vil ske
terraform apply       # Udfører ændringerne mod skyen
terraform refresh     # Synkroniserer state med faktisk tilstand (ved drift udefra)
terraform destroy     # River al infrastruktur ned


## Vigtige filer i et Terraform-projekt

| Fil/mappe | Formål |
|-----------|--------|
| `main.tf` | Hoved-konfigurationsfil – Terraform leder efter `.tf` filer her |
| `terraform.tfstate` | State-filen – Terraform's hukommelse over provisionerede ressourcer |
| `terraform.tfstate.backup` | Backup af forrige kendte state |
| `.terraform/` | Skjult mappe med downloaded provider-binaries |
| `.terraform/environment` | Gemmer navnet på det aktive workspace |
| `terraform.tfstate.d/` | Indeholder state-filer for ikke-default workspaces |

## Minimal Terraform-konfiguration (azurerm)

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "North Europe"
}
```

Ressourcer kan referere til hinanden på tværs af blokke:
```hcl
resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  resource_group_name = azurerm_resource_group.example.name      # <- reference
  location            = azurerm_resource_group.example.location  # <- reference
  address_space       = ["10.0.0.0/16"]
}
```
Terraform bruger disse referencer til at bygge en **afhængighedsgraf** – ressourcer oprettes i den rigtige rækkefølge automatisk.

## Workspaces

Workspaces er isolerede state-miljøer – tænk på dem som git branches, men kun for state (ingen divergerende kodebase, ingen merge).

```bash
terraform workspace list           # List alle workspaces
terraform workspace new <navn>     # Opret nyt workspace (skifter automatisk)
terraform workspace select <navn>  # Skift workspace
terraform workspace delete <navn>  # Slet workspace
```

Typisk brug: `default`, `dev`, `staging`, `prod` – hver med sin egen state.

## State-filens udfordringer i teams

State-filen skal altid være opdateret når `terraform apply` køres, ellers opstår **state drift**.

**Problemer i større teams:**
- **Locking** – kun én person bør kunne ændre state ad gangen
- **Version consistency** – alle skal arbejde mod den seneste state
- **CI/CD** – pipelines skal kunne gemme opdateret state efter apply

**Løsning:** Remote backend med lock-support, fx:
- Azure Storage Account (med state locking)
- AWS S3 + DynamoDB
- Terraform Cloud
- Google Cloud Storage

Der er ingen standardiseret løsning – det er et kendt kritikpunkt af Terraform.

## Forbindelser til WhoKnows-projektet
*(Hvordan relaterer dette sig til vores eget projekt?)*

- Vores infrastruktur (Azure VM, Docker Compose, GHCR) er i dag opsat manuelt – IaC ville gøre den reproducerbar
- Vi brugte Terraform GitHub Provider til at administrere repo-indstillinger som kode
- Et realistisk next step ville være at Terraformere vores Azure VM og netværksopsætning, så hele stacken kan genskabes fra bunden
- Vores CD-pipeline (GitHub Actions → GHCR → SSH deploy) er allerede et skridt mod automation, som IaC ville komplimentere
- State-filens problem er relevant for os: hvis vi var et større team skulle vi bruge Azure Storage Account som remote backend
