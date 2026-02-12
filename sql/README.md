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