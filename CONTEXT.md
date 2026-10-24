# CONTEXT.md — Domain Context & ADR

## 1. Domain Glossary
- **Toxicology (Toxico)**: Clinical toxicology study resources for emergency medicine residents (R2/R3) and ER physicians.
- **Toxdrome / Toxicologic Syndrome**: Constellation of clinical signs and symptoms associated with specific drug/poison exposures.
- **EMTOX**: Emergency Medicine Toxicology lectures and guidelines.

## 2. Architectural Decision Records (ADR)
- **ADR-001: Minimalist Layout Preservation**: Retain the original clean, uncluttered bookmark grid layout without excessive UI components for optimal reading comfort.
- **ADR-002: Webex Link Removal**: Removed legacy Cisco Webex meeting room link (`mahidol.webex.com/...`) per user request.
- **ADR-003: Clinical Guidelines Addition**: Embedded local Ramathibodi Poison Center guidelines (Neurotoxic snakebites, Antivenom administration, Allergic reactions to antivenom, and Treatment of Calcium Channel Blocker Overdoses) under `/pdfs/`.
- **ADR-004: Refined Clinical Workbench (`tasteskill v2 --app`)**: Upgraded `index.html` to a clinical reference workbench with a visible `<h1>` header, divided 4-column KPI summary strip, status filter rail (`All` / `Unread` / `Reviewed` / `Saved`), unobstructed left spine lane with section milestone nodes, and Low-Chroma Architectural Stone (`#F4F4F2`) + Clinical Oxblood (`#9E1B32` / `#E04F67`) design tokens passing `lint.mjs --app` and `inspect.mjs --app` with `0 FAIL, 0 WARN`.

