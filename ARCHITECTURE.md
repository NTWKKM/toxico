# ARCHITECTURE.md — Toxico Course Bookmarks

## 1. Components
- **Header & Search Bar**: Compact sticky header with course title, live search input, "Reset History" button, and dark/light mode theme toggle button.
- **Category Sections & Grid**: Responsive CSS grid rendering course bookmarks categorized into clinical toxicology topics (Intro, Emergencies, Psychotropic, Analgesics, Alcohols, Bites & Stings, Pesticides, Hazmat, Metals, Caustics, Methemoglobinemia, Plants/Mushrooms, Articles & Papers).
- **Resource Link Cards**: Clean minimal link cards with subtle hover elevation, SVG icons, and dynamic `VISITED` status tags.

## 2. Data Flow
- **Static Content Baseline**: HTML markup containing YouTube lecture links, PubMed/emDocs research paper references, and clinical guidelines / PDF documents (Ramathibodi Poison Center protocols).
- **Visited Links Tracking (LocalStorage)**:
  - List of clicked link URLs stored in `localStorage.toxico_visited`.
  - Automatically highlights visited link cards and appends `<span class="tag-visited">Visited</span>`.
  - "Reset History" button clears `localStorage.toxico_visited` and resets UI state.
- **Search & Filter Loop**:
  - Live `input` listener on search input filters cards in real time.
  - Hides empty subheadings (`h2`/`h3`) and section containers dynamically when search query has no matching cards.
- **Theme Persistence**: Dark/Light mode theme state toggled via `data-theme` attribute on `<html>`.

## 3. Repository Structure
- `/index.html`: Single-page application markup, CSS design tokens, and interactive filtering/scroll logic.
- `/server.js`: Express static server listening on `0.0.0.0:3000`.
- `/ARCHITECTURE.md`, `/CONTEXT.md`, `/DESIGN.md`: Root-level architecture, domain context, and UI design specifications for agent inspection.
- `/pdfs/`: Clinical toxicology PDF guidelines (`Neurotoxic snakebites.pdf`, `วิธีให้ Antivenom neurototoxin Snake.docx.pdf`, `Allergic reaction to antivenom_Ver 2.pdf`).
- `/docs/`: Course documents & interactive HTML presentations (`ARDS_presentation.html`).

## 4. Key Decisions
- **Minimalist Single-Page Architecture**: Kept intentionally clean and lightweight.
- **Visited Link History Persistence**: Built-in simple click tracking via `localStorage` without external tracking servers.
- **Webex Link Removal**: Removed legacy Cisco Webex meeting room link (`mahidol.webex.com/...`).
- **Clinical Guidelines Integration**: Added Ramathibodi Poison Center Neurotoxic Snakebite, Antivenom Administration, and Allergic Reactions to Antivenom PDFs under `/pdfs/`.
