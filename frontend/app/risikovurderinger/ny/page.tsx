import Link from "next/link";
import { Heading } from "@navikt/ds-react";
import { PageBlock } from "../../components/Page";
import { RisikovurderingCreateForm } from "./RisikovurderingCreateForm";

export default function NyRisikovurderingPage() {
  return (
    <PageBlock as="main" width="md" gutters style={{ paddingTop: "1.5rem" }}>
      <Link href="/risikovurderinger" style={{ textDecoration: "none" }}>
        ← Tilbake
      </Link>

      <Heading level="1" size="large" style={{ marginTop: "0.75rem" }}>
        Ny risikovurdering
      </Heading>

      <RisikovurderingCreateForm />
    </PageBlock>
  );
}
