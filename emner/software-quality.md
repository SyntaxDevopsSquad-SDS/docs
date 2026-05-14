# Software Quality

## Hvad er Software Quality?

Softwarekvalitet er ikke en subjektiv vurdering, men en teknisk standard. Det defineres ofte som mængden af egenskaber ved et produkt, der tilfredsstiller både erklærede og underforståede behov.

*   **ISO 25010 Standard**: Kvalitet opdeles i funktionel kvalitet (overholder kravene) og strukturel kvalitet (hvordan koden er bygget).
*   **Software vs. Code Quality**: Software er mere end bare kode; det omfatter også dokumentation og konfigurationsdata, der kræves for korrekt drift.

## DevOps og Value Stream

I DevOps er vi fokuserede på **Value Stream** — de aktiviteter, der tilsammen skaber værdi for kunden. Kvalitet understøtter dette ved at sikre, at vi ikke bare leverer hurtigt, men også stabilt.

**Developer Experience (DX):**
Selvom visse kvalitetsforbedringer ikke ses direkte af slutkunden, har de stor værdi for organisationen. Gode interne værktøjer og ren kode forbedrer DX, hvilket gør det muligt for teamet at arbejde hurtigere og med færre fejl.

## The "ilities" (Non-Functional Requirements)

Mindst 20% af et teams ressourcer bør reserveres til NFRs (Non-Functional Requirements). Disse kaldes ofte "the ilities":

*   **Maintainability**: Hvor let er koden at vedligeholde og læse?
*   **Reliability**: Kan vi stole på systemet under belastning?
*   **Scalability**: Kan systemet vokse i takt med brugertilvækst?
*   **Security**: Er applikationen beskyttet mod sårbarheder?

## Teknisk gæld (Technical Debt)

Teknisk gæld er en metafor for de fremtidige omkostninger (**Cost of Change - CoC**), der opstår, når man vælger hurtige og beskidte løsninger nu frem for en korrekt arkitektur.

*   **Code debt**: Rodet kode og "Code Smells" (fx duplikeret logik).
*   **Infrastructure debt**: Manuelle processer eller forældet CI/CD setup.
*   **Testing debt**: Manglende automatiseret testdækning.

> "Jo længere teknisk gæld får lov at eksistere, jo dyrere bliver den at betale tilbage i form af renter (tid brugt på fejlretning)."

## Kvalitetsstyring i WhoKnows

Vi bruger to typer analyse til at sikre kvaliteten i vores projekt:

### 1. Statisk Analyse (Linting)
Vi læser koden uden at køre den for at finde syntaxfejl og stilbrud.
*   **Værktøj**: `golangci-lint` og `hadolint` (til Dockerfiles).
*   **Fordel**: Det er ekstremt billigt og fanger fejl tidligt (Shift-Left).

### 2. Dynamisk Analyse
Vi verificerer koden, mens den kører.
*   **Værktøj**: `go test -race` og vores automatiserede smoke tests.
*   **Fordel**: Finder logiske fejl og runtime-problemer, som statisk analyse overser.

## Quality Gates og Pull Requests

Vi bruger **Quality Gates** i vores pipeline. Hvis koden ikke lever op til vores standarder (fx linter-fejl eller database-validering), må den ikke merges til `main`.

**Pull Requests (PRs) giver værdi ved:**
*   **Four-eyes principle**: Studier viser, at commits, der gennemgår review, har over dobbelt så lille chance for at introducere bugs.
*   **Vidensdeling**: Mulighed for læring og indsigt i nye features på tværs af teamet.

## Mulige eksamensspørgsmål
- [ ] Hvordan definerer I Software Quality i jeres projekt (ISO 25010)?
- [ ] Hvad er forskellen på Static og Dynamic Analysis hos jer?
- [ ] Forklar begrebet Teknisk Gæld og giv eksempler fra jeres forløb.
- [ ] Hvorfor kører I linting i CI fremfor kun lokalt i Git Hooks?