import type { Risiko } from "./types";
import type { RisikoTiltakRow } from "./RisikoTiltakTable";

export function risikoerToRows(risikoer: Risiko[]): RisikoTiltakRow[] {
  return risikoer.map((r) => ({
    risikoId: r.id,
    risikoNavn: r.navn,
    tema: r.tema,
    s: r.sannsynlighet,
    k: r.konsekvens,
    tiltakNavn: "—",
    tiltakStatus: "—",
  }));
}
