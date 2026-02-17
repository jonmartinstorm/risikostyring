"use client";
import Link from "next/link";
import { Table } from "@navikt/ds-react";

type Risikovurdering = {
  id: number;
  navn: string;
  teamOmrade: string;
  status: string;
  createdAt: string;
};


export function RisikovurderingerTabellClient( {
    initialData,
}: {
  initialData: Risikovurdering[];
}) {
  return (
    <Table>
      <Table.Header>
        <Table.Row>
          <Table.HeaderCell scope="col">Navn</Table.HeaderCell>
          <Table.HeaderCell scope="col">Team</Table.HeaderCell>
          <Table.HeaderCell scope="col">Status</Table.HeaderCell>
          <Table.HeaderCell scope="col">Opprettet</Table.HeaderCell>
        </Table.Row>
      </Table.Header>

      <Table.Body>
        {initialData.map((r) => (
          <Table.Row key={r.id}>
            <Table.HeaderCell scope="row">
              <Link href={`/risikovurderinger/${r.id}`} style={{ textDecoration: "none" }}>
                {r.navn}
              </Link>
            </Table.HeaderCell>
            <Table.DataCell>{r.teamOmrade}</Table.DataCell>
            <Table.DataCell>{r.status}</Table.DataCell>
            <Table.DataCell>
              {new Date(r.createdAt).toLocaleDateString("no-NO")}
            </Table.DataCell>
          </Table.Row>
        ))}
      </Table.Body>
    </Table>
  );
}