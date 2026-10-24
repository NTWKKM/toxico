# DESIGN.md — Design Tokens & Clinical Workbench UI Specs

## 1. Design Philosophy (`tasteskill v2 --app` + WCAG AA Contrast)

- **60-30-10 Palette Budget & Surface Delta**:
  - **60% Canvas**: Low-Chroma Architectural Stone (`#F4F4F2`) in light mode; Deep Obsidian (`#0B0B0B`) in dark mode, avoiding banned warm-cream/terracotta HSL ranges while establishing a clean luminance step against elevated surfaces.
  - **30% Structure**: Pure Elevated White (`#FFFFFF`) / Dark Surface (`#141414`) with whisper `1px` structural borders (`#E6E6E1` light / `#232323` dark, contrast ratio `< 1.45:1`) and zero resting `box-shadow` or `backdrop-filter`.
  - **10% Accent**: Clinical Oxblood (`#9E1B32` light with `6.9:1` WCAG AA contrast against the `#F4F4F2` light canvas; `#E04F67` dark) reserved strictly for active spine progress, milestone nodes, active section titles, and focus rings.
- **Typography (2-Family Budget + Tabular Numerals)**:
  - Display & Section Headers: `Outfit` / `IBM Plex Sans Thai` (`600` weight, `-0.02em` tracking)
  - Body, Controls & Numerals: `Plus Jakarta Sans` / `IBM Plex Sans Thai` with `font-variant-numeric: tabular-nums` on all counters, KPIs, and keyboard hints (`<kbd>`).

## 2. Component Contrast Architecture (Header, Workbench Strip, Spine, Cards)

- **Top Bar (`.top-bar` & `.top-nav`)**: Solid opaque sticky bar (`--bg-elevated`) with a whisper `1px` bottom border (`--line`) and recessed segmented navigation rail (`--bg-subtle`). Active tabs invert cleanly (`background: var(--ink-primary); color: var(--bg-elevated)`).
- **Workbench Status Rail & Divided KPI Strip (`.workbench-header` & `.workbench-strip`)**: 4-option status filter rail (`All` / `Unread` / `Reviewed` / `Saved`) paired with a single 4-column divided KPI strip separated by `1px` internal hairlines.
- **Unobstructed Left Spine Lane (`.spine-track`, `.spine-node`, `#spine-finale`)**: Dedicated left gutter (`padding-left: 1.5rem`) so the `2px` progress line and `12px` section milestone nodes never intersect card borders or text.
- **Cards (`a.link-card`)**: Flat 2-line cards with whisper `1px` borders (`--line`), title + clinical source/format subline (`.link-subline`), and recessed reviewed state (`--bg-visited`) preserving WCAG AA contrast.
