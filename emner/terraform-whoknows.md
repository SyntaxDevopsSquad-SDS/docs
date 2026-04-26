# Terraform – Cheat Sheet & WhoKnows Implementation

> 🔗 Relaterede emner: [IaC & Terraform](./iac-terraform.md) · [Cloud & Azure](./cloud-azure.md) · [CI/CD](./ci-cd.md)

---

## Hurtig kommando-reference

```bash
terraform init              # Download providers, initialiser projekt — altid første step
terraform fmt               # Formatér .tf filer — retter indrykning, validerer ikke logik
terraform validate          # Tjek intern konsistens — rammer ikke API'en
terraform plan              # Preview af ændringer — ingen udførelse
terraform apply             # Udfør ændringer mod infrastrukturen
terraform apply -auto-approve  # Spring manuel godkendelse over (bruges i CI/CD)
terraform refresh           # Synkronisér state med faktisk tilstand i skyen
terraform destroy           # River AL infrastruktur ned — brug med omtanke
terraform workspace list    # List workspaces — aktiv markeres med *
terraform workspace new <navn>    # Opret og skift workspace
terraform workspace select <navn> # Skift workspace
```

---

## Minimal HCL-struktur

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
  features {}   # Obligatorisk fra version 2.0+ — mangler den fejler plan og apply
}

resource "azurerm_resource_group" "whoknows" {
  name     = "whoknows-rg"
  location = "North Europe"
}
```

Ressourcer refererer til hinanden via `<type>.<navn>.<felt>`:
```hcl
location = azurerm_resource_group.whoknows.location
```
Terraform bygger automatisk en afhængighedsgraf og opretter ressourcer i rigtig rækkefølge.

---

## State-filen — huskeliste

| Regel | Hvorfor |
|---|---|
| Commit **aldrig** `terraform.tfstate` til Git | Indeholder secrets + merge-konflikter korrupterer den |
| Tilføj `*.tfstate*` til `.gitignore` | Forhindrer utilsigtet commit |
| Brug remote backend i teams | Azure Storage Account, Terraform Cloud eller AWS S3 + DynamoDB |
| `terraform refresh` ved manuel ændring i Azure Portal | Synkroniserer state med virkeligheden |

---

## WhoKnows – implementeringsplan

> ⚠️ Lav PostgreSQL-migrationen FØR du Terraformer.
> Terraform infrastruktur der ikke er stabil endnu skal omskrives — gør det én gang rigtigt.

### Rækkefølge
```
SQLite → PostgreSQL migration → Terraform
```

### Hvad der kan Terraformes i WhoKnows

| Ressource | Terraform-type | Status |
|---|---|---|
| Resource Group | `azurerm_resource_group` | Kan Terraformes nu |
| Azure VM | `azurerm_linux_virtual_machine` | Kan Terraformes efter PostgreSQL |
| Virtual Network | `azurerm_virtual_network` | Kan Terraformes nu |
| PostgreSQL Server | `azurerm_postgresql_flexible_server` | Terraform efter migration |
| GitHub repo-indstillinger | `github_repository` | Allerede gjort |

### Eksempel – Azure VM med ressourcegruppe

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

resource "azurerm_resource_group" "whoknows" {
  name     = "whoknows-rg"
  location = "North Europe"
}

resource "azurerm_virtual_network" "whoknows" {
  name                = "whoknows-vnet"
  resource_group_name = azurerm_resource_group.whoknows.name
  location            = azurerm_resource_group.whoknows.location
  address_space       = ["10.0.0.0/16"]
}
```

### Eksempel – PostgreSQL Flexible Server (efter migration)

```hcl
resource "azurerm_postgresql_flexible_server" "whoknows" {
  name                   = "whoknows-db"
  resource_group_name    = azurerm_resource_group.whoknows.name
  location               = azurerm_resource_group.whoknows.location
  administrator_login    = var.db_admin
  administrator_password = var.db_password
  sku_name               = "B_Standard_B1ms"
  version                = "15"
}
```

> Brug altid `variable {}` til credentials — skriv aldrig passwords direkte i `.tf` filer.

### Variables og .tfvars

```hcl
# variables.tf
variable "db_admin" {
  description = "PostgreSQL admin brugernavn"
  type        = string
}

variable "db_password" {
  description = "PostgreSQL admin password"
  type        = string
  sensitive   = true
}
```

```hcl
# terraform.tfvars — tilføj til .gitignore!
db_admin    = "whoknows_admin"
db_password = "dit-password-her"
```

### Terraform i CI/CD (GitHub Actions)

```yaml
- name: Terraform init
  run: terraform init

- name: Terraform plan
  run: terraform plan

- name: Terraform apply
  run: terraform apply -auto-approve
```

> State-filen skal gemmes i remote backend når Terraform kører i CI/CD — en runner har ingen lokal state mellem kørsler.

---

## Næste skridt for WhoKnows

- [ ] Lav PostgreSQL-migrationen
- [ ] Opret `infrastructure/` mappe i repoet med `main.tf`, `variables.tf`, `outputs.tf`
- [ ] Terraform resource group + virtual network
- [ ] Terraform PostgreSQL Flexible Server
- [ ] Terraform Azure VM
- [ ] Sæt Azure Storage Account op som remote backend
- [ ] Tilføj Terraform-steps til GitHub Actions pipeline
