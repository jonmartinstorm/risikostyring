import type { ReactNode } from "react";

type Width = "text" | "md" | "lg" | "xl" | "2xl" | "full";

const maxWidthPx: Record<Exclude<Width, "full">, number> = {
  text: 576,
  md: 768,
  lg: 1024,
  xl: 1280,
  "2xl": 1440,
};

export function Page({ children, footer }: { children: ReactNode; footer?: ReactNode }) {
  return (
    <div style={{ minHeight: "100vh", display: "flex", flexDirection: "column" }}>
      <div style={{ flex: 1 }}>{children}</div>
      {footer ? <div>{footer}</div> : null}
    </div>
  );
}

export function PageBlock({
  children,
  as = "div",
  width = "2xl",
  gutters = false,
  style,
}: {
  children: ReactNode;
  as?: "div" | "main" | "header" | "footer" | "section";
  width?: Width;
  gutters?: boolean;
  style?: React.CSSProperties;
}) {
  const Component = as;

  const maxWidth =
    width === "full" ? "100%" : `${maxWidthPx[width as Exclude<Width, "full">]}px`;

  return (
    <Component
      style={{
        width: "100%",
        maxWidth,
        margin: "0 auto",
        paddingInline: gutters ? "1rem" : undefined,
        ...style,
      }}
    >
      <style>{`
        @media (min-width: 768px) {
          .gutters-md { padding-inline: 3rem; }
        }
      `}</style>
      <div className={gutters ? "gutters-md" : undefined}>{children}</div>
    </Component>
  );
}
