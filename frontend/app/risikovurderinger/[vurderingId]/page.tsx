import Link from "next/link";
import { notFound } from "next/navigation";
import { Heading } from "@navikt/ds-react";
import { PageBlock } from "../../components/Page";
import { RisikoTiltakTable } from "./RisikoTiltakTable";
import { getRisikoerForVurdering, getVurdering, getPersonerForVurdering } from "./api";
import { risikoerToRows } from "./rows";
import { RiskMatrix, type Risk } from "../../components/RiskMatrix/RiskMatrix";

export default async function RisikovurderingDetaljPage({
  params,
}: {
  params: Promise<{ vurderingId: string }>;
}) {
  const { vurderingId } = await params;
  
  const vurdering = await getVurdering(vurderingId);
  if (!vurdering) return notFound();
  
  const risikoer = await getRisikoerForVurdering(vurderingId);
  const rows = risikoerToRows(risikoer);
  
  const personer = await getPersonerForVurdering(vurderingId);
  
  return (
    <PageBlock as="main" width="xl" gutters style={{ paddingTop: "1.5rem" }}>
    <Link href="/risikovurderinger" style={{ textDecoration: "none" }}>
    ← Tilbake til risikovurderinger
    </Link>
    
    <Heading level="1" size="large" style={{ marginTop: "0.75rem" }}>
    {vurdering.navn}
    </Heading>
    
    <div style={{ marginTop: "1rem" }}>
    <div>Team/område: {vurdering.teamOmrade}</div>
    <div>Status: {vurdering.status ?? "—"}</div>
    <div>Oppsummering: {vurdering.oppsummering ?? "—"}</div>
    <div>Beskrivelse: {vurdering.beskrivelse ?? "—"}</div>
    <div>
    Personer: {personer.map((p) => p.navn).join(", ")}
    </div>
    <div>
    Oppdatert:{" "}
    {vurdering.updatedAt
      ? new Date(vurdering.updatedAt).toLocaleString("nb-NO", {
        dateStyle: "short",
        timeStyle: "short",
      })
      : "—"}
      </div>
      </div>
      
      <div
      style={{
        display: "flex",
        gap: "3rem",
        marginTop: "2rem",
        flexWrap: "wrap",
        alignItems: "flex-start",
      }}
      >
      
      
      <div>
      <Heading level="2" size="medium">
      Før tiltak
      </Heading>
      <RiskMatrix risks={risikoer} size={300} />
      </div>
      
      <div>
      <Heading level="2" size="medium">
      Etter tiltak
      </Heading>
      <RiskMatrix risks={risikoer} size={300} />
      </div>
      </div>
      
      <Heading level="2" size="medium" style={{ marginTop: "2rem" }}>
      Risikoer og tiltak (risikoer: {risikoer.length}, rader: {rows.length})
      </Heading>
      
      <RisikoTiltakTable rows={rows} />
      </PageBlock>
    );
  }
  