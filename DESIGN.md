# DESIGN.md — Design Tokens & Minimalist UI Specs

## 1. Design Philosophy (Radical Minimalism)
- **60-30-10 Palette Budget**:
  - **60% Canvas**: Warm Alabaster (`#FAF9F6`) in light mode; Carbon (`#0C0C0B`) in dark mode.
  - **30% Structure**: Pure Elevated White (`#FFFFFF`) / Dark Surface (`#141413`) with 1px hairline borders (`rgba(20, 20, 19, 0.08)`).
  - **10% Accent**: Clinical Vermilion (`#C83E2B` light / `#E05A47` dark) reserved strictly for active states, focus rings, and quiet indicators.
- **Typography (2+1 Rule)**:
  - Display: `Outfit` / `IBM Plex Sans Thai`
  - Body: `Plus Jakarta Sans` / `IBM Plex Sans Thai`
  - Monospace & Tabular Numerals: `JetBrains Mono` (`tabular-nums`)

## 2. UI Architecture
- **Top Bar Contract**: Single-row sticky header with 3 zones (`Toxico Index` wordmark — single-line section links — search & theme/reset controls).
- **Zero-Pill Metadata**: Counts (`54 lectures · YouTube`) and status markers (`· New`, `· Visited`) use unboxed typography instead of colored pill boxes.
- **Affordance-Only Icons**: Sub-topic headings rely purely on tabular index numbers (`01.1`–`03.2`) without decorative icons; cards use quiet monochrome stroke icons that highlight on hover.
