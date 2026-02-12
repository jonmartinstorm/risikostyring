import Link from "next/link";
import { BodyShort, Heading } from "@navikt/ds-react";
import { PageBlock } from "./Page";

function NavLink({ href, children }: { href: string; children: React.ReactNode }) {
  return (
    <Link
      href={href}
      style={{
        color: "inherit",
        textDecoration: "none",
        padding: "0.5rem 0.75rem",
        borderRadius: 6,
      }}
    >
      {children}
    </Link>
  );
}

export function AppHeader() {
  return (
    <header
      style={{
        position: "sticky",
        top: 0,
        zIndex: 50,
        background: "var(--vurderings-blue)",
        color: "white",
      }}
    >
      <PageBlock as="header" width="2xl" gutters style={{ paddingBlock: "0.75rem" }}>
        <div style={{ display: "flex", alignItems: "center", gap: "1.25rem" }}>
          {/* Tittel */}
          <Link href="/" style={{ textDecoration: "none", color: "inherit" }}>
            <Heading level="1" size="small">
              Risikostyring
            </Heading>
          </Link>

          {/* Navigasjon */}
          <nav aria-label="Hovedmeny" style={{ display: "flex", gap: "0.25rem" }}>
            <NavLink href="/risikovurderinger">
              <BodyShort weight="semibold">Risikovurderinger</BodyShort>
            </NavLink>
            <NavLink href="/risikoregister">
              <BodyShort>Risiko-register</BodyShort>
            </NavLink>
            <NavLink href="/minside">
              <BodyShort>Min Side</BodyShort>
            </NavLink>
          </nav>

          {/* Høyreside */}
          <div style={{ marginLeft: "auto" }}>
            <BodyShort size="small" style={{ opacity: 0.7 }}>
              DEV
            </BodyShort>
          </div>
        </div>
      </PageBlock>
    </header>
  );
}
