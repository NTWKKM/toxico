# ARCHITECTURE.md — Toxico Course Bookmarks

## 1. Components
- **Header & Search Bar**: Compact sticky header with course title, live search input, and dark/light mode theme toggle button.
- **Category Sections & Grid**: Responsive CSS grid rendering course bookmarks categorized into clinical toxicology topics (Intro, Emergencies, Psychotropic, Analgesics, Alcohols, Bites & Stings, Pesticides, Hazmat, Metals, Caustics, Methemoglobinemia, Plants/Mushrooms, Articles & Papers).
- **Resource Link Cards**: Clean minimal link cards with subtle hover elevation and SVG icons.

## 2. Data Flow
- **Static Content Baseline**: HTML markup containing YouTube lecture links and PubMed/emDocs research paper references.
- **Search & Filter Loop**:
  - Live `input` listener on search input filters cards in real time.
  - Hides empty subheadings (`h2`/`h3`) and section containers dynamically when search query has no matching cards.
- **Theme Persistence**: Dark/Light mode theme state toggled via `data-theme` attribute on `<html>`.

## 3. Key Decisions
- **Minimalist Single-Page Architecture**: Kept intentionally simple and uncluttered for fast loading, zero external library overhead, and clean readability on desktop and mobile.
- **Webex Link Removal**: Removed legacy Cisco Webex meeting room link (`mahidol.webex.com/...`) per user request.
