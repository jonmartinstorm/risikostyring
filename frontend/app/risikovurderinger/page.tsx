import { PageBlock } from "../components/Page";
import Link from "next/link";
import { RisikovurderingerPage } from "./Risikovurderinger";

export default function PageRisikovurderinger() {
  return (
    <PageBlock as="main" width="xl" gutters style={{ paddingTop: "1.5rem" }}>
      <Link href="/risikovurderinger/ny">+ Ny risikovurdering</Link>

      <RisikovurderingerPage />
    </PageBlock>
  );
}
