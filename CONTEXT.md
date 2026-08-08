# CONTEXT.md — Domain Context & ADR

## 1. Domain Glossary
- **Toxicology (Toxico)**: Clinical toxicology study resources for emergency medicine residents (R2/R3) and ER physicians.
- **Toxdrome / Toxicologic Syndrome**: Constellation of clinical signs and symptoms associated with specific drug/poison exposures (e.g. anticholinergic, cholinergic, sympathomimetic, opioid, sedative-hypnotic).
- **EMTOX**: Emergency Medicine Toxicology lectures and guidelines.
- **Methemoglobinemia**: Blood disorder where hemoglobin cannot effectively release oxygen to tissue; high-yield clinical topic in ER training.
- **Hazmat & PPE**: Hazardous materials resuscitation and personal protective equipment procedures for chemical exposures.

## 2. Architectural Decision Records (ADR)
- **ADR-001: Offline-First Single Page Application Structure**: Keep all core logic, styling, and icons within a self-contained web page to allow emergency medicine staff to save and access bookmarks offline without external web app dependencies.
- **ADR-002: Webex Link Removal**: Removed legacy Cisco Webex meeting room link (`mahidol.webex.com/...`) per user request to maintain relevant and active reference materials only.
- **ADR-003: Braun / Bauhaus Design System Pivot**: Shifted from glossy translucent glassmorphism to Dieter Rams / Bauhaus functional industrial design (matte warm off-white/charcoal surfaces, crisp grid lines, high-contrast typography, signal orange accents, tactile control switches).
- **ADR-004: Category & Type Tagging System**: Attach `data-type="video|article"` and `data-category="..."` attributes to cards to support dual-layer filtering (Search + Type Filter + Category Jump).
