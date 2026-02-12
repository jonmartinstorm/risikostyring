# Risikostyring – webapplikasjon (PoC)

En rask mockup / PoC for et risikostyringsverktøy bygget som monorepo med:

- **Backend:** Kotlin + Ktor + Exposed
- **Frontend:** Next.js
- **Database:** PostgreSQL
- **SQL-scripts:** ligger i `/sql`

Målet er å utforske flyt og datamodell for risikovurderinger, tiltak og aggregert risikobilde – ikke å levere et ferdig produkt.

Risikostyring skal støtte prioritering av tiltak og ressursbruk.
Hvis systemet ikke hjelper oss å prioritere, så støtter det ikke styring.

## Repo-struktur

- `backend/` – Ktor API (inspirert av NAV backend-golden-path)
- `frontend/` – Next.js webapp
- `sql/` – schema/seed/eksperimenter for PostgreSQL

## Behovsvurdering og prinsipper

Vi trenger høy og jevn kvalitet i vurderingene. Det betyr:

### Felles skalaer og konsistens
- Felles **konsekvensskala**
- Felles **sannsynlighetsskala**
- Felles **aksept-/risikomatrise** (hva er grønn/gul/rød)

Dette gjør at vurderinger kan sammenlignes og aggregeres (team → område → funksjon).

### Dokumentasjon av sannsynlighet
For sikkerhetsrisikoer skal sannsynlighet kunne begrunnes med:
- trusselvurdering
- sårbarhetsvurdering

Dette er et minimumskrav: når man setter sannsynlighet skal det være mulig å dokumentere grunnlaget.

### Aggregere og rapportere
Systemet skal støtte:
- oversikter per tema/team/område
- aggregert risikobilde på høyere nivå
- “før og etter” (tiltak som endrer risikonivå)

### Tilgangsstyring
Tilgangsstyring er viktig: kun deltakere (eller definerte roller) skal kunne endre vurderinger.
(Autentisering/autorisasjon i PoC kan være enkel først, men må ha et tydelig mønster.)

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

- Backend: https://github.com/navikt/backend-golden-path
- Frontend: (legg inn riktig repo her om det er frontend-golden-path)

### Notater
Dagens utfordringer:
Vanskelig å få samlet rest-risiko
Før/etter vurdering er ikke alltid tydelig
Tiltak kan miste sporbarhet over tid
Begrenset støtte for prioritering på tvers
(Funksjonsnivå og Trusselmodellering)

behovene vi ser fremover:
Mer komplekse teknologilandskap
Økt regulatorisk forventning
Behov for dokumenterbar styring
Behov for konsistent metodikk

## Inspirasjon
 - [Fuck it, ship it - Stine Mølgaard og Jacob Bøtter](https://fuckitshipit.dk/)
 - [Codin' Dirty - Carson Gross](https://htmx.org/essays/codin-dirty/)
 - 差不多 (chà bù duō) - «godt nok» altså at noe ikke er perfekt, men tilstrekkelig.

## Erklæring om bruk av generativ KI

Under utviklingen av dette innholdet har forfatter(e) benyttet generativ KI – inkludert M365 Copilot og ChatGPT – til å omformulere og effektivisere tekst og kode. Alt innhold er deretter gjennomgått og en del redigert manuelt.
