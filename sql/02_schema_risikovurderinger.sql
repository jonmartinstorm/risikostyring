-- Personer
create table personer (
  id serial primary key,
  navn text not null,
  ident text not null
);

-- Risikovurderinger
create table risikovurderinger (
  id serial primary key,
  navn text not null,
  team_omrade text not null,
  status text, -- pågår, godkjent, arkivert
  beskrivelse text,
  oppsummering text,
  created_at timestamp not null default now(),
  updated_at timestamp not null default now()
);

-- Risikoer
create table risikoer (
  id serial primary key,
  vurdering_id integer not null,
  navn text not null,
  tema text,
  beskrivelse text,
  begrunnelse text,
  sannsynlighet integer not null, -- 1–5
  konsekvens integer not null,    -- 1–5
  created_at timestamp not null default now(),
  updated_at timestamp not null default now(),

  foreign key (vurdering_id)
    references risikovurderinger(id)
    on delete cascade
);

-- Tiltak
create table tiltak (
  id serial primary key,
  risiko_id integer not null,
  navn text not null,
  beskrivelse text,
  status text not null, -- mulig, planlagt, implementert, besluttet ikke gjennomført
  created_at timestamp not null default now(),
  updated_at timestamp not null default now(),

  foreign key (risiko_id)
    references risikoer(id)
    on delete cascade
);

-- Deltakere
create table deltakere (
  id serial primary key,
  person_id integer not null,
  vurdering_id integer not null,
  rolle text not null, -- fasilitator, deltaker, risikoeier, kontaktperson

  foreign key (person_id)
    references personer(id)
    on delete cascade,

  foreign key (vurdering_id)
    references risikovurderinger(id)
    on delete cascade
);

-- Loggpunkter
create table loggpunkter (
  id serial primary key,
  vurdering_id integer not null,
  tittel text not null,
  innhold text,
  created_at timestamp not null default now(),

  foreign key (vurdering_id)
    references risikovurderinger(id)
    on delete cascade
);
