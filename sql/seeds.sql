insert into personer (navn, ident) values
  ('Ola Nordmann', 'OLA01'),
  ('Kari Nordmann', 'KAR01'),
  ('Per Hansen', 'PER01');


insert into risikovurderinger
  (navn, team_omrade, status, beskrivelse, oppsummering)
values
  (
    'Risikovurdering – Kundeportal',
    'Digital kunde',
    'pågår',
    'Risikovurdering av ny kundeportal for nettselskaper',
    'Foreløpig identifisert risikoer innen tilgangsstyring'
  ),
  (
    'Risikovurdering – Drift og beredskap',
    'Plattform og drift',
    'godkjent',
    'Årlig vurdering av drift og beredskap',
    'Risikonivå vurdert som akseptabelt'
  );


insert into deltakere (person_id, vurdering_id, rolle) values
  (1, 1, 'fasilitator'),
  (2, 1, 'risikoeier'),
  (3, 1, 'deltaker'),

  (2, 2, 'fasilitator'),
  (3, 2, 'risikoeier');

insert into risikoer
  (vurdering_id, navn, tema, beskrivelse, begrunnelse, sannsynlighet, konsekvens)
values
  (
    1,
    'Uautorisert tilgang til kundeinformasjon',
    'Tilgangsstyring',
    'Brukere kan få tilgang til data de ikke skal se',
    'Mangelfull rolle- og rettighetsstyring',
    3,
    5
  ),
  (
    1,
    'Manglende logging av brukerhandlinger',
    'Logging',
    'Viktige handlinger blir ikke loggført',
    'Manglende audit-logg',
    2,
    4
  ),
  (
    2,
    'Utilstrekkelig beredskap ved driftsavbrudd',
    'Beredskap',
    'Lang nedetid ved større hendelser',
    'Manglende øvelser og rutiner',
    2,
    5
  );

insert into tiltak
  (risiko_id, navn, beskrivelse, status)
values
  (
    1,
    'Innføre rollebasert tilgangsstyring',
    'Definere og implementere roller',
    'skal gjennomføres'
  ),
  (
    1,
    'Regelmessig tilgangsrevisjon',
    'Kvartalsvis gjennomgang av tilganger',
    'mulig tiltak'
  ),
  (
    2,
    'Etablere sentral audit-logg',
    'Alle sikkerhetsrelevante handlinger loggføres',
    'implementert'
  ),
  (
    3,
    'Gjennomføre beredskapsøvelse',
    'Årlig øvelse for driftsavbrudd',
    'planlagt'
  );

insert into loggpunkter
  (vurdering_id, tittel, innhold)
values
  (
    1,
    'Oppstartsmøte',
    'Risikovurderingen ble startet med relevante deltakere'
  ),
  (
    1,
    'Workshop gjennomført',
    'Hovedrisikoer innen tilgangsstyring identifisert'
  ),
  (
    2,
    'Godkjenning',
    'Risikovurderingen er godkjent'
  );
