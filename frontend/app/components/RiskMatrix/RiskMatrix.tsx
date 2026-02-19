// components/RiskMatrix/RiskMatrix.tsx
import Link from "next/link";
import styles from "./RiskMatrix.module.css";
import type { Risiko } from "@/app/risikovurderinger/[vurderingId]/types";

export type Risk = {
  id: string;
  title: string;
  probability: 1 | 2 | 3 | 4 | 5;
  consequence: 1 | 2 | 3 | 4 | 5;
  
  href?: string;          // hvor vi klikker videre
  tooltip?: string;       // det som vises på hover
};


type Props = {
  risks: Risiko[];
  size?: number; // px, total bredde/høyde på matrisen
};

function clamp(v: number, min: number, max: number) {
  return Math.max(min, Math.min(max, v));
}

// En enkel “traffic light”-logikk (juster terskler slik du vil)
type CellLevel = "green" | "yellow" | "red";

const RISK_MATRIX: CellLevel[][] = [
  // Konsekvens: 1     2       3       4       5
  /* S=5 */ ["yellow","yellow","red",  "red",  "red"],
  /* S=4 */ ["yellow","yellow","yellow","red",  "red"],
  /* S=3 */ ["green", "yellow","yellow","yellow","red"],
  /* S=2 */ ["green", "green", "yellow","yellow","yellow"],
  /* S=1 */ ["green", "green", "green", "yellow","yellow"],
];

export function getCellLevel(
  probability: 1 | 2 | 3 | 4 | 5,
  consequence: 1 | 2 | 3 | 4 | 5
): CellLevel {
  // probability 5 skal være øverst → index 0
  const row = 5 - probability;
  const col = consequence - 1;
  return RISK_MATRIX[row][col];
}



// Deterministisk jitter så prikker ikke ligger 100% oppå hverandre
function hashToUnit(str: string) {
  let h = 2166136261;
  for (let i = 0; i < str.length; i++) {
    h ^= str.charCodeAt(i);
    h = Math.imul(h, 16777619);
  }
  // 0..1
  return ((h >>> 0) % 1000) / 1000;
}

export function RiskMatrix({ risks, size = 520 }: Props) {
  const gridSize = size;
  const cell = gridSize / 5;
  
  return (
    <div className={styles.wrap}>
    
    <div className={styles.matrixRow}>
    <div className={styles.yLabel}>SANNSYNLIGHET</div>
    
    <div
    className={styles.grid}
    style={{ width: gridSize, height: gridSize }}
    aria-label="Risikomatrise 5x5"
    role="img"
    >
    {/* Celler */}
    {Array.from({ length: 5 }).map((_, rowIdx) => {
      // Vi vil ha 5 øverst, 1 nederst (som klassisk matrise)
      const prob = (5 - rowIdx) as 1 | 2 | 3 | 4 | 5;
      
      return Array.from({ length: 5 }).map((_, colIdx) => {
        const cons = (colIdx + 1) as 1 | 2 | 3 | 4 | 5;
        const level = getCellLevel(prob, cons);
        
        return (
          <div
          key={`${prob}-${cons}`}
          className={`${styles.cell} ${styles[level]}`}
          style={{
            left: colIdx * cell,
            top: rowIdx * cell,
            width: cell,
            height: cell,
          }}
          aria-label={`Sannsynlighet ${prob}, konsekvens ${cons}`}
          />
        );
      });
    })}
    
    {/* Prikker */}
    {risks.map((r) => {
      const rowIdx = 5 - r.sannsynlighet;
      const colIdx = r.konsekvens - 1;
      
      const jx = (hashToUnit(r.id + "x") - 0.5) * 0.5;
      const jy = (hashToUnit(r.id + "y") - 0.5) * 0.5;
      
      const x = colIdx * cell + cell * (0.5 + jx);
      const y = rowIdx * cell + cell * (0.5 + jy);
      
      const safeX = clamp(x, colIdx * cell + 10, (colIdx + 1) * cell - 10);
      const safeY = clamp(y, rowIdx * cell + 10, (rowIdx + 1) * cell - 10);
      
      const tooltip = r.navn;
      const href = `/risikovurderinger/${r.vurderingId}/risiko/${r.id}`;
      
      return (
        <Link
        key={r.id}
        href={href}
        className={styles.dotLink}
        style={{ left: safeX, top: safeY }}
        title={tooltip}
        aria-label={`${r.id}: ${tooltip}`}
        >
        <span className={styles.dot} />
        <span className={styles.dotLabel}>{r.id}</span>
        
        {/* Custom tooltip */}
        <span className={styles.tooltip}>
        <strong>{r.id}</strong>
        <br />
        {tooltip}
        </span>
        </Link>
      );
    })}
    
    </div>
    </div>
    
    <div className={styles.xLabelRow}>
    <div className={styles.xSpacer} />
    <div
    className={styles.xLabel}
    style={{ width: gridSize }}
    >KONSEKVENS</div>
    </div>
    </div>
  );
}

