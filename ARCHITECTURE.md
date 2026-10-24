# ARCHITECTURE.md — Toxico Index

## 1. Components
- **Header & Search Bar (`.top-bar`)**: Sticky solid header (`--bg-elevated`) with course brand wordmark, segmented navigation rail (`.top-nav`), and action controls (`.top-actions`): live search input (`/` shortcut via semantic `<kbd class="search-kbd">`), icon-only Favorites filter toggle (`#favorites-filter-btn`), Reset History button (`#reset-history-btn` with inline two-step confirmation, dynamic `aria-label`, and 3s auto-timeout), and Dark/Light theme toggle (`#theme-toggle`).
- **Workbench Header & Status Rail (`.workbench-header` & `.workbench-title-row`)**: Visible `<h1 class="workbench-title">Toxico Index</h1>` paired inline with a single-line `tabular-nums` summary (`#workbench-summary`) and a 4-option status filter rail (`.status-filter-rail`: `All`, `Unread`, `Reviewed`, `Saved`).
- **Unobstructed Vertical Progress Spine (`.spine-track`, `.spine-fill`, `.section-node`)**: Dedicated left gutter lane on `.page-shell` with an origin pin at the workbench header, `10px` circular section milestone nodes (`.section-node`) aligned to each section header, and the scroll-reactive `#spine-finale` cat & Erlenmeyer flask scene managed by `updateBottomRunway()` and `syncFinaleSpineAlignment()` (anchoring `.spine-track`'s bottom edge to the finale SVG junction node at `y=150` when sections are visible, without artificial bottom spacer padding).
- **Data-Driven Sections & Grid (`#sections-root`)**: Rendered from a single `SECTIONS_DATA` catalog into categorized sections (Video Lectures, Clinical Guidelines, Articles & Papers) with automatic item counting (`visible / total`) and shared `<svg><symbol>` icon definitions.
- **Resource Link Cards (`.link-card`)**: Flat whisper-bordered cards (`--line`) with precomputed `data-key` attributes, shared SVG `<use>` icons, clean single-focus resource titles, accessible touch-sized favorite star buttons (`.fav-btn`), and inline `Visited` / `New` status badges.

## 2. Data Flow
- **Data-First Catalog (`SECTIONS_DATA`)**: Declarative JavaScript array defining sections, sub-topic groups, titles, URLs, icon references, and `added` date strings.
- **Direct `href` LocalStorage Persistence**:
  - `localStorage.toxico_favorites`: Stores starred resource `href` keys via a `Set`.
  - `localStorage.toxico_visited`: Tracks clicked resource `href` keys and renders `.visited` styling + `Visited` indicator.
  - `localStorage.toxico_collapsed`: Persists user-collapsed section IDs via `collapsedSectionIds` `Set` without being overwritten by temporary search/filter expansions.
  - `localStorage.toxico_theme`: Persists `light` or `dark` theme preference.
- **Cached DOM Descriptors, Finale Runway Alignment & Scroll Progress (`requestAnimationFrame`)**:
  - `sectionRecords` caches section, header, toggle button, title, meta, group, and card DOM references once at startup, eliminating per-frame `querySelector` overhead.
  - `updateBottomRunway()` toggles `#spine-finale` visibility based on visible sections (setting `spineTrack.style.bottom = '24px'` when empty) and invokes `syncFinaleSpineAlignment()` to align the horizontal branch path and anchor `.spine-track`'s bottom offset directly to the `#spine-finale` SVG junction node (`y=150`) without artificial bottom spacer padding.
  - `scheduleScrollUpdate()` throttles scroll and resize calculations via `requestAnimationFrame`, aligning both `.is-active` section highlighting and `#spine-fill` height directly to the top-bar offset threshold (`topBarHeight + 20px`).

## 3. Repository Structure
- `/index.html`: Single-page application with CSS design tokens, shared SVG symbols, declarative resource data, and interactive state logic.
- `/server.js`: Minimal Express static server on `0.0.0.0:3000` serving `/pdfs`, `/docs`, and `/index.html`.
- `/pdfs/`: Clinical toxicology PDF guidelines (Ramathibodi Poison Center protocols).
- `/docs/ARDS_presentation.html`: Bilingual (TH/EN) 28-slide interactive ARDS fellowship deck with deduplicated medical image assets (`ARDS_IMAGES`).
