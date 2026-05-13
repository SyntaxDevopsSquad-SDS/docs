# Uge 02 – Conventions, OpenAPI & DotEnv

📅 **Dato:** 5. februar

---

## 🎯 Læringsmål

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
| **Conventional Commits** | Standard format for commit messages: `<type>: <description>` (fx `feat:`, `fix:`, `docs:`) - gør Git history læsbar og muliggør automatisk changelog generation |
| **.gitignore** | Fil der specificerer hvilke filer Git skal ignorere - kritisk for at undgå at committe secrets (`.env`), binaries (`*.db`), og dependencies (`node_modules/`) |
| **Environment Variables** | Konfiguration der varierer mellem miljøer (dev/prod) - holdes ude af koden for security og flexibility. Tilgås via `os.Getenv()` i Go |
| **.env File** | Fil der indeholder environment variables lokalt (fx `SECRET_KEY=abc123`) - **ALDRIG** committed til Git |
| **.env.example** | Template der viser struktur af .env uden rigtige værdier - safe to commit, bruges til onboarding |
| **OpenAPI Specification** | Maskinlæsbar API dokumentation (tidligere Swagger) - YAML/JSON der beskriver endpoints, request/response formats, og data models |
| **Swagger UI** | Interaktiv API dokumentation genereret fra OpenAPI spec - lader brugere teste endpoints direkte i browseren uden Postman |
| **Design-First** | Approach hvor OpenAPI spec skrives først, derefter implementeres API - god til team alignment og kontraktdefinition før coding |
| **Code-First** | Approach hvor kode skrives først, spec genereres automatisk fra annotations - hurtigere at komme igang, god til prototyper |
| **Monorepo** | Alle projekter i ét Git repository - fordele: atomic commits på tværs af services, shared tooling (CI/CD), nemmere refactoring |
| **Polyrepo** | Separate repositories per service - fordele: independent deployment cycles, granular permissions, separate CI/CD |
| **Naming Conventions** | Standarder for at navngive filer, functions, variables - **Go**: camelCase, **SQL**: snake_case, **Env vars**: ALL_CAPS_SNAKE_CASE |
| **Exported vs Unexported (Go)** | **Uppercase** første bogstav = public/exported (kan importeres fra andre packages). **Lowercase** = private/unexported (kun synlig i samme package) |
| **PascalCase** | `FirstLetterUppercase` - bruges til exported Go types og struct names |
| **camelCase** | `firstLetterLowercase` - bruges til unexported Go functions/variables |
| **snake_case** | `all_lowercase_with_underscores` - bruges til SQL table/column names og filnavne |
| **kebab-case** | `all-lowercase-with-hyphens` - bruges til branch names (`feature/user-auth`) og URLs |
| **godotenv** | Go package til at loade .env filer - loader environment variables fra fil ind i `os.Getenv()`. Import: `github.com/joho/godotenv` |
| **Twelve-Factor App** | Metodologi for cloud-native apps - **Principle #3 "Config"**: Store config i environment (ikke hardcoded), strict separation fra code |

---

## 📝 Egne noter

Se [noter.md](./noter.md)

---

## 🔗 Ressourcer

**Vores Implementation:**
- [`.gitignore`](https://github.com/SyntaxDevopsSquad-SDS/devops-syntaxsquad/blob/main/.gitignore) - Secrets, binaries og dependencies ignoreret
- [`README.md`](https://github.com/SyntaxDevopsSquad-SDS/devops-syntaxsquad/blob/main/README.md) - Conventional Commits i brug

**Eksterne Ressourcer:**
- [Conventional Commits](https://www.conventionalcommits.org/)
- [OpenAPI Specification](https://swagger.io/specification/)
- [The Twelve-Factor App](https://12factor.net/config)

---

## 🧩 Se også i emner/

