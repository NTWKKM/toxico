# DESIGN.md — Design Tokens & Minimalist UI Specs

## 1. Design Philosophy (`Leonxlnx/taste-skill` + WCAG AA Contrast)
- **60-30-10 Palette Budget & Surface Delta**:
  - **60% Canvas**: Warm Architectural Stone (`#F3F1EC`) in light mode; Deep Obsidian (`#0B0B0A`) in dark mode, establishing a distinct ~6% luminance step against elevated cards.
  - **30% Structure**: Pure Elevated White (`#FFFFFF`) / Dark Surface (`#171715`) with crisp 1px structural borders (`#D5D1C8` light / `#2E2E2A` dark) and subtle elevation (`0 1px 2px`).
  - **10% Accent**: Clinical Vermilion (`#C83E2B` light / `#E85D4A` dark) reserved strictly for active spine progress, focus rings, and quiet indicators.
- **Typography (2+1 Rule)**:
  - Display: `Outfit` / `IBM Plex Sans Thai`
  - Body: `Plus Jakarta Sans` / `IBM Plex Sans Thai`
  - Monospace & Tabular Numerals: `JetBrains Mono` (`tabular-nums`)

## 2. Component Contrast Architecture (Card, Menu, Button)
- **Menu (`.top-bar` & `.top-nav`)**: High-clarity sticky bar (`rgba(255,255,255,0.94)` / `rgba(20,20,19,0.94)`) housing a recessed segmented navigation rail (`--bg-subtle`). The active section tab inverts to high-contrast ink (`background: var(--ink-primary); color: var(--bg-elevated)`).
- **Buttons & Controls (`.btn-ghost`, `.search-box`)**: Solid elevated surface (`--bg-elevated`) with strong structural borders (`--line-strong`) and `font-weight: 600` primary text, inverting cleanly on hover (`background: var(--ink-primary); color: var(--bg-elevated)`).
- **Cards (`a.link-card`)**: High-contrast elevated cards with crisp borders (`--line`), readable monochrome icons (`--ink-secondary`), high-contrast carbon/ivory hover borders (`--line-hover`), and an accessible recessed visited state (`--bg-visited`) that preserves >5.5:1 text contrast.
