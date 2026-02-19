import type { RiskAssessment, Risiko, Person } from "./types";

const BASE = process.env.BACKEND_INTERNAL_URL ?? "http://localhost:4001";

async function fetchJson<T>(url: string): Promise<T> {
  const res = await fetch(url, { cache: "no-store" });

  if (res.status === 404) throw Object.assign(new Error("Not found"), { code: 404 });
  if (!res.ok) {
    const body = await res.text().catch(() => "");
    throw new Error(`Fetch feilet (${res.status}): ${body}`);
  }

  return res.json() as Promise<T>;
}

export async function getVurdering(id: string): Promise<RiskAssessment | null> {
  try {
    return await fetchJson<RiskAssessment>(`${BASE}/api/v1/risikovurderinger/${id}`);
  } catch (e: any) {
    if (e?.code === 404) return null;
    throw e;
  }
}

export async function getRisikoerForVurdering(id: string): Promise<Risiko[]> {
  // krever at du har route: GET /risikovurderinger/{id}/risikoer
  return fetchJson<Risiko[]>(`${BASE}/api/v1/risikovurderinger/${id}/risikoer`);
}

export async function getPersonerForVurdering(id: string): Promise<Person[]> {
  return fetchJson<Person[]>(`${BASE}/api/v1/risikovurderinger/${id}/personer`);
}
