# Uge 12 – Infrastructure as Code & Terraform
> 📅 Dato: 22. april

## 🎯 Læringsmål
- [ ] Forstår hvilke problemer Infrastructure as Code løser
- [ ] Kender definitionen på IaC og ved hvordan det adskiller sig fra Configuration Management
- [ ] Kan køre grundlæggende Terraform-kommandoer til at provisionere infrastruktur

## 📌 Kernebegreber
| Begreb | Kort forklaring |
|--------|----------------|
| Infrastructure as Code (IaC) | Infrastruktur beskrives og styres via kode frem for manuelle processer |
| Configuration Management | Konfigurering af eksisterende ressourcer (Ansible, Chef, Puppet) |
| Deklarativ tilgang | Man beskriver *hvad* slutresultatet skal være – toolet finder ud af *hvordan* |
| Imperativ tilgang | Man beskriver *hvordan* skridt for skridt (fx shell-scripts, CLI-kommandoer) |
| Terraform | Deklarativt IaC-tool fra HashiCorp til provisionering af infrastruktur |
| HCL | HashiCorp Configuration Language – sproget bag `.tf` filer |
| Provider | Plugin i Terraform der taler med en platform (Azure, GitHub, AWS osv.) |
| Terraform Registry | Centralt sted at finde providers, modules og libraries til Terraform |
| `required_providers` | HCL-blok i `terraform {}` der fastlåser hvilken provider og version der bruges |
| `features {}` | Obligatorisk tom blok i `provider "azurerm"` – kræves fra version 2.0+ |
| State | Terraform's "hukommelse" over hvad der faktisk eksisterer (`terraform.tfstate`) |
| Workspace | Isoleret state-miljø i Terraform – sammenligneligt med branches i Git |
| `terraform init` | Downloader providers og initialiserer projektet – altid første step |
| `terraform fmt` | Formaterer `.tf` filer til Terraform's canonical stil – retter indrykning m.m. |
| `terraform validate` | Tjekker intern konsistens og gyldighed af konfigurationen – rammer ikke API'en |
| `terraform plan` | Preview af hvad Terraform vil ændre – uden at udføre det |
| `terraform apply` | Udfører ændringerne mod infrastrukturen |
| `terraform refresh` | Synkroniserer state-filen med faktisk tilstand i skyen – bruges ved state drift |
| `terraform destroy` | River al provisioneret infrastruktur ned |
| Configuration drift | Når miljøer glider fra hinanden over tid pga. manuelle ændringer |

## 📝 Egne noter
*Se [noter.md](./noter.md)*

## 🔗 Ressourcer
- [Kea Learn Terraform (anbefalet: 1–3)](https://github.com/anderslatif/Kea_learn_terraform)
- [Terraform Docs](https://developer.hashicorp.com/terraform/docs)
- [Terraform GitHub Provider](https://registry.terraform.io/providers/integrations/github/latest/docs)
- [WAVE Accessibility Tool](https://wave.webaim.org/)
- [Lighthouse Overview](https://developer.chrome.com/docs/lighthouse/overview/)

## 🧩 Se også i emner/
- [emner/iac-terraform.md](../../emner/iac-terraform.md)
