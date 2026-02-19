import { notFound } from "next/navigation";
import { Heading, BodyLong, Detail } from "@navikt/ds-react";
import { PageBlock } from "../../../../components/Page";
import { getRisikoerForVurdering, getVurdering } from "../../api";

export default async function RisikovurderingDetaljPage({
  params,
}: {
  params: Promise<{ vurderingId: string, risikoId: string }>;
}) {
  const { vurderingId, risikoId } = await params;

  const vurdering = await getVurdering(vurderingId);
  if (!vurdering) return notFound();

  const risikoer = await getRisikoerForVurdering(vurderingId);

  const risikoIdNum = Number(risikoId);
  if (!Number.isFinite(risikoIdNum)) return notFound();

  const risiko = risikoer.find((r) => String(r.id) === String(risikoId));
  if (!risiko) return notFound();

  return (
    <PageBlock as="main" width="lg" gutters style={{ paddingTop: "2rem" }}>
      <Heading level="1" size="large">
        {risiko.navn}
      </Heading>

      <Detail style={{ marginTop: "0.5rem" }}>
        Risiko-ID: {risiko.id} • Tema: {risiko.tema ?? "—"}
      </Detail>

      <div style={{ marginTop: "2rem" }}>
        <Heading level="2" size="small">
          Beskrivelse
        </Heading>
        <BodyLong>
          {risiko.beskrivelse ?? "Ingen beskrivelse registrert."}
        </BodyLong>
      </div>

      <div style={{ marginTop: "2rem" }}>
        <Heading level="2" size="small">
          Begrunnelse
        </Heading>
        <BodyLong>
          {risiko.begrunnelse ?? "Ingen begrunnelse registrert."}
        </BodyLong>
      </div>

      <div style={{ marginTop: "2rem" }}>
        <Heading level="2" size="small">
          Risikovurdering
        </Heading>
        <BodyLong>
          Sannsynlighet: <strong>{risiko.sannsynlighet}</strong>
          <br />
          Konsekvens: <strong>{risiko.konsekvens}</strong>
          <br />
          Risikonivå:{" "}
          <strong>
            {risiko.sannsynlighet * risiko.konsekvens}
          </strong>
        </BodyLong>
      </div>

      <Detail style={{ marginTop: "2rem" }}>
        Opprettet: {new Date(risiko.createdAt).toLocaleString()}
        <br />
        Sist oppdatert: {new Date(risiko.updatedAt).toLocaleString()}
      </Detail>
    </PageBlock>
  );
}
