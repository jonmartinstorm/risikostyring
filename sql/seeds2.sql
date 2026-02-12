insert into personer (navn, ident) values
  ('Anne Lunde', 'ANL01'),
  ('Morten Berg', 'MOB01'),
  ('Fatima Ali', 'FAA01'),
  ('Sindre Moen', 'SIM01'),
  ('Lena Skog', 'LES01'),
  ('Håkon Dahl', 'HAD01');


insert into risikovurderinger
  (navn, team_omrade, status, beskrivelse, oppsummering)
values
  ('Risikovurdering – IAM og tilgang', 'Sikkerhet og plattform', 'pågår',
   'Vurdering av identitet, tilgangsstyring og privilegier.',
   'Flere funn knyttet til admin-rettigheter og livssyklus'),

  ('Risikovurdering – Integrasjoner mot tredjepart', 'Integrasjon', 'pågår',
   'API-integrasjoner, autentisering og datadeling mot eksterne.',
   'Risiko rundt tokens, scopes og tilgjengelighet'),

  ('Risikovurdering – Dataplattform og analyse', 'Data og innsikt', 'planlagt',
   'Behandling av data, PII, tilgang og datakvalitet.',
   'Fokus på personvern og eksponering'),

  ('Risikovurdering – Kundeportal (release 2)', 'Digital kunde', 'pågår',
   'Ny funksjonalitet i kundeportal.',
   'Risiko knyttet til innsyn og autorisasjon'),

  ('Risikovurdering – Mobile flater', 'Digital kunde', 'planlagt',
   'Mobilapp/PWA og sikker bruk på enheter.',
   'Sesjonshåndtering og tredjeparts SDK'),

  ('Risikovurdering – CI/CD og byggkjede', 'Plattform og drift', 'pågår',
   'Bygg, pipelines, secrets og supply chain.',
   'Behov for signing og scanning'),

  ('Risikovurdering – Overvåkning og hendelseshåndtering', 'Plattform og drift', 'pågår',
   'Logging, deteksjon og respons.',
   'Gaps i alarmer og øvelser'),

  ('Risikovurdering – Beredskap og gjenoppretting', 'Beredskap', 'planlagt',
   'Backup, restore og DR.',
   'Restore-testing og RTO/RPO'),

  ('Risikovurdering – Endringshåndtering og konfigurasjon', 'Engineering', 'pågår',
   'Endringer, konfigurasjon og rollback.',
   'Manglende standarder'),

  ('Risikovurdering – Leverandør og kontrakt', 'Innkjøp', 'planlagt',
   'SaaS-leverandører, SLA og DPA.',
   'Exit, revisjon og underleverandører');

insert into deltakere (person_id, vurdering_id, rolle) values
  (4, 3, 'fasilitator'), (2, 3, 'risikoeier'), (3, 3, 'deltaker'),
  (5, 4, 'fasilitator'), (1, 4, 'risikoeier'), (6, 4, 'deltaker'),
  (6, 5, 'fasilitator'), (2, 5, 'risikoeier'), (5, 5, 'deltaker'),
  (1, 6, 'fasilitator'), (3, 6, 'risikoeier'), (4, 6, 'deltaker'),
  (2, 7, 'fasilitator'), (4, 7, 'risikoeier'), (6, 7, 'deltaker'),
  (5, 8, 'fasilitator'), (3, 8, 'risikoeier'), (1, 8, 'deltaker'),
  (6, 9, 'fasilitator'), (2, 9, 'risikoeier'), (4, 9, 'deltaker'),
  (4,10, 'fasilitator'), (1,10, 'risikoeier'), (5,10, 'deltaker'),
  (3,11, 'fasilitator'), (6,11, 'risikoeier'), (2,11, 'deltaker'),
  (2,12, 'fasilitator'), (5,12, 'risikoeier'), (1,12, 'deltaker');


-- 100 risikoer (10 per risikovurdering).
-- Forutsetter at risikovurderinger-idene blir 3..12 i samme rekkefølge som du allerede har lagt inn.
insert into risikoer
  (vurdering_id, navn, tema, beskrivelse, begrunnelse, sannsynlighet, konsekvens)
