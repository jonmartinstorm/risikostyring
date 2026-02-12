# Risikostyring – webapplikasjon (PoC)

En rask mockup / PoC for et risikostyringsverktøy bygget som monorepo med:

- **Backend:** Kotlin + Ktor + Exposed
- **Frontend:** Next.js
- **Database:** PostgreSQL
- **SQL-scripts:** ligger i `/sql`

Målet er å utforske flyt og datamodell for risikovurderinger, tiltak og aggregert risikobilde – ikke å levere et ferdig produkt.

## Repo-struktur

- `backend/` – Ktor API (inspirert av NAV backend-golden-path)
- `frontend/` – Next.js webapp
- `sql/` – schema/seed/eksperimenter for PostgreSQL

## Behovsvurdering og prinsipper (og ambisjon atm)

Formålet med en risikovurderingsapplikasjon er å støtte prioritering av tiltak og ressursbruk. 
Hvis systemet ikke hjelper oss å prioritere, så støtter det ikke styring.

For å få dette til må vurderingene være konsistente, etterprøvbare og sammenlignbare over tid og på tvers av organisatoriske nivåer.

### Felles skalaer og konsistens
- Felles **konsekvensskala**
- Felles **sannsynlighetsskala**
- Felles **aksept-/risikomatrise**

Standardiserte skalaer gjør det mulig å sammenligne vurderinger, aggregere risiko og etablere et samlet risikobilde (team → område → virksomhet). Uten konsistens blir tallene vanskelig å bruke i styring.

### Dokumentasjon av sannsynlighet
Når sannsynlighet vurderes, skal grunnlaget kunne dokumenteres, for eksempel gjennom beskrivelse av:
- trusler
- sårbarheter
- relevante forutsetninger

Vurderinger må være forståelige og etterprøvbare også i ettertid. Dette er avgjørende både for læring, revisjon og regulatoriske krav.

### Aggregere og rapportere
Systemet skal støtte:
- Oversikt per tema, team eller område
- Aggregert risikobilde på høyere nivå
- Tydelig “før og etter” ved gjennomføring av tiltak

Risikostyring handler ikke bare om å registrere risiko, men om å synliggjøre rest-risiko og effekten av tiltak.

### Tiltak og sporbarhet

Tiltak må være tydelig koblet til risiko og kunne følges opp over tid. Det innebærer:

- Klar kobling mellom risiko og tiltak
- Status og historikk
- Dokumentasjon av forventet og faktisk effekt

Uten sporbarhet reduseres risikostyring til dokumentasjon fremfor beslutningsstøtte.

### Tilgangsstyring
Kun autoriserte brukere skal kunne opprette og endre vurderinger. 
Tilgangsstyring må være tydelig, men ikke hindre effektiv bruk.

En risikovurderingsapplikasjon må balansere kontroll og brukervennlighet.

## Kjøring (lokalt)

> Dette er en PoC. Oppsett/kommandoer kan endres underveis.

### Backend
Gå til `backend/` og kjør:
- `./gradlew run`

Backend er oppdatert for:
- Java 25
- Ktor 3.4.0
- Kotlin 2.3.0

### Frontend
Gå til `frontend/` og kjør:
- `npm install`
- `npm run dev`

### Database / SQL
SQL-scripts ligger i `sql/` og inneholder basis for schema og seed.
Se `sql/README.md` for detaljer.

## TODO

- [ ] Skrive ferdig README og kjøre-instruksjoner
- [ ] Fullføre backend: risikoregister
- [ ] Fullføre frontend: risikoregister
- [ ] Fullføre backend: risikostyring (risikovurderinger + tiltak)
- [ ] Fullføre frontend: risikostyring (flyt, oversikt, detalj)

## Inspirasjon

- Backend: [Nais - Golden Path backend](https://github.com/navikt/backend-golden-path)
- Frontend: [Aksel - Golden Path frontend](https://aksel.nav.no/god-praksis/artikler/golden-path-frontend)
- [Fuck it, ship it - Stine Mølgaard og Jacob Bøtter](https://fuckitshipit.dk/)
- [Codin' Dirty - Carson Gross](https://htmx.org/essays/codin-dirty/)
- 差不多 (chà bù duō) - «godt nok» altså at noe ikke er perfekt, men tilstrekkelig.

## Erklæring om bruk av generativ KI

Under utviklingen av dette innholdet har forfatter(e) benyttet generativ KI – inkludert M365 Copilot og ChatGPT – til å omformulere og effektivisere tekst og kode. Alt innhold er deretter gjennomgått og en del redigert manuelt.
