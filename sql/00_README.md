# Database (PostgreSQL) – oppsett og seeds

PoC-en bruker PostgreSQL. For demo-kjøring anbefales Docker Compose, som oppretter database og bruker automatisk.

## Standard demo-credentials

I PoC bruker vi følgende defaults (kan overstyres via env):

- Database: `risikovurdering`
- Bruker: `app_user`
- Passord: `demo-passord`

> Merk: Dette er kun for lokal demo. Ikke bruk disse i produksjon.

## Kjør med Docker Compose (anbefalt)

Når `db` starter første gang, kjører Postgres automatisk alle `.sql`-filer i `sql/` (schema + seed).

```bash
docker compose up --build
```
# OLD
---
# Oppsett av database og seeds
Alle seeds er generert med LLM.

Som postgres user:

```sql
create role fastify_app
  login
  password 'superhemmelig-passord';


create database risikovurdering
  owner fastify_app;

\c risikovurdering

-- Sørg for at app-brukeren kan jobbe i public-schema
grant usage, create on schema public to fastify_app;

-- Hvis du vil være ryddig:
alter default privileges in schema public
grant select, insert, update, delete on tables to fastify_app;

alter default privileges in schema public
grant usage, select on sequences to fastify_app;


psql -h localhost -U fastify_app -d risikovurdering

```

```sql
select rv.navn, r.navn, t.navn
from risikovurderinger rv
left join risikoer r on r.vurdering_id = rv.id
left join tiltak t on t.risiko_id = r.id
order by rv.id, r.id;

```