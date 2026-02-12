"use client";

import { Table } from "@navikt/ds-react";

export type RisikoTiltakRow = {
  risikoId: number;
  risikoNavn: string;
  tema: string | null;
  s: number;
  k: number;
  tiltakNavn: string;
  tiltakStatus: string;
};

export function RisikoTiltakTable({ rows }: { rows: RisikoTiltakRow[] }) {
  return (
    <Table>
      <Table.Header>
        <Table.Row>
          <Table.HeaderCell scope="col">Risiko</Table.HeaderCell>
          <Table.HeaderCell scope="col">Tema</Table.HeaderCell>
          <Table.HeaderCell scope="col">S</Table.HeaderCell>
          <Table.HeaderCell scope="col">K</Table.HeaderCell>
          <Table.HeaderCell scope="col">Tiltak</Table.HeaderCell>
          <Table.HeaderCell scope="col">Tiltakstatus</Table.HeaderCell>
        </Table.Row>
      </Table.Header>

      <Table.Body>
        {rows.map((row, idx) => (
          <Table.Row key={`${row.risikoId}-${idx}`}>
            <Table.HeaderCell scope="row">{row.risikoNavn}</Table.HeaderCell>
            <Table.DataCell>{row.tema ?? "—"}</Table.DataCell>
            <Table.DataCell>{row.s}</Table.DataCell>
            <Table.DataCell>{row.k}</Table.DataCell>
            <Table.DataCell>{row.tiltakNavn}</Table.DataCell>
            <Table.DataCell>{row.tiltakStatus}</Table.DataCell>
          </Table.Row>
        ))}
      </Table.Body>
    </Table>
  );
}
