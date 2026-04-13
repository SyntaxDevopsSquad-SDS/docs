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
| **Workflow** | YAML-fil i `.github/workflows/` der definerer automated proces - trigger, jobs og steps |
| **Runner** | Server der eksekverer workflows - GitHub-hosted (Ubuntu, Windows, macOS) eller self-hosted |
| **Job** | Samling af steps der kører på samme runner - kan køre parallelt eller sekventielt |
| **Step** | Individuel task i et job - kører kommandoer eller actions |
| **Action** | Genbrugelig kodeblok - fra Marketplace eller custom (fx `actions/checkout@v4`) |
| **Trigger** | Event der starter workflow - `push`, `pull_request`, `schedule`, `workflow_dispatch` |
| **Matrix Build** | Parallel eksekvering på tværs af versioner/OS - fx test på Go 1.21, 1.22, 1.23 |
| **GitHub Secrets** | Krypteret storage til sensitive data - API keys, tokens, passwords |
| **Cloud Computing** | On-demand adgang til compute resources over internet - pay-as-you-go model |
| **Virtual Machine (VM)** | Emuleret computer der kører på fysisk hardware - isoleret OS og resources |
| **Azure** | Microsofts cloud platform - compute, storage, networking services |
| **SSH (Secure Shell)** | Krypteret netværksprotokol til sikker remote server adgang |
| **SSH Key Pair** | Public key (deles med server) + Private key (holdes hemmelig) - asymmetrisk kryptering |
| **Public Key** | Krypterer data, kan deles frit - placeres i `~/.ssh/authorized_keys` på server |
| **Private Key** | Dekrypterer data, må ALDRIG deles - placeres i `~/.ssh/id_rsa` lokalt |
| **NSG (Network Security Group)** | Azure firewall - definerer inbound/outbound traffic rules med priorities |
| **systemd** | Linux service manager - starter services ved boot, genstarter ved crash |
| **systemd Service** | Background proces managed af systemd - defineret i `.service` fil |
| **Push-based Deployment** | CI/CD pusher kode til server via SSH/SCP - deployment controlleret fra CI |
| **Pull-based Deployment** | Server puller kode fra Git repository - deployment initieret fra server selv |
| **Git Pull Deployment** | Server kører `git pull` og genstarter service - kræver repository på server |
| **Docker Pull Deployment** | Server puller Docker image og kører container - ingen kodebase på server |
| **Static IP** | Fast IP-adresse der ikke ændres ved VM restart - kritisk for DNS og firewall rules |
| **Port Forwarding** | Åbne ports i firewall for at eksponere services til internet |

---

## 📝 Egne noter

Se [noter.md](./noter.md)

---

## 🔗 Ressourcer

**Pensum:**
- Introduction
- GitHub Actions
- GitHub Issues Workflow
- GitHub Secrets
- Azure
- More Cloud
- SSH
- Deployment Considerations

**Opgaver:**
- [Read about GitHub Actions](https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/03._GitHub_Actions/02._github_actions.md)
- [GitHub PR template](https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/03._GitHub_Actions/03._github_pr_template.md)
- [EK Azure Resources](https://github.com/anderslatif/EK_Azure)
- [Keep rewriting](https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/01._Assignments/03._GitHub_Actions/02._After/keep_rewriting.md)
- [Deploy](https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/01._Assignments/03._GitHub_Actions/02._After/deploy.md)

**Vores Implementation:**
- `.github/workflows/ci.yml` - [GitHub](https://github.com/SyntaxDevopsSquad-SDS/devops-syntaxsquad/blob/main/.github/workflows/ci.yml)
- `.github/workflows/cd.yml` - [GitHub](https://github.com/SyntaxDevopsSquad-SDS/devops-syntaxsquad/blob/main/.github/workflows/cd.yml)
- Azure VM Setup - [Deployment Notes](https://github.com/SyntaxDevopsSquad-SDS/devops-syntaxsquad/blob/main/server-config/deployment.md)


**Eksterne Links:**
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Azure Free Tier](https://azure.microsoft.com/en-us/pricing/free-services/)
- [SSH Key Guide](https://www.ssh.com/academy/ssh/keygen)
- [systemd Service Guide](https://www.freedesktop.org/software/systemd/man/systemd.service.html)

---

## 🧩 Se også i emner/

*(Hvilke tværgående emner dækker denne uge?)*

- **CI/CD** - GitHub Actions workflows
- **Cloud Infrastructure** - Azure VM management
- **Security** - SSH keys, port management
- **Deployment Strategies** - Push vs pull-based
