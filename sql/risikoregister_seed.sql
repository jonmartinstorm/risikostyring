-- Themes
insert into themes (id, name, description) values
  (1, 'Identitet og tilgang', 'Risikoer knyttet til identitetsforvaltning, tilgangsstyring og privilegier'),
  (2, 'Drift og kontinuitet', 'Risikoer som påvirker tilgjengelighet, stabil drift og beredskap'),
  (3, 'Data og personvern', 'Risikoer knyttet til konfidensialitet, integritet og behandling av data');

-- Register risks
insert into registerrisks (
  theme_id,
  name,
  description,
  possible_consequence,
  possible_probability
) values

-- Tema 1: Identitet og tilgang
(1,
 'For brede admin-rettigheter',
 'Administratorroller gir tilgang utover reelt behov.',
 'Økt skadeomfang ved kompromittering av konto.',
 'Sannsynlig i miljøer uten regelmessig tilgangsrevisjon.'),

(1,
 'Mangelfull offboarding',
 'Tilganger fjernes ikke raskt nok når ansatte slutter eller bytter rolle.',
 'Uautoriserte tilganger kan misbrukes over tid.',
 'Relativt vanlig i komplekse organisasjoner.'),

(1,
 'Delte brukerkontoer',
 'Flere personer benytter samme konto.',
 'Manglende sporbarhet og ansvarlighet.',
 'Forekommer ofte i drift- og beredskapsmiljøer.'),

(1,
 'Svake MFA-krav',
 'Ikke alle brukere eller roller har krav om sterk autentisering.',
 'Økt risiko for kontokompromittering.',
 'Avhengig av modenhet i IAM-løsningen.'),

-- Tema 2: Drift og kontinuitet
(2,
 'Manglende beredskapsplaner',
 'Det finnes ikke oppdaterte eller testede beredskapsplaner.',
 'Lang nedetid og uforutsigbar håndtering av hendelser.',
 'Vanlig der beredskap ikke er øvd regelmessig.'),

(2,
 'Avhengighet til enkeltpersoner',
 'Kritisk kunnskap er bundet til få personer.',
 'Sårbarhet ved fravær eller turnover.',
 'Ofte observert i små eller pressede team.'),

(2,
 'Utilstrekkelig overvåking',
 'Manglende eller begrenset overvåking av systemer.',
 'Hendelser oppdages sent eller ikke i det hele tatt.',
 'Sannsynlig i eldre eller manuelt drevne miljøer.'),

-- Tema 3: Data og personvern
(3,
 'Manglende dataklassifisering',
 'Data er ikke systematisk klassifisert etter verdi og sensitivitet.',
 'Feil beskyttelsesnivå og utilsiktet eksponering.',
 'Vanlig i organisasjoner uten moden informasjonsforvaltning.'),

(3,
 'Uklare behandlingsgrunnlag',
 'Formål og behandlingsgrunnlag for data er ikke godt dokumentert.',
 'Brudd på personvernlovgivning og tillitstap.',
 'Forekommer ofte i tverrfaglige løsninger.'),

(3,
 'For lang lagringstid',
 'Data lagres lengre enn nødvendig.',
 'Økt konsekvens ved datalekkasjer.',
 'Sannsynlig der sletting ikke er automatisert.');
