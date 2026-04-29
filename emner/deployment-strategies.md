# Deployment Strategies

## Problemet

Når vi deployer ny kode til produktion opstår der et grundlæggende problem: den gamle version skal stoppes og den nye startes. I det interval er applikationen nede — og det mærker brugerne.

Vi oplevede dette direkte i WhoKnows-projektet, da vores 502-fejl opstod fordi nginx havde cachet den gamle container-IP efter et deploy.

Spørgsmålet er: **hvordan deployer vi uden at brugerne mærker det?**

## De vigtigste deployment strategier

### Recreate (det vi gør nu)
Stop den gamle version, start den nye. Simpelt men giver downtime.

```
v1 ████████░░░░░░░░
v2 ░░░░░░░░████████
         ↑ nedbrud her
```

**Fordele:** Simpelt, ingen ressource-overlap
**Ulemper:** Downtime, ingen rollback under deploy

### Rolling Update
Udskift gradvist én instans ad gangen. Nye og gamle versioner kører parallelt i en kort periode.

```
v1 ████████░░░░░░░░
v1 ████░░░░░░░░░░░░
v2 ░░░░████████████
```

**Fordele:** Ingen downtime
**Ulemper:** To versioner kører samtidig — kræver at de er kompatible

### Blue/Green Deployment
Kør to identiske miljøer (blue = aktiv, green = ny). Skift trafik over når green er klar.

```
Blue (v1):  ████████████████  ← trafik her
Green (v2): ░░░░░░░░████████  ← trafik skifter hertil
```

**Fordele:** Øjeblikkelig rollback (skift trafik tilbage), nul downtime
**Ulemper:** Kræver dobbelt infrastruktur, dyrere

### Canary Release
Send en lille andel af trafik (fx 5%) til den nye version. Øg gradvist hvis alt ser godt ud.

```
v1: ████████████████  95% af trafik
v2: █░░░░░░░░░░░░░░░   5% af trafik
```

**Fordele:** Lav risiko, test med rigtige brugere
**Ulemper:** Kompleks at implementere, kræver god monitoring

## Hvad passer til WhoKnows?

Vores nuværende setup bruger **Recreate** — docker compose down + up. Det giver kort downtime ved hvert deploy.

Et realistisk næste skridt ville være **Blue/Green** da vi har en nginx-proxy der nemt kan skifte trafik mellem to container-sæt. Det ville eliminere downtime og give nem rollback.

## Overvejelser til eksamen

Anders forventer at I kan argumentere for jeres valg. Tænk over:
- Hvad er vores tolerance for downtime?
- Har vi ressourcer til to parallelle miljøer?
- Hvor kritisk er det at kunne rulle tilbage hurtigt?
- Kræver vores database-migreringer særlige hensyn?
