# Uge 03 – GitHub Actions, Azure & Deploy

📅 **Dato:** 12. februar

---

## 🎯 Læringsmål

- [ ] Understands the terminology surrounding GitHub Actions such as workflows, runners, jobs, steps, and actions
- [ ] Can create a basic GitHub Action workflow that is triggered by a push and pull request
- [ ] Understands basic cloud concepts
- [ ] Can create a virtual machine in Azure and SSH into it. Can open ports and set the IP address to static
- [ ] Understands the difference between public and private ssh keys
- [ ] Can suggest various deployment strategies and knows the pros and cons of each
- [ ] Understands the difference between pull-based and push-based deployment

---

## 📌 Kernebegreber

| Begreb | Kort forklaring |
|--------|-----------------|
| **GitHub Actions** | CI/CD platform integreret i GitHub - automatiserer workflows som build, test og deployment |
| **Workflow** | YAML-fil i `.github/workflows/` der definerer automatiseret proces med triggers, jobs og steps |
| **Runner** | Server der eksekverer workflows - enten GitHub-hosted (Ubuntu/Windows/macOS) eller self-hosted |
| **Job** | Samling af steps der kører på samme runner - jobs kan køre parallelt eller sekventielt |
| **Step** | Individuel task i et job - kører enten kommandoer eller actions |
| **Action** | Genbrugelig kodeblok fra Marketplace eller custom (fx `actions/checkout@v4`) |
| **Trigger** | Event der starter workflow - `push`, `pull_request`, `schedule`, `workflow_dispatch` |
| **GitHub Secrets** | Krypteret storage til sensitive data - API keys, tokens, passwords (aldrig hardcoded) |
| **Cloud Computing** | On-demand adgang til compute resources over internet - pay-as-you-go model (IaaS, PaaS, SaaS) |
| **Virtual Machine** | Emuleret computer på fysisk hardware - isoleret OS og resources, kan køre hvilket som helst OS |
| **Azure** | Microsofts cloud platform - compute (VMs), storage, networking, databases |
| **SSH (Secure Shell)** | Krypteret protokol til sikker remote server adgang - bruger key pair authentication |
| **SSH Key Pair** | **Public key** (deles med server) + **Private key** (holdes hemmelig) - asymmetrisk kryptering |
| **Public Key** | Krypterer challenges, placeres i `~/.ssh/authorized_keys` på server - kan deles frit |
| **Private Key** | Dekrypterer challenges, placeres i `~/.ssh/id_rsa` lokalt - må **ALDRIG** deles |
| **NSG (Network Security Group)** | Azure's firewall der kontrollerer netværkstrafik til/fra VM. Består af security rules med **priorities** (lavere nummer = højere prioritet, range 100-4096). Hver rule specificerer: **source** (hvilke IP'er må komme ind), **destination port** (fx 22 for SSH, 8080 for HTTP), **protocol** (TCP/UDP), og **action** (Allow/Deny). Regler evalueres i priority-rækkefølge - første match vinder. Eksempel: Priority 900 tillader SSH (port 22), priority 1001 tillader HTTP (port 8080) |
| **Static IP** | Fast IP-adresse der ikke ændres ved VM restart - kritisk for DNS og firewall rules |
| **Push-based Deployment** | CI/CD pusher kode til server via SSH - deployment controlleret fra CI pipeline |
| **Pull-based Deployment** | Server puller kode fra Git repository - deployment initieret fra server selv |
| **Docker Pull Deployment** | Server puller Docker image og kører container - ingen kodebase på server (best practice) |

---

## 📝 Egne noter

Se [noter.md](./noter.md)

---

## 🔗 Ressourcer

**Kursusmateriale:**
- [GitHub Actions Introduction](https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/03._Github_Actions_Cloud_Azure_Deploy/02._github_actions.md)
- [Azure & Cloud Concepts](https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/03._Github_Actions_Cloud_Azure_Deploy/05._azure.md)
- [SSH Deep Dive](https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/03._Github_Actions_Cloud_Azure_Deploy/07._ssh.md)
- [Deployment Strategies](https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/03._Github_Actions_Cloud_Azure_Deploy/08._deployment_considerations.md)

**Vores Implementation:**
- [CI Workflow](https://github.com/SyntaxDevopsSquad-SDS/devops-syntaxsquad/blob/main/.github/workflows/ci.yml) - Build, test og lint
- [CD Workflow](https://github.com/SyntaxDevopsSquad-SDS/devops-syntaxsquad/blob/main/.github/workflows/cd.yml) - Deployment til Azure VM

**Eksterne Ressourcer:**
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Azure for Students](https://azure.microsoft.com/en-us/free/students/)

---

## 🧩 Se også i emner/


