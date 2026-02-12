import Link from "next/link";
import { notFound } from "next/navigation";
import { Heading } from "@navikt/ds-react";
import { PageBlock } from "../../components/Page";
import { RisikoTiltakTable, type RisikoTiltakRow } from "./RisikoTiltakTable";

type Tiltak = {
  id: number;
  risiko_id: number;
  navn: string;
  beskrivelse: string | null;
  status: string;
  created_at: string;
  updated_at: string;
};

type Risiko = {
  id: number;
  vurdering_id: number;
  navn: string;
  tema: string | null;
  beskrivelse: string | null;
  begrunnelse: string | null;
  sannsynlighet: number;
  konsekvens: number;
  created_at: string;
  updated_at: string;
  tiltak: Tiltak[];
};

type Vurdering = {
  id: number;
  navn: string;
  team_omrade: string;
  status: string | null;
  beskrivelse: string | null;
  oppsummering: string | null;
  created_at: string;
  updated_at: string;
  risikoer: Risiko[];
};

async function getVurdering(id: string): Promise<Vurdering | null> {
  const res = await fetch(`/api/v1/risikovurderinger/${id}`, { cache: "no-store" });

  
  if (res.status === 404) return null;

  if (!res.ok) {
    const body = await res.text().catch(() => "");
    throw new Error(`Kunne ikke hente risikovurdering (${res.status}): ${body}`);
  }

  return res.json();
}

export default async function RisikovurderingDetaljPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;

  const vurdering = await getVurdering(id);
  if (!vurdering) return notFound();

  const risikoer = vurdering.risikoer ?? [];

  const rows: RisikoTiltakRow[] = risikoer.flatMap((r) => {
    const tiltak = r.tiltak ?? [];
    if (tiltak.length === 0) {
      return [
        {
          risikoId: r.id,
          risikoNavn: r.navn,
          tema: r.tema,
          s: r.sannsynlighet,
          k: r.konsekvens,
          tiltakNavn: "—",
          tiltakStatus: "—",
        },
      ];
    }

    return tiltak.map((t) => ({
      risikoId: r.id,
      risikoNavn: r.navn,
      tema: r.tema,
      s: r.sannsynlighet,
      k: r.konsekvens,
      tiltakNavn: t.navn,
      tiltakStatus: t.status ?? "—",
    }));
  });

  return (
    <PageBlock as="main" width="xl" gutters style={{ paddingTop: "1.5rem" }}>
      <Link href="/risikovurderinger" style={{ textDecoration: "none" }}>
        ← Tilbake til risikovurderinger
      </Link>

      <Heading level="1" size="large" style={{ marginTop: "0.75rem" }}>
        {vurdering.navn}
      </Heading>

      <div style={{ marginTop: "1rem" }}>
        <div>Team/område: {vurdering.team_omrade}</div>
        <div>Status: {vurdering.status ?? "—"}</div>
        <div>Oppsummering: {vurdering.oppsummering ?? "—"}</div>
        <div>Beskrivelse: {vurdering.beskrivelse ?? "—"}</div>
      </div>

      <Heading level="2" size="medium" style={{ marginTop: "2rem" }}>
        Risikoer og tiltak (risikoer: {risikoer.length}, rader: {rows.length})
      </Heading>

      {/* Client component: kun rendering */}
      <RisikoTiltakTable rows={rows} />
    </PageBlock>
  );
}
