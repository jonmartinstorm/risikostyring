import { Button } from "@navikt/ds-react";
import { PageBlock } from "@navikt/ds-react/Page";
import styles from "./page.module.css";
import { ThumbUpIcon } from "@navikt/aksel-icons";

export default function Home() {
  return (
    <main>
      <PageBlock width="md" gutters>
        <h1>Velkommen til Risikovurderingsapp mockup</h1>
      </PageBlock>
    </main>
  );
}