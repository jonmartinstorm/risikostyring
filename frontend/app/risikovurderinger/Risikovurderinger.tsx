import {RisikovurderingerTabellClient} from "./RisikovurderingerTabellClient"

type Risikovurdering = {
  id: number;
  navn: string;
  teamOmrade: string;
  status: string;
  createdAt: string;
};

async function getRisikovurderinger(): Promise<Risikovurdering[]> {
  const base = process.env.BACKEND_INTERNAL_URL ?? "http://localhost:4001";
  const res = await fetch(`${base}/api/v1/risikovurderinger`, {
    cache: "no-store",
  });

  if (!res.ok) {
    throw new Error(`Kunne ikke hente risikovurderinger (${res.status})`);
  }

  return res.json();
}

export async function RisikovurderingerPage() {
  const data = await getRisikovurderinger();

  return <RisikovurderingerTabellClient initialData={data}/>;
}
