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
terraform fmt       # Formatér .tf filer
terraform validate  # Valider konfigurationssyntaks
terraform plan      # Preview af ændringer (ingen udførelse)
terraform apply     # Udfør ændringer mod infrastrukturen
terraform destroy   # Nedlæg al provisioneret infrastruktur
```

### Workflow

```
.tf filer → terraform init → terraform plan → terraform apply → infrastruktur eksisterer
                                                     ↑
                                              sammenligner med
                                             terraform.tfstate
```

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
- **State locking** er nødvendigt i teams for at undgå konflikter (løses med remote backend fx Terraform Cloud eller Azure Blob)
- **Out-of-band changes** – manuelle ændringer i konsollen opdages ikke automatisk
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
