import { PageBlock } from "../components/Page";
import { RisikovurderingerPage } from "./Risikovurderinger";

export default function PageRisikovurderinger() {
  return (
    <PageBlock as="main" width="xl" gutters style={{ paddingTop: "1.5rem" }}>
      <RisikovurderingerPage />
    </PageBlock>
  );
}
