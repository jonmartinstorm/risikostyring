import Link from "next/link";
import { BodyShort, Heading } from "@navikt/ds-react";
import { PageBlock } from "./Page";

function FooterLink({ href, children }: { href: string; children: React.ReactNode }) {
  return (
    <Link
      href={href}
      style={{
        color: "rgba(255,255,255,0.85)",
        textDecoration: "none",
        display: "inline-block",
        paddingBlock: "0.25rem",
      }}
    >
      {children}
    </Link>
  );
}

export function AppFooter() {
  return (
    <footer style={{ background: "var(--vurderings-blue)", color: "white", marginTop: "2rem" }}>
      <PageBlock as="footer" width="2xl" gutters style={{ paddingBlock: "2rem" }}>
        <div
          style={{
            display: "grid",
            gap: "2rem",
            gridTemplateColumns: "repeat(1, minmax(0, 1fr))",
          }}
        >
          {/* CSS for responsiv grid uten ekstern fil */}
          <style>{`
            @media (min-width: 768px) {
              .footer-grid {
                grid-template-columns: 1.2fr 1fr 1fr 0.8fr;
              }
            }
          `}</style>

          <div className="footer-grid" style={{ display: "grid", gap: "2rem" }}>
            {/* Venstre: tittel + meta */}
            <div>
              <Heading level="2" size="small" style={{ marginTop: 0 }}>
                Risikostyring
              </Heading>

              <div style={{ marginTop: "0.75rem", opacity: 0.85 }}>
                <BodyShort size="small">© 2026</BodyShort>
                <BodyShort size="small">Intern PoC</BodyShort>
              </div>
            </div>

            {/* Kolonne 1 */}
            <div>
              <Heading level="3" size="xsmall" style={{ marginTop: 0 }}>
                Snarveier
              </Heading>
              <FooterLink href="/risikovurderinger">Risikovurderinger</FooterLink>
              <br />
              <FooterLink href="/tiltak">Tiltak</FooterLink>
              <br />
              <FooterLink href="/risikoregister">Risiko-register</FooterLink>
              <br />
              <FooterLink href="https://cybersjekk.no/">Egenevaluering sikkerhet</FooterLink>
              <br />
              <FooterLink href="/om">Om</FooterLink>
            </div>

            {/* Kolonne 2 */}
            <div>
              <Heading level="3" size="xsmall" style={{ marginTop: 0 }}>
                Om løsningen
              </Heading>
              <FooterLink href="/om">Hva er Risikostyring?</FooterLink>
              <br />
              <FooterLink href="/personvern">Personvern</FooterLink>
              <br />
              <FooterLink href="/tilgjengelighet">Tilgjengelighet</FooterLink>
            </div>

            {/* Kolonne 3 */}
            <div>
              <Heading level="3" size="xsmall" style={{ marginTop: 0 }}>
                Finn oss
              </Heading>
              <FooterLink href="https://github.com/">GitHub</FooterLink>
              <br />
              <FooterLink href="https://slack.com/">Slack</FooterLink>
            </div>
          </div>
        </div>
      </PageBlock>
    </footer>
  );
}