values
  -- Vurdering 3: IAM og tilgang
  (3,'For brede admin-rettigheter','Tilgangsstyring','Administratorroller gir mer tilgang enn nødvendig, og øker skadepotensial ved kompromittering.','Mangler least privilege og tydelig rollemodell.',3,5),
  (3,'Mangelfull offboarding','Tilgangsstyring','Tilganger fjernes ikke raskt nok når brukere bytter rolle eller slutter.','Manuelle prosesser og uklare ansvarslinjer.',3,4),
  (3,'Svake MFA-krav for privilegerte kontoer','Tilgangsstyring','Privilegerte kontoer har ikke konsekvent sterke krav til MFA.','Ulik policy mellom systemer og konto-typer.',2,5),
  (3,'Delte kontoer i drift','Tilgangsstyring','Felleskontoer reduserer sporbarhet og ansvarlighet.','Historisk praksis og manglende alternativer.',3,4),
  (3,'Manglende PAM/just-in-time','Tilgangsstyring','Stående admin-tilganger gir unødvendig høy angrepsflate over tid.','Ingen PAM/JIT-løsning og for brede roller.',2,5),
  (3,'Feil i tilgangsprovisjonering','Tilgangsstyring','Feil rolle/gruppe tildeles ved onboarding eller rolleendringer.','Datakvalitet i kilder og svake kontrollpunkter.',2,4),
  (3,'Utilstrekkelig tilgangsrevisjon','Styring','Tilganger gjennomgås ikke jevnlig og systematisk.','Mangler kontrollplan og oppfølging.',3,4),
  (3,'Manglende logging av admin-handlinger','Logging','Privilegerte handlinger logges ikke godt nok for revisjon og deteksjon.','Ufullstendig audit-logg og SIEM-dekning.',2,5),
  (3,'Token- og sesjonsmisbruk','Applikasjon','Sesjoner/tokens kan kapres eller gjenbrukes på uønsket måte.','For lang TTL og manglende rotasjon/step-up.',2,4),
  (3,'Uklare dataeierskap for tilgang','Styring','Godkjenning av tilgang mangler tydelig dataeier og prosess.','Uavklart RACI og uklare godkjenningsløp.',3,3),

  -- Vurdering 4: Integrasjoner mot tredjepart
  (4,'Eksponering av API-nøkler','Secrets','API-nøkler kan lekke via kode, logger eller CI.','Manglende secret-håndtering og scanning.',3,5),
  (4,'For vide scopes på OAuth-token','Tilgangsstyring','Token gir tilgang til mer enn integrasjonen trenger.','Standard-scopes brukes ukritisk.',3,4),
  (4,'Mangelfull inputvalidering','Applikasjon','Ugyldige eller ondsinnede payloads kan gi feil eller utnyttelse.','Ulik kontrakt og lite validering.',3,4),
  (4,'Nedetid hos tredjepart stopper flyt','Tilgjengelighet','Avhengighet uten god fallback fører til stans i kritiske prosesser.','Ingen kø/fallback eller degradering.',4,4),
  (4,'Manglende rate limiting','Tilgjengelighet','Tjenesten kan overbelastes eller misbrukes via integrasjonsendepunkt.','Ingen throttling per klient/IP.',3,3),
  (4,'Uklart ansvar ved hendelser','Beredskap','Ved hendelser er kontaktpunkt, SLA og eskalering uklart.','Svak avtale og uklare prosesser.',2,4),
  (4,'Mangelfull logging og korrelasjon','Logging','Integrasjonskall mangler korrelasjons-ID og konsistent logging.','Ikke standardisert tracing og logging.',3,3),
  (4,'TLS/transportfeilkonfigurasjon','Kryptering','Feil TLS-terminering eller legacy-støtte kan gi svakere kryptering.','Ulik konfig og teknisk gjeld.',2,5),
  (4,'Brudd på dataminimering','Personvern','Det sendes mer data enn nødvendig til leverandør.','Manglende vurdering av formål og behov.',3,4),
  (4,'Breaking changes uten kontroll','Endring','Kontrakter/versjoner endres uten styring og tester.','Manglende versjonering og kontraktstester.',3,3),

  -- Vurdering 5: Dataplattform og analyse
  (5,'PII i analyse uten tilstrekkelige kontroller','Personvern','Personopplysninger brukes uten klare formål, tilgangskontroll og logging.','Uklare formål og svake tilgangskontroller.',3,5),
  (5,'Manglende retensjon og sletting','Personvern','Data lagres lenger enn nødvendig uten håndheving av policy.','Ingen automatisert retensjon og sletting.',3,4),
  (5,'For brede lesetilganger til rådata','Tilgangsstyring','For mange brukere har tilgang til detaljerte datasett.','Mangler segmentering og RBAC.',3,4),
  (5,'Mangelfull datalinje/lineage','Styring','Det er uklart hvilke kilder som gir hvilke data og transformasjoner.','Lite metadata og dokumentasjon.',2,3),
  (5,'Uautoriserte uttrekk/eksport','Data','Data kan eksporteres uten tilstrekkelig sporbarhet og kontroll.','Manglende DLP/egress-kontroll.',2,5),
  (5,'Dårlig datakvalitet gir feil beslutninger','Kvalitet','Rapporter/innsikt kan bli misvisende pga. manglende validering.','Lite monitorering og kvalitetssjekker.',3,3),
  (5,'Sårbarheter i dataverktøy og biblioteker','Sårbarheter','Komponenter kan ha kjente sårbarheter uten patch-rutine.','Uregelmessig patching og scanning.',3,4),
  (5,'Manglende kryptering ved lagring','Kryptering','Sensitive data kan ligge ukryptert ved feil konfigurasjon.','Feil konfig eller manglende standard.',2,5),
  (5,'Prod-data brukes i dev/test','Miljø','Kopiering av prod-data til dev uten maskering øker risiko.','Manglende anonymisering og policy.',3,4),
  (5,'Svak overvåkning av datajobber','Drift','Feil i pipelines oppdages sent og påvirker drift/rapportering.','Svak alerting/observability.',3,3),

  -- Vurdering 6: Kundeportal (release 2)
  (6,'IDOR – innsyn i andres data','Applikasjon','Bruker kan få tilgang til data de ikke skal se via svak ressursautorisasjon.','Mangelfull objekt-/ressursautorisasjon.',3,5),
  (6,'Mangelfull samtykkestyring','Personvern','Samtykke er uklart, feil lagret eller vanskelig å revidere.','Dårlig modell og UX.',2,4),
  (6,'Manglende audit på kritiske endringer','Logging','Endringer i sensitive data spores ikke godt nok.','Manglende audit events og standardisering.',3,4),
  (6,'Brute force på innlogging','Tilgangsstyring','Innlogging kan angripes pga. manglende begrensning og deteksjon.','Ingen throttling/lockout og svake alarmer.',3,4),
  (6,'Sårbarheter i frontend-avhengigheter','Supply chain','Kjente sårbarheter kan introduseres via dependencies.','Mangler SCA og oppdateringsrutine.',3,4),
  (6,'Feil sikkerhetsheaders (CSP m.m.)','Konfigurasjon','Manglende/feil headers øker risiko for XSS/clickjacking.','Mangler baseline og kvalitetssjekk.',2,4),
  (6,'Utrygg filopplasting','Applikasjon','Skadelige filer kan lastes opp uten validering/skanning.','Mangler scanning og isolering.',2,5),
  (6,'Manglende rate-limit på søk','Tilgjengelighet','Søk kan misbrukes for overbelastning eller scraping.','Ingen begrensning og caching.',3,3),
  (6,'Utilstrekkelig varsling ved hendelser','Beredskap','Kunder informeres ikke raskt nok ved avvik/hendelser.','Mangler maler og prosess.',2,3),
  (6,'Uklare roller mellom kunde og intern','Styring','Feil tildeling av rettigheter pga. uklare rolledefinisjoner.','Uklare rollebeskrivelser og ansvar.',3,3),

  -- Vurdering 7: Mobile flater
  (7,'Usikker lagring av sesjon på enhet','Mobil','Tokens/sesjoner kan lekke via feil lagring eller debug.','Feil bruk av storage og debug-logging.',2,5),
  (7,'Manglende device-binding','Tilgangsstyring','Sesjoner kan gjenbrukes på andre enheter uten ekstra kontroll.','Ingen enhetsbinding og svak step-up.',2,4),
  (7,'Svak beskyttelse mot MITM i usikre nett','Kryptering','Trafikk kan manipuleres ved svak TLS eller manglende hardening.','Manglende hardening/pinning.',2,4),
  (7,'Push-varsler lekker sensitiv info','Personvern','Innhold kan vises på låseskjerm og eksponere data.','For mye innhold i push og default-innstillinger.',3,3),
  (7,'PWA-cache eksponerer data offline','Applikasjon','Caching kan gjøre sensitive data tilgjengelig lokalt.','Feil caching-strategi og cache-control.',2,4),
  (7,'Mangelfull sikkerhetslogging','Logging','Mobilhandlinger kan ikke spores godt nok for revisjon/deteksjon.','Mangler standard event-logging og korrelasjon.',3,3),
  (7,'Tredjeparts SDK samler inn mer enn ønsket','Leverandør','SDK kan introdusere personvern- og sikkerhetsrisiko.','Lite kontroll på datainnsamling og endringer.',2,4),
  (7,'Feil i deep links','Applikasjon','Deep links kan misbrukes for å omgå forventet flyt.','Manglende validering og auth-sjekk.',2,4),
  (7,'Manglende revoke ved tap av enhet','Beredskap','Tap/stjålet enhet gir for lang gyldighet på sesjoner.','Ingen rask invalidasjon av tokens.',3,4),
  (7,'Svak testdekning på mobil-sikkerhet','Styring','Sårbarheter oppdages sent pga. mangelfull testprosess.','Ingen testplan og få sikkerhetstester.',3,3),

  -- Vurdering 8: CI/CD og byggkjede
  (8,'Secrets eksponeres i pipeline-logger','CI/CD','Hemmeligheter kan dukke opp i output ved feil masking.','Feil masking og debug-output.',3,5),
  (8,'For brede rettigheter for CI-runners','Tilgangsstyring','Runner kan nå for mye og brukes som springbrett.','Mangler least privilege og nettverksbegrensning.',3,4),
  (8,'Manglende signering av artefakter','Supply chain','Bygg/artefakter kan manipuleres uten verifiserbar integritet.','Ingen signing/verifisering.',2,5),
  (8,'Utdatert base image','Sårbarheter','Images har kjente CVE-er og oppdateres for sjelden.','Manglende vedlikehold og scanning.',4,4),
  (8,'Dependency confusion / pakkeangrep','Supply chain','Avhengigheter kan erstattes av ondsinnede pakker.','Manglende pinning og repo-policy.',2,5),
  (8,'Mangler kvalitetsporter (SAST/SCA gating)','Kvalitet','Sårbar kode kan merges/deployes uten stopp.','Ingen gating i pipeline.',3,4),
  (8,'Mangelfull miljøseparasjon for credentials','Miljø','Feil bruk av prod-credentials i feil miljø.','Svake scopes og policyer.',2,5),
  (8,'Manglende provenance/SBOM','Supply chain','Manglende sporbarhet til hva som ble bygget, og hvordan.','Ingen attestering/provenance.',3,4),
  (8,'Workflow-endringer uten review','Styring','Angrep kan skje via endringer i CI-konfig/workflows.','Ubeskyttet workflow-repo og manglende krav til review.',3,5),
  (8,'Tokens har for lang levetid','Tilgangsstyring','Langlevde tokens øker risiko ved lekkasje.','Manglende rotasjon og TTL.',3,4),

  -- Vurdering 9: Overvåkning og hendelseshåndtering
  (9,'Alarmstøy skjuler reelle hendelser','Overvåkning','For mange falske positiver gjør at alvorlige signaler overses.','Dårlige terskler og use-cases.',4,3),
  (9,'Manglende sentral loggdekning','Logging','Viktige loggkilder er ikke tilgjengelige i sentral løsning.','Ikke onboardet eller feil konfig.',3,4),
  (9,'Manglende korrelasjon på tvers','Logging','Hendelser blir fragmentert uten felles korrelasjonsnøkler.','Mangler correlation-id/trace.',3,3),
  (9,'For lang tid til deteksjon','Deteksjon','Angrep/hendelser oppdages sent pga. svake regler/use-cases.','Mangler deteksjonsregler for høy-risiko.',3,4),
  (9,'Uklare roller og ansvar i IR','Beredskap','Det er uklart hvem gjør hva ved hendelser.','Mangler RACI og playbooks.',3,4),
  (9,'Mangler øvelser/tabletops','Beredskap','Lav modenhet pga. få praktiske øvelser.','Ingen plan og eierskap for øvelser.',3,3),
  (9,'Utilstrekkelig bevisinnsamling','IR','Loggretensjon og prosedyrer er ikke tilstrekkelige for etterforskning.','Mangler prosess og krav til retensjon.',2,4),
  (9,'Manglende kundekommunikasjon ved hendelser','Kommunikasjon','Varsling til kunder er ikke avklart/malbasert.','Mangler maler og kanaler.',2,3),
  (9,'Manglende overvåkning av privilegert aktivitet','Tilgangsstyring','Admin-misbruk oppdages ikke raskt nok.','Mangler admin-audit og alarmer.',2,5),
  (9,'Manglende integrasjon mot ticketing','Drift','Hendelser følges ikke opp konsekvent uten sak/arbeidsflyt.','Ikke standardisert arbeidsflyt.',3,3),

  -- Vurdering 10: Beredskap og gjenoppretting (DR)
  (10,'Restore er ikke testet','Beredskap','Backup kan være ubrukelig hvis restore ikke verifiseres jevnlig.','Mangler restore-tester og oppfølging.',3,5),
  (10,'Uklart RTO/RPO','Beredskap','Forventninger til gjenopprettingstid/-punkt er ikke forankret.','Ikke definert eller forankret.',3,4),
  (10,'Single point of failure i database','Tilgjengelighet','DB-feil kan stoppe tjenesten uten HA/failover.','Manglende HA-design.',3,5),
  (10,'Avhengighet til én region','Tilgjengelighet','Region-feil kan gi langvarig nedetid uten alternativ.','Ingen multi-region strategi.',2,5),
  (10,'Mangler runbooks','Beredskap','Gjenoppretting tar lengre tid uten oppdatert dokumentasjon.','Lite dokumentasjon og øving.',3,4),
  (10,'Nøkkelpersonrisiko','Styring','DR-prosesser avhenger av få personer.','Manglende redundans i kompetanse.',3,3),
  (10,'Backup ikke kryptert','Kryptering','Backups kan eksponere data ved tilgang/tyveri.','Feil konfig/standard.',2,5),
  (10,'Ufullstendig kartlegging av avhengigheter','Styring','Restore stopper opp fordi rekkefølge/avhengigheter ikke er kjent.','Ufullstendig kartlegging og dokumentasjon.',3,4),
  (10,'Mangler kommunikasjonsplan ved store hendelser','Kommunikasjon','Intern/ekstern kommunikasjon blir ad-hoc.','Ingen plan eller maler.',2,3),
  (10,'Leverandør støtter ikke DR-krav','Leverandør','SLA/kontrakt dekker ikke behov ved krise.','Uklart i kontrakter og manglende krav.',2,4),

  -- Vurdering 11: Endring og konfigurasjon
  (11,'Endringer går uten godkjenning','Endring','Uautoriserte endringer kan innføres i produksjon.','Manglende policy og kontroll.',3,4),
  (11,'Feilkonfigurasjon svekker sikkerhet','Konfigurasjon','Sikkerhetsinnstillinger drifter over tid uten kontroll.','Ingen baseline og driftkontroll.',3,5),
  (11,'Ustyrte feature toggles','Endring','Toggles kan aktivere funksjon feil eller skjule risiko.','Mangler oversikt, eierskap og opprydding.',3,3),
  (11,'Manglende sporbarhet på konfig','Logging','Det er uklart hvem endret hva og hvorfor.','Ikke alt ligger i Git/IaC.',3,4),
  (11,'Rollback tar for lang tid','Tilgjengelighet','Feil release gir lengre nedetid uten enkel rollback.','Ingen standard rollback eller automatisering.',3,4),
  (11,'Svakt preprod/test-regime','Kvalitet','Feil oppdages i prod fordi miljøer og test ikke er gode nok.','For stor forskjell mellom miljøer.',3,4),
  (11,'Secrets ligger i config-filer','Secrets','Hemmeligheter lagres feil og blir vanskelig å rotere.','Manglende secret store og rotasjon.',3,5),
  (11,'Manglende policy-as-code','Styring','Regler håndheves ikke automatisk i plattformen.','Ingen automatisert kontroll av policyer.',2,4),
  (11,'Uklare eiere av baseline','Styring','Ingen eier baseline-krav og avvikshåndtering.','Uklart teamansvar.',3,3),
  (11,'Endringer i tilgangsregler uten review','Tilgangsstyring','Autorisasjonsregler kan åpnes utilsiktet.','Mangler godkjenningsflyt.',2,5),

  -- Vurdering 12: Leverandør og kontrakt
  (12,'Underleverandører uten tilstrekkelig oversikt','Leverandør','Databehandling skjer hos flere ledd uten god kontroll.','Manglende kartlegging og krav.',3,4),
  (12,'Svak exit-strategi','Leverandør','Det er vanskelig å bytte leverandør uten plan og testet migrasjon.','Lock-in og manglende exit-plan.',3,4),
  (12,'SLA dekker ikke sikkerhetskrav','Leverandør','Varsling, responstid og sikkerhetskrav er ikke tilstrekkelig spesifisert.','Ikke kontraktfestet godt nok.',3,4),
  (12,'Manglende revisjonsrett','Etterlevelse','Begrenset mulighet til å verifisere leverandørens kontroller.','Kontrakt mangler revisjonsklausul.',2,4),
  (12,'Uklare krav til datalagringssted','Personvern','Det er uklart hvor data faktisk lagres/behandles.','Manglende presisering av region/land.',3,4),
  (12,'Mangelfull hendelsesvarsling','Beredskap','Leverandør varsler for sent eller ustrukturert ved hendelser.','Uklare tidsfrister og kontaktpunkter.',3,4),
  (12,'Svak nøkkelhåndtering hos leverandør','Kryptering','Krypteringsnøkler forvaltes uten tydelige krav og innsyn.','Lite innsyn og svake krav.',2,5),
  (12,'Mangler krav til sårbarhetshåndtering','Sårbarheter','Patchnivå og scanning er ikke kontraktfestet.','Ingen krav til CVE/patch-SLA.',3,4),
  (12,'For bred support-tilgang','Tilgangsstyring','Support-personell kan få for mye innsyn i data/system.','Manglende least privilege og logging.',2,5),
  (12,'DPA er for lite presis','Personvern','Databehandleravtale mangler detaljer om tiltak, roller og oppfølging.','Standard DPA uten nødvendige presiseringer.',3,4);


-- 100 tiltak (ett tiltak per risiko_id).
-- Forutsetter at eksisterende risikoer har id 1..3, og at de 100 nye blir id 4..103 i samme rekkefølge som over.
insert into tiltak
  (risiko_id, navn, beskrivelse, status)
values
  (4,'Stramme inn admin-roller','Etabler rollemodell og fjern unødvendige privilegier (least privilege).','planlagt'),
  (5,'Automatisere offboarding','Automatisk deprovisjonering ved rollebytte/slutt + periodisk kontroll.','planlagt'),
  (6,'Håndheve MFA for privilegerte','Krev MFA og sterke policyer for admin og break-glass-kontoer.','planlagt'),
  (7,'Avvikle delte kontoer','Erstatt felleskontoer med personlige kontoer og sporbar tilgang.','planlagt'),
  (8,'Innføre PAM/JIT','Just-in-time admin med godkjenning og tidsbegrensning.','planlagt'),
  (9,'Sikre provisjonering','Innfør godkjenningsflyt og validering av rolledata ved onboarding.','planlagt'),
  (10,'Fast tilgangsrevisjon','Kvartalsvis gjennomgang av tilganger med rapportering til risikoeier.','planlagt'),
  (11,'Admin-audit til SIEM','Send privilegerte hendelser til sentral logg og lag alarmer.','planlagt'),
  (12,'Rotasjon og kortere TTL','Reduser levetid på tokens/sesjoner og innfør rotasjon.','planlagt'),
  (13,'Avklare dataeierskap','Definer dataeier per datasett og prosess for tilgangsgodkjenning.','planlagt'),

  (14,'Secret scanning','Aktiver scanning i repo/CI og roter nøkler ved funn.','planlagt'),
  (15,'Redusere token-scopes','Begrens scopes til minste nødvendige per integrasjon og miljø.','planlagt'),
  (16,'Kontraktsvalidering','Implementer validering (schema) på alle innkommende payloads.','planlagt'),
  (17,'Fallback og retry','Etabler kø/retry og degradering ved tredjepart-nedetid.','planlagt'),
  (18,'Rate limiting','Innfør throttling per klient/IP og overvåk misbruk.','planlagt'),
  (19,'Avklare SLA/eskalering','Dokumenter kontaktpunkt, tidsfrister og eskalering med leverandør.','planlagt'),
  (20,'Korrelasjons-ID','Standardiser korrelasjons-ID i alle integrasjonskall og logger.','planlagt'),
  (21,'TLS hardening','Stram inn TLS-konfig og fjern utrygge protokoller/ciphers.','planlagt'),
  (22,'Dataminimering','Fjern unødvendige felter og dokumenter formål/utlevering.','planlagt'),
  (23,'API-versjonering','Innfør semver, changelog og kontraktstester i staging.','planlagt'),

  (24,'Tilgangsmodell for PII','Innfør tilgangsgrupper, logging og godkjenning for PII-datasett.','planlagt'),
  (25,'Retensjon og sletting','Implementer håndhevet retention policy og automatisert sletting.','planlagt'),
  (26,'RBAC og segmentering','Segmenter datasett og begrens tilgang til rådata.','planlagt'),
  (27,'Datakatalog/lineage','Etabler minimum metadata og lineage for kritiske datasett.','planlagt'),
  (28,'Egress/DLP-kontroll','Innfør kontroll på eksport og logging av uttrekk.','planlagt'),
  (29,'Datakvalitetsmonitorering','Definer valideringsregler og alarmer ved avvik.','planlagt'),
  (30,'Patch- og sårbarhetsrutine','Etabler scanning og patch-SLA for dataverktøy/biblioteker.','planlagt'),
  (31,'Kryptering at rest','Aktiver kryptering og sikker nøkkelstyring for lagring.','planlagt'),
  (32,'Maskering i dev/test','Bruk anonymisering/maskering før bruk av prod-lignende data.','planlagt'),
  (33,'Overvåkning av datajobber','Dashboards/alarmer for feilede jobber og SLA-brudd.','planlagt'),

  (34,'Objekt-autorisasjon','Server-side sjekk per ressurs (kunde-id) på alle endepunkt.','planlagt'),
  (35,'Samtykkestyring','Tydelig samtykke-flow, lagring og revisjonsspor.','planlagt'),
  (36,'Audit events','Logg kritiske endringer i sensitive felt og rettigheter.','planlagt'),
  (37,'Innloggingsbeskyttelse','Rate-limit, lockout og deteksjon av brute force.','planlagt'),
  (38,'SCA og oppdatering','Automatiser dependency-oppdateringer og blokkér kritiske CVE-er.','planlagt'),
  (39,'Sikkerhetsheaders baseline','Innfør standard CSP/HSTS/XFO m.m.','planlagt'),
  (40,'Sikre filopplasting','Valider type/størrelse, skann filer og isoler lagring.','planlagt'),
  (41,'Begrense søk','Rate-limit og caching for å hindre scraping/overlast.','planlagt'),
  (42,'Varslingsplan','Etabler kanalstrategi, maler og overvåkning av utsendelser.','planlagt'),
  (43,'Tilgangsmatrise','Dokumenter roller og bygg en tydelig tilgangsmatrise.','planlagt'),

  (44,'Secure storage','Bruk secure storage/keychain for tokens på enhet.','planlagt'),
  (45,'Device-binding','Bind sesjoner til enhet og bruk step-up ved avvik.','planlagt'),
  (46,'TLS for mobil','Streng TLS og vurder sertifikatpinning.','planlagt'),
  (47,'Skjermet push','Unngå sensitive detaljer i push-varsler (minimer innhold).','planlagt'),
  (48,'Trygg cache-strategi','Ikke cache sensitive ressurser; korrekt cache-control.','planlagt'),
  (49,'Mobil logging','Standardiser event-logging og korrelasjon for mobilflyt.','planlagt'),
  (50,'SDK-policy','Krev review/godkjenning og dataminimering for SDK-er.','planlagt'),
  (51,'Sikre deep links','Valider parametre og krev korrekt autentisert flyt.','planlagt'),
  (52,'Rask revoke','Mulighet for rask invalidasjon av tokens ved tap.','planlagt'),
  (53,'Mobil sikkerhetstest','Etabler lett testplan (baseline) for mobil sikkerhet.','planlagt'),

  (54,'Maskere secrets','Hindre at secrets havner i logs med masking og praksis.','planlagt'),
  (55,'Least privilege runners','Begrens permissions og nettverk for CI-runners.','planlagt'),
  (56,'Signering','Signér artefakter/images og verifiser før deploy.','planlagt'),
  (57,'Oppdater base images','Fast oppdateringssyklus og scanning av images.','planlagt'),
  (58,'Pin dependencies','Pin versjoner og bruk kontrollert registry der mulig.','planlagt'),
  (59,'Gating i pipeline','Kritiske funn stopper merge/deploy (SAST/SCA).','planlagt'),
  (60,'Miljøseparasjon','Streng separasjon av prod/dev creds og kort TTL.','planlagt'),
  (61,'Provenance/SBOM','Generer SBOM og bygg-attestering per release.','planlagt'),
  (62,'Beskytt workflows','CODEOWNERS og required reviews på workflow-endringer.','planlagt'),
  (63,'Token-rotasjon','Automatiser rotasjon og bruk OIDC der mulig.','planlagt'),

  (64,'Tune alarmer','Reduser støy med bedre terskler og forbedrede use-cases.','planlagt'),
  (65,'Onboard loggkilder','Sikre at kritiske systemer sender logger til sentral løsning.','planlagt'),
  (66,'Korrelasjon','Innfør trace-id/korrelasjonsnøkler på tvers av tjenester.','planlagt'),
  (67,'Deteksjonsregler','Lag regler for høy-risiko hendelser (IAM/egress).','planlagt'),
  (68,'IR-playbooks','Definer roller og playbooks for topp-scenarioer.','planlagt'),
  (69,'Øvelser','Planlegg kvartalsvise tabletop-øvelser.','planlagt'),
  (70,'Bevis og retensjon','Sikre loggretensjon og prosess for bevisinnsamling.','planlagt'),
  (71,'Kundekommunikasjon','Lag maler og kanalvalg for varsling ved hendelser.','planlagt'),
  (72,'Admin-alarmering','Alarm ved uvanlige admin-events og mistenkelige mønstre.','planlagt'),
  (73,'Ticketing-integrasjon','Automatiser opprettelse av saker ved hendelser.','planlagt'),

  (74,'Restore-tester','Gjennomfør restore-test minst kvartalsvis og dokumenter resultat.','planlagt'),
  (75,'Forankre RTO/RPO','Avklar og dokumenter RTO/RPO med virksomhet.','planlagt'),
  (76,'HA for database','Implementer replika/failover og test failover-rutiner.','planlagt'),
  (77,'Multi-region vurdering','Design for regional feil og vurder replikering/backup.','planlagt'),
  (78,'Runbooks','Skriv og vedlikehold runbooks for DR-scenarier.','planlagt'),
  (79,'Redundans i kompetanse','Kryss-trening og backup-personell for DR-prosesser.','planlagt'),
  (80,'Krypterte backups','Aktiver kryptering og sikker nøkkelstyring for backup.','planlagt'),
  (81,'Avhengighetskart','Kartlegg kritiske avhengigheter og restore-rekkefølge.','planlagt'),
  (82,'Kommunikasjonsplan','Etabler plan og maler for intern/ekstern kommunikasjon.','planlagt'),
  (83,'DR-krav i kontrakt','Kontraktsfest DR-krav og verifiser etterlevelse.','planlagt'),

  (84,'Endringspolicy','Innfør krav til godkjenning og sporbarhet for prod-endringer.','planlagt'),
  (85,'Config baseline','Definer baseline og kontroller avvik regelmessig.','planlagt'),
  (86,'Styring av toggles','Etabler oversikt, eierskap og oppryddingsrutine.','planlagt'),
  (87,'Git/IaC','Legg konfig i Git/IaC og bruk PR-flyt for endringer.','planlagt'),
  (88,'Standard rollback','Automatiser og dokumenter rollback-prosess.','planlagt'),
  (89,'Bedre preprod','Gjør preprod mer lik prod og øk testdekning.','planlagt'),
  (90,'Secret store','Flytt secrets til secret manager og innfør rotasjon.','planlagt'),
  (91,'Policy-as-code','Håndhev regler automatisk (policy-as-code).','planlagt'),
  (92,'Eierskap baseline','Avklar hvem eier baseline og avvikshåndtering.','planlagt'),
  (93,'Review av tilgangsregler','Krev godkjenning for endringer i autorisasjonspolicy.','planlagt'),

  (94,'Kartlegg underleverandører','Innhent oversikt og vurder risiko/krav for hvert ledd.','planlagt'),
  (95,'Exit-plan','Lag migrasjonsplan og test eksport/import jevnlig.','planlagt'),
  (96,'Sikkerhetskrav i SLA','Oppdater SLA med varsling, responstid og sikkerhetskrav.','planlagt'),
  (97,'Revisjonsrett','Legg inn klausul om revisjon/rapportering og oppfølging.','planlagt'),
  (98,'Dataplasseringskrav','Kontraktsfest region/land og endringsvarsling for lagring.','planlagt'),
  (99,'Hendelsesvarsling','Definer tidsfrister, kanaler og kontaktpunkter for varsling.','planlagt'),
  (100,'Krav til nøkkelhåndtering','Still krav til KMS, rotasjon og tilgang for nøkler.','planlagt'),
  (101,'Krav til vuln management','Still krav til scanning, patch-SLA og rapportering.','planlagt'),
  (102,'Least privilege for support','JIT-tilgang for support med logging og begrenset innsyn.','planlagt'),
  (103,'Presis DPA','Oppdater DPA med konkrete tiltak, roller, formål og oppfølging.','planlagt');


