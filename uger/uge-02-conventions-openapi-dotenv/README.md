# Uge 02 – Conventions, OpenAPI & DotEnv

> 📅 **Dato:** 5. februar

---

## 🎯 Læringsmål

*(Kopiér de relevante punkter fra læringsmål-master.md)*

- [ ] Knows which type of files not to push into version control and why
- [ ] Can and will create proper commit messages
- [ ] Knows proper casing and naming conventions
- [ ] Understands the OpenAPI specification, why it exists and knows different ways to work it
- [ ] Can generate an OpenAPI specification from the group's application
- [ ] Can create a .env file and import/use the environment variables in the group's chosen programming language

---

## 📌 Kernebegreber

| Begreb | Kort forklaring |
|--------|-----------------|
| **Conventional Commits** | Standard format for commit messages: `<type>: <description>` - gør Git history læsbar og muliggør automatisk changelog generation |
| **.gitignore** | Fil der specificerer hvilke filer Git skal ignorere - kritisk for at undgå at committe secrets, binaries og dependencies |
| **Environment Variables** | Konfiguration der varierer mellem miljøer (dev/prod) - holdes ude af koden for security og flexibility |
| **.env File** | Fil der indeholder environment variables lokalt - ALDRIG committed til Git |
| **.env.example** | Template der viser struktur af .env uden rigtige værdier - safe to commit |
| **OpenAPI Specification** | Maskinlæsbar API dokumentation (tidligere Swagger) - YAML/JSON der beskriver endpoints, request/response formats |
| **Swagger UI** | Interaktiv API dokumentation genereret fra OpenAPI spec - lader brugere teste endpoints direkte i browseren |
| **Design-First** | Approach hvor OpenAPI spec skrives først, derefter implementeres API - god til team alignment før coding |
| **Code-First** | Approach hvor kode skrives først, spec genereres automatisk - hurtigere at komme igang |
| **Monorepo** | Alle projekter i ét Git repository - fordel: atomic commits, shared tooling, easy refactoring |
| **Polyrepo** | Separate repositories per service - fordel: independent deployment, granular permissions |
| **Naming Conventions** | Standarder for at navngive filer, functions, variables - Go: camelCase, SQL: snake_case |
| **Exported vs Unexported (Go)** | Uppercase = public (kan importeres), lowercase = private (kun synlig i samme package) |
| **PascalCase** | FirstLetterUppercase - bruges til exported Go types |
| **camelCase** | firstLetterLowercase - bruges til unexported Go functions/variables |
| **snake_case** | all_lowercase_with_underscores - bruges til database columns, .env variables (ALL_CAPS) |
| **kebab-case** | all-lowercase-with-hyphens - bruges til branch names, URLs |
| **godotenv** | Go package til at loade .env filer - loader environment variables fra fil ind i `os.Getenv()` |
| **Twelve-Factor App** | Metodologi for cloud-native apps - #3 "Config": Store config in environment, strict separation fra code |

---

## 📝 Egne noter

Se [noter.md](./noter.md)

---

## 🔗 Ressourcer

**Slides:** *(tilføj link fra undervisernes repo)*
**Topics**

- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/02._Conventions_OpenAPI_DotEnv/02._conventions.md
- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/02._Conventions_OpenAPI_DotEnv/03._openapi.md
- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/02._Conventions_OpenAPI_DotEnv/04._monolith_monorepo_multirepo.md
- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/02._Slides/02._Conventions_OpenAPI_DotEnv/05._environment_variables.md
- 
**Before class Assignments**
- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/01._Assignments/02._Conventions_OpenAPI_DotEnv/01._Before/learn_branching.md
- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/01._Assignments/02._Conventions_OpenAPI_DotEnv/01._Before/git_advanced.md
- **Get aquainted with how to setup SQLite and create all the WhoKnows queries in Go and Ruby**
- https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/01._Assignments/02._Conventions_OpenAPI_DotEnv/01._Before/go_and_ruby_sqlite_setup.md
- 
**After class**
  - https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/01._Assignments/02._Conventions_OpenAPI_DotEnv/02._After/commence_the_rewrite.md
  - https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/01._Assignments/02._Conventions_OpenAPI_DotEnv/02._After/generate_openapi_specification.md
  - https://github.com/who-knows-inc/EK_DAT_DevOps_2026_Spring/blob/main/00._Course_Material/01._Assignments/02._Conventions_OpenAPI_DotEnv/02._After/generate_openapi_spec_in_postman.md


**Vores Implementation:**
- `.gitignore` - [GitHub](https://github.com/SyntaxDevopsSquad-SDS/devops-syntaxsquad/blob/main/.gitignore)
- `.env.example` - [GitHub](https://github.com/SyntaxDevopsSquad-SDS/devops-syntaxsquad/blob/main/implementations/go/backend/.env_example)
- `README.md` Conventional Commits - [GitHub](https://github.com/SyntaxDevopsSquad-SDS/devops-syntaxsquad/blob/main/README.md)
- Monorepo Structure - [Project Root](https://github.com/SyntaxDevopsSquad-SDS/devops-syntaxsquad)

**Eksterne Links:**
- [Conventional Commits Standard](https://www.conventionalcommits.org/)
- [OpenAPI Specification](https://swagger.io/specification/)
- [Swagger Editor](https://editor.swagger.io/) - Online OpenAPI editor
- [The Twelve-Factor App](https://12factor.net/config) - Config principles
- [Go Effective Naming](https://go.dev/doc/effective_go#names) - Official Go docs

---

## 🧩 Se også i emner/

*(Hvilke tværgående emner dækker denne uge?)*
