"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import {
  Button,
  TextField,
  Textarea,
  Select,
  Alert,
} from "@navikt/ds-react";

type CreateRiskAssessment = {
  navn: string;
  teamOmrade: string;
  beskrivelse?: string | null;
  oppsummering?: string | null;
  status?: string | null;
};

type CreatedRiskAssessment = {
  id: number;
  navn: string;
  teamOmrade: string;
  beskrivelse: string | null;
  oppsummering: string | null;
  status: string | null;
  createdAt: string;
  updatedAt: string;
};

export function RisikovurderingCreateForm() {
  const router = useRouter();
  const [isSubmitting, setSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const [form, setForm] = useState<CreateRiskAssessment>({
    navn: "",
    teamOmrade: "",
    beskrivelse: "",
    oppsummering: "",
    status: "pågår",
  });

  function setField<K extends keyof CreateRiskAssessment>(key: K, value: CreateRiskAssessment[K]) {
    setForm((prev) => ({ ...prev, [key]: value }));
  }

  async function onSubmit(e: React.FormEvent) {
    e.preventDefault();
    setError(null);

    // frontend-validering (matcher backend)
    if (!form.navn.trim() || !form.teamOmrade.trim()) {
      setError("Navn og team/område er påkrevd.");
      return;
    }

    setSubmitting(true);
    try {
      // tilpass path hvis du har /api/v1 foran osv
      const res = await fetch("/api/v1/risikovurderinger", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          navn: form.navn,
          teamOmrade: form.teamOmrade,
          beskrivelse: form.beskrivelse?.trim() ? form.beskrivelse : null,
          oppsummering: form.oppsummering?.trim() ? form.oppsummering : null,
          status: form.status?.trim() ? form.status : null,
        }),
      });

      if (res.status === 400) {
        setError("Ugyldig input (400). Sjekk feltene og prøv igjen.");
        return;
      }

      if (!res.ok) {
        setError(`Kunne ikke opprette (HTTP ${res.status}).`);
        return;
      }

      const created = (await res.json()) as CreatedRiskAssessment;

      // gå til detaljsiden
      router.push(`/risikovurderinger/${created.id}`);
      router.refresh();
    } catch (err) {
      setError("Noe gikk galt ved innsending. Prøv igjen.");
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <form onSubmit={onSubmit} style={{ marginTop: "1.5rem" }}>
      {error && (
        <Alert variant="error" style={{ marginBottom: "1rem" }}>
          {error}
        </Alert>
      )}

      <TextField
        label="Navn"
        value={form.navn}
        onChange={(e) => setField("navn", e.target.value)}
        required
      />

      <div style={{ marginTop: "1rem" }}>
        <TextField
          label="Team/område"
          value={form.teamOmrade}
          onChange={(e) => setField("teamOmrade", e.target.value)}
          required
        />
      </div>

      <div style={{ marginTop: "1rem" }}>
        <Select
          label="Status"
          value={form.status ?? ""}
          onChange={(e) => setField("status", e.target.value)}
        >
          <option value="pågår">pågår</option>
          <option value="godkjent">godkjent</option>
          <option value="arkivert">arkivert</option>
          <option value="">—</option>
        </Select>
      </div>

      <div style={{ marginTop: "1rem" }}>
        <Textarea
          label="Oppsummering"
          value={form.oppsummering ?? ""}
          onChange={(e) => setField("oppsummering", e.target.value)}
          minRows={3}
        />
      </div>

      <div style={{ marginTop: "1rem" }}>
        <Textarea
          label="Beskrivelse"
          value={form.beskrivelse ?? ""}
          onChange={(e) => setField("beskrivelse", e.target.value)}
          minRows={4}
        />
      </div>

      <div style={{ marginTop: "1.5rem", display: "flex", gap: "1rem" }}>
        <Button type="submit" loading={isSubmitting}>
          Opprett
        </Button>
        <Button
          type="button"
          variant="secondary"
          onClick={() => router.push("/risikovurderinger")}
          disabled={isSubmitting}
        >
          Avbryt
        </Button>
      </div>
    </form>
  );
}
