# Deploying Infrastructure / Configuration Management

## Hvad er det?

Configuration Management handler om at definere og styre infrastruktur som kode — i stedet for at konfigurere servere manuelt via SSH og terminalen.

Målet er at din infrastruktur er reproducerbar, versioneret og automatiserbar. Hvis din server brænder ned, skal du kunne genskabe den præcis som den var — med én kommando.

## Problemet med manuel konfiguration

Forestil dig du har sat din server op manuelt:
- Installeret nginx
- Konfigureret firewall-regler
- Oprettet en `/opt/whoknows` mappe
- Tilføjet en `.env` fil med secrets

Hvad sker der hvis serveren crasher? Du skal huske alle trin i den rigtige rækkefølge. Det er fejlbehæftet og tidskrævende — og det er præcis det problem Configuration Management løser.

## Infrastructure as Code (IaC)

IaC betyder at din infrastruktur beskrives i filer (kode) der kan versioneres i Git, deles med teamet og køres automatisk.

**Fordele:**
- Reproducerbar — samme resultat hver gang
- Versioneret — du kan se hvad der er ændret og hvornår
- Automatiserbar — kan køres i CI/CD pipeline
- Dokumentation — koden er dokumentationen

## Centrale værktøjer

**Terraform** — deklarativt IaC-værktøj til cloud-infrastruktur. Du beskriver hvad du vil have (en VM, et netværk, en database) og Terraform sørger for at det eksisterer. Bruges til at provisione infrastruktur.

**Ansible** — imperativt konfigurationsværktøj. Du beskriver hvilke trin der skal køres på en server (installer nginx, kopier config-fil, start service). Bruges til at konfigurere infrastruktur efter den er oprettet.

**Docker Compose** — det vi allerede bruger. En form for IaC specifikt til container-infrastruktur.

## Terraform — grundbegreber

```hcl
# Eksempel: Opret en Azure VM
resource "azurerm_virtual_machine" "app" {
  name     = "whoknows-vm"
  location = "West Europe"
  size     = "Standard_B1s"
}
```

Terraform arbejder med tre faser:
1. `terraform plan` — vis hvad der vil ske (dry run)
2. `terraform apply` — udfør ændringerne
3. `terraform destroy` — slet alt

**State-fil:** Terraform gemmer en state-fil der holder styr på hvad der allerede eksisterer. Vigtigt at gemme denne sikkert (fx i Azure Storage).

## Sammenhæng til projektet

I WhoKnows-projektet har vi sat vores Azure VM op manuelt. Et næste skridt ville være at beskrive VM'en, netværket og storage i Terraform — så hele infrastrukturen kan genskabes automatisk.

## Relevante kommandoer

```bash
terraform init      # Initialiser Terraform i mappen
terraform plan      # Se hvad der vil ske
terraform apply     # Udfør ændringer
terraform destroy   # Slet infrastruktur
```
