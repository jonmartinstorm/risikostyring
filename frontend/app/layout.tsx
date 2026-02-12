import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import "@navikt/ds-css";

import { Page } from "./components/Page";
import { AppHeader } from "./components/AppHeader";
import { AppFooter } from "./components/AppFooter";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "Risikostyring",
  description: "Intern PoC for risikovurderinger",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="no">
      <body className={`${geistSans.variable} ${geistMono.variable}`}>
        <Page footer={<AppFooter />}>
          <AppHeader />
          {children}
        </Page>
      </body>
    </html>
  );
}
