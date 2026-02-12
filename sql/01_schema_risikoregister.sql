create table themes (
  id bigserial primary key,
  name text not null unique,
  description text
);

create table registerrisks (
  id bigserial primary key,
  theme_id bigint not null references themes(id) on delete restrict,
  name text not null,
  description text,
  possible_consequence text,
  possible_probability text
);

-- nyttig for søk/filter/sort
create index idx_risks_theme_id on registerrisks(theme_id);
create index idx_risks_name on registerrisks(lower(name));
