"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import { Table } from "@navikt/ds-react";

type Risikovurdering = {
  id: number;
  navn: string;
  teamOmrade: string;
  status: string;
  createdAt: string;
};

export function RisikovurderingerPage() {
  const [data, setData] = useState<Risikovurdering[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetch("/api/v1/risikovurderinger")
      .then((res) => {
        if (!res.ok) {
          throw new Error("Kunne ikke hente risikovurderinger");
        }
        return res.json();
      })
      .then(setData)
      .catch((err) => setError(err.message))
      .finally(() => setLoading(false));
  }, []);

  if (loading) return <p>Laster…</p>;
  if (error) return <p>Feil: {error}</p>;

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
        {data.map((r) => (
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