-- 2 loggpunkter per risikovurdering (3..12) = 20 loggpunkter
insert into loggpunkter
  (vurdering_id, tittel, innhold)
values
  (3,'Oppstart','Oppstart gjennomført. Scope, roller og mål avklart.'),
  (3,'Workshop','10 risikoer identifisert og tiltak foreslått.'),

  (4,'Oppstart','Integrasjoner og avhengigheter kartlagt.'),
  (4,'Workshop','Risikobilde rundt tokens, scopes og tilgjengelighet dokumentert.'),

  (5,'Planlegging','Datasett, tilgangsbehov og personvernforutsetninger identifisert.'),
  (5,'Workshop','PII, retensjon og uttrekk vurdert med konkrete tiltak.'),

  (6,'Oppstart','Release 2 gjennomgått og kritiske brukerreiser kartlagt.'),
  (6,'Workshop','Autorisasjon, logging og filopplasting prioritert.'),

  (7,'Planlegging','Mobil flyt, enhetsrisiko og sesjonshåndtering definert.'),
  (7,'Workshop','Deep links, SDK-risiko og logging vurdert.'),

  (8,'Oppstart','CI/CD-prosesser og secrets-håndtering kartlagt.'),
  (8,'Teknisk gjennomgang','Signing, gating og workflow-beskyttelse foreslått.'),

  (9,'Oppstart','Loggkilder og alarmbilde kartlagt.'),
  (9,'Workshop','Deteksjonsregler, playbooks og øvelser planlagt.'),

  (10,'Planlegging','DR-scope, avhengigheter og mål for gjenoppretting definert.'),
  (10,'Workshop','Restore-tester, RTO/RPO og runbooks besluttet.'),

  (11,'Oppstart','Endringsflyt og konfigurasjonsstyring kartlagt.'),
  (11,'Workshop','Baseline, policy-as-code og rollback tiltak foreslått.'),

  (12,'Planlegging','Leverandørkrav, SLA og DPA identifisert for oppfølging.'),
  (12,'Workshop','Exit, revisjonsrett og support-tilgang prioritert.');
