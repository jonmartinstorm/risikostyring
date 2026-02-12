// app/risk-matrix/page.tsx
import { RiskMatrix, type Risk } from "../components/RiskMatrix/RiskMatrix";

const mockRisks: Risk[] = [
  {
    id: "R1",
    title: "For brede admin-rettigheter",
    tooltip: "Administratorroller gir mer tilgang enn nødvendig",
    probability: 2,
    consequence: 2,
    href: "/risiko/R1",
  },
  {
    id: "R2",
    title: "Mangelfull offboarding",
    tooltip: "Tilganger fjernes ikke raskt nok når brukere bytter rolle eller slutter",
    probability: 3,
    consequence: 3,
    href: "/risiko/R2",
  },
  {
    id: "R3",
    title: "Svake MFA-krav for privilegerte kontoer",
    tooltip: "Privilegerte kontoer har ikke konsekvent sterke MFA-krav (phishing-resistent der det trengs)",
    probability: 4,
    consequence: 4,
    href: "/risiko/R3",
  },
  {
    id: "R4",
    title: "Delte kontoer i drift",
    tooltip: "Felleskontoer reduserer sporbarhet og ansvarlighet ved hendelser og endringer",
    probability: 3,
    consequence: 2,
    href: "/risiko/R4",
  },
  {
    id: "R5",
    title: "Manglende PAM / just-in-time",
    tooltip: "Stående admin-tilganger øker angrepsflate; mangler JIT-tilgang og godkjenning",
    probability: 4,
    consequence: 5,
    href: "/risiko/R5",
  },
  {
    id: "R6",
    title: "Utilstrekkelig logging av privilegerte handlinger",
    tooltip: "Mangler tilstrekkelig audit-logg for kritiske handlinger og admin-aktiviteter",
    probability: 4,
    consequence: 3,
    href: "/risiko/R6",
  },
  {
    id: "R7",
    title: "Svake passordkrav i eldre systemer",
    tooltip: "Eldre apper støtter ikke moderne passordpolicy/MFA og kan bli et svakt ledd",
    probability: 3,
    consequence: 4,
    href: "/risiko/R7",
  },
  {
    id: "R8",
    title: "Mangelfull rollemodell og tilgangsreview",
    tooltip: "Roller er ikke standardisert; periodiske tilgangsrevisjoner gjøres ikke konsekvent",
    probability: 3,
    consequence: 3,
    href: "/risiko/R8",
  },
  {
    id: "R9",
    title: "For brede service accounts / tokens",
    tooltip: "Maskin-til-maskin kontoer har for store scopes og roteres ikke ofte nok",
    probability: 3,
    consequence: 5,
    href: "/risiko/R9",
  },
  {
    id: "R10",
    title: "Mangelfull segmentering av admin-grensesnitt",
    tooltip: "Admin-endepunkter og kontrollplan er ikke tilstrekkelig isolert fra ordinær trafikk",
    probability: 2,
    consequence: 4,
    href: "/risiko/R10",
  },
  {
    id: "R11",
    title: "Uklare eierskap til tilgangspakker",
    tooltip: "Ingen tydelig systemeier/rolle-eier for tilgangspakker og godkjenningsflyt",
    probability: 2,
    consequence: 3,
    href: "/risiko/R11",
  },
  {
    id: "R12",
    title: "Mangler tydelig break-glass prosess",
    tooltip: "Nødtilgang finnes, men er ikke godt nok kontrollert, testet og logget",
    probability: 2,
    consequence: 5,
    href: "/risiko/R12",
  },
  {
    id: "R13",
    title: "For sen deprovisjonering av integrasjoner",
    tooltip: "Integrasjoner og API-nøkler blir ikke deaktivert når systemer fases ut",
    probability: 2,
    consequence: 4,
    href: "/risiko/R13",
  },
  {
    id: "R14",
    title: "Manglende enhetlig policy for admin-tilgang",
    tooltip: "Ulike team har ulike praksiser; gir uforutsigbarhet og hull i kontrollene",
    probability: 3,
    consequence: 2,
    href: "/risiko/R14",
  },
  {
    id: "R15",
    title: "Tilgangsstyring uten attestering",
    tooltip: "Tilganger tildeles uten tilstrekkelig attestering (formål, varighet, godkjenner)",
    probability: 3,
    consequence: 4,
    href: "/risiko/R15",
  },
];



export default function RiskMatrixPage() {
  return (
    <main style={{ padding: 24, display: "grid", gap: 16 }}>
      <RiskMatrix risks={mockRisks} size={400} />
    </main>
  );
}
