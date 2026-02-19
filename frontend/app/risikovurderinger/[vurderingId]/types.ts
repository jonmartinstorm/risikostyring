export type RiskAssessment = {
  id: number;
  navn: string;
  teamOmrade: string;
  status: string | null;
  beskrivelse: string | null;
  oppsummering: string | null;
  createdAt: string;
  updatedAt: string;
};

export type Risiko = {
  id: number;
  vurderingId: number;
  navn: string;
  tema: string | null;
  beskrivelse: string | null;
  begrunnelse: string | null;
  sannsynlighet: number;
  konsekvens: number;
  createdAt: string;
  updatedAt: string;
};

export type Tiltak = {
  id: number;
  risikoId: number;
  navn: string;
  beskrivelse: string | null;
  status: string;
  createdAt: string;
  updatedAt: string;
};

export type Person = {
  id: number;
  navn: string;
  ident: string;
};
