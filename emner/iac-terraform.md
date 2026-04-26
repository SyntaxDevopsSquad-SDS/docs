# Infrastructure as Code & Terraform

> 🗓️ Relevant fra: Uge 12
> 🔗 Relaterede emner: [CI/CD](./ci-cd.md) · [Cloud & Azure](./cloud-azure.md) · [Docker](./docker.md)

---

## Hvad er Infrastructure as Code?

IaC betyder at man beskriver og styrer sin infrastruktur (servere, netværk, databaser, DNS osv.) via kode frem for manuelle processer eller GUI-klik.

**Problemer IaC løser:**

| Problem | Forklaring |
|---|---|
| **Snowflake servers** | Servere konfigureret manuelt over tid som er umulige at genskabe |
| **Configuration drift** | Dev/staging/prod glider fra hinanden fordi ændringer laves manuelt |
| **Ingen reproducerbarhed** | Svært at genskabe et miljø fra bunden efter nedbrud |
| **Ingen audit trail** | Ingen historik over hvad der er ændret i infrastrukturen og hvornår |
| **"Works on my machine"** | Forskellig infrastruktur på tværs af udviklere og miljøer |

---

## IaC vs. Configuration Management

Disse to forveksles ofte – men de løser forskellige problemer:

| | Infrastructure as Code | Configuration Management |
|---|---|---|
| **Spørgsmål** | Hvad skal *eksistere*? | Hvad skal *stå på* det der eksisterer? |
| **Eksempler** | Terraform, Pulumi, CloudFormation | Ansible, Chef, Puppet, SaltStack |
| **Typisk brug** | Opret en VM i Azure | Installer Nginx og kopier config til VM'en |
| **Timing** | Provisionering (oprette/nedlægge) | Konfigurering (installere/opdatere) |

> De bruges typisk **sammen**: Terraform opretter infrastrukturen → Ansible konfigurerer den.

---

## Imperativ vs. Deklarativ

| | Imperativ | Deklarativ |
|---|---|---|
| **Tankegang** | *Hvordan* – skridt for skridt | *Hvad* – ønsket slutresultat |
| **Eksempel** | `az vm create ...` → `az network create ...` | `resource "azurerm_vm" "web" { ... }` |
| **Ansvar** | Du styrer rækkefølge og logik | Toolet beregner hvad der mangler |
| **Tooling** | Shell-scripts, Azure CLI, AWS CLI | Terraform, CloudFormation |

Terraform er **deklarativt** – du beskriver ønsket tilstand, Terraform sammenligner med nuværende state og beregner diff.

---

## Terraform

### HCL – sproget bag Terraform

Terraform konfigureres i **HCL** (HashiCorp Configuration Language) via `.tf` filer. HCL er deklarativt og bygget op af **blokke**, **argumenter** og **expressions**:

```hcl
<BLOKTYPE> "<LABEL>" "<LABEL>" {
  # argumenter
  <IDENTIFIER> = <EXPRESSION>
}
```

Providers og modules findes via **Terraform Registry**: [registry.terraform.io](https://registry.terraform.io)

### Kernebegreber

| Begreb | Forklaring |
|---|---|
| `provider` | Plugin der taler med en platform (Azure, GitHub, AWS osv.) |
| `resource` | En konkret infrastrukturressource (VM, repo, DNS-record) |
| `variable` | Input til konfigurationen (fx tokens, navne) |
| `output` | Værdier der eksponeres efter `apply` (fx IP-adresser) |
| `state` | Terraform's "hukommelse" – hvad der faktisk eksisterer (`terraform.tfstate`) |
| `module` | Genanvendelig samling af ressourcer |

### Grundlæggende kommandoer

```bash
terraform init      # Download providers og initialiser projekt
terraform fmt       # Formatér .tf filer (retter indrykning m.m. – validerer ikke logik)
terraform validate  # Valider konfigurationssyntaks (kan køres uden init)
terraform plan      # Preview af ændringer (ingen udførelse)
terraform apply     # Udfør ændringer mod infrastrukturen
terraform refresh   # Synkroniser state med faktisk tilstand i skyen (ved drift udefra Terraform)
terraform destroy   # Nedlæg al provisioneret infrastruktur
```

### Workflow

```
.tf filer → terraform init → terraform plan → terraform apply → infrastruktur eksisterer
                                                     ↑
                                              sammenligner med
                                             terraform.tfstate
```

### Workspaces

Workspaces er isolerede state-miljøer – sammenlignelige med git branches, men **kun for state** (ingen merge, ingen divergerende kodebase).

```bash
terraform workspace list            # List alle workspaces
terraform workspace new <navn>      # Opret og skift til nyt workspace
terraform workspace select <navn>   # Skift workspace
terraform workspace delete <navn>   # Slet workspace
```

Typisk brug: `default`, `dev`, `staging`, `prod` – hver med sin egen state gemt i `terraform.tfstate.d/`.

### Eksempel – azurerm Provider

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
  features {}   # ← obligatorisk fra version 2.0+, mangler den fejler plan og apply
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "North Europe"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  resource_group_name = azurerm_resource_group.example.name      # <- reference
  location            = azurerm_resource_group.example.location  # <- reference
  address_space       = ["10.0.0.0/16"]
}
```

> Ressource-referencer (`azurerm_resource_group.example.name`) bruges til at bygge en **afhængighedsgraf** – Terraform opretter ressourcer i den rigtige rækkefølge automatisk.

### Eksempel – GitHub Provider

```hcl
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  token = var.github_token
}

resource "github_repository" "whoknows" {
  name        = "devops-syntaxsquad"
  description = "WhoKnows DevOps projekt"
  visibility  = "public"
}
```

### Begrænsninger og problemer

- **State-filen** er en single point of failure – mistes den mister Terraform overblikket
- **State-filen må IKKE committes til Git** – kan indeholde secrets, og merge-konflikter kan korruptere den
- **State locking** er nødvendigt i teams for at undgå konflikter
- **Out-of-band changes** – manuelle ændringer i konsollen opdages ikke automatisk (`terraform refresh` hjælper)
- **Ingen standardiseret løsning** på state-problemet i teams – løses typisk med remote backend:
  - Azure Storage Account (med state locking)
  - AWS S3 + DynamoDB
  - Terraform Cloud
  - Google Cloud Storage
- **Ikke alle ressourcer** understøttes af alle providers
- **Deklarativ logik** kan blive kompleks ved betingede ressourcer

---

## Mulige eksamensspørgsmål

- Hvad er forskellen på IaC og Configuration Management?
- Hvad menes der med deklarativ vs. imperativ tilgang?
- Hvad er Terraform state, og hvorfor er den vigtig?
- Hvilke problemer løser IaC i en DevOps-kontekst?
- Hvad sker der når du kører `terraform plan` vs. `terraform apply`?
- Hvordan relaterer IaC til reproducerbarhed og consistency i vores projekt?
- Hvad er et workspace i Terraform, og hvornår er det nyttigt?
- Hvorfor må state-filen ikke ligge i Git, og hvordan løser man det i et team?
- Hvad er forskellen på `terraform validate` og `terraform plan`?
- Hvad er `terraform refresh`, og hvornår har man brug for det?
