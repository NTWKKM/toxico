# ARCHITECTURE.md — Toxico Index

## 1. Components
- **Header & Search Bar (`.top-bar`)**: Sticky solid header (`--bg-elevated`) with course brand wordmark, segmented navigation rail (`.top-nav`), and action controls (`.top-actions`): live search input (`/` shortcut via semantic `<kbd class="search-kbd">`), icon-only Favorites filter toggle (`#favorites-filter-btn`), Reset History button (`#reset-history-btn` with inline two-step confirmation, dynamic `aria-label`, and 3s auto-timeout), and Dark/Light theme toggle (`#theme-toggle`).
- **Workbench Status Rail & Divided KPI Strip (`.workbench-header` & `.workbench-strip`)**: Screen-reader-accessible `<h1 class="sr-only">Toxico Index</h1>`, status filter rail (`.status-filter-rail`: `All`, `Unread`, `Reviewed`, `Saved`), and a single 4-column divided KPI strip (`1px` internal hairlines) displaying live `tabular-nums` metrics for Total Catalog, Clinical Guidelines, Reviewed Progress, and Saved Bookmarks.
- **Unobstructed Vertical Progress Spine (`.spine-track`, `.spine-fill`, `.spine-node`)**: Dedicated left gutter lane (`padding-left: 1.5rem` on `.page-shell`) with an origin pin at the workbench header, `12px` circular section milestone nodes (`.spine-node`) aligned to each section header, and the scroll-reactive `#spine-finale` cat & Erlenmeyer flask scene anchored directly beneath the final section without artificial scroll runway.
- **Data-Driven Sections & Grid (`#sections-root`)**: Rendered from a single `SECTIONS_DATA` catalog into categorized sections (Video Lectures, Clinical Guidelines, Articles & Papers) with automatic item counting (`visible / total`) and shared `<svg><symbol>` icon definitions.
- **Resource Link Cards (`a.link-card`)**: Flatwhisper-bordered cards (`--line`) with precomputed `data-key` attributes, shared SVG `<use>` icons, concise clinical source/format sublines (`.link-subline`), accessible touch-sized favorite star buttons (`.fav-btn`), and inline `Reviewed` / `New` status badges.

## 2. Data Flow
- **Data-First Catalog (`SECTIONS_DATA`)**: Declarative JavaScript array defining sections, sub-topic groups, titles, URLs, icon references, and `isNew` flags.
- **Backward-Compatible & Collision-Safe LocalStorage Persistence**:
  - `legacyToCanonicalMap` transparently upgrades legacy stripped keys to full canonical keys on load while preserving full external URLs to prevent cross-domain key collisions.
  - `localStorage.toxico_favorites`: Stores starred resource keys via a normalized `Set`.
  - `localStorage.toxico_visited`: Tracks clicked resource keys and renders `.visited` styling + `Visited` indicator.
  - `localStorage.toxico_collapsed`: Persists user-collapsed section IDs via `collapsedSectionIds` `Set` without being overwritten by temporary search/filter expansions.
  - `localStorage.toxico_theme`: Persists `light` or `dark` theme preference.
- **Cached DOM Descriptors, Dynamic Bottom Runway & Scroll Progress (`requestAnimationFrame`)**:
  - `sectionRecords` caches section, header, kicker, title, meta, group, and card DOM references once at startup, eliminating per-frame `querySelector` overhead.
  - `updateBottomRunway()` dynamically calculates and applies bottom spacer padding on `.page-shell` (while keeping `.spine-track` bounded to `#sections-root`) so every section header—including lower or collapsed sections—can scroll to a consistent `20px` offset below `.top-bar`.
  - `scheduleScrollUpdate()` throttles scroll and resize calculations via `requestAnimationFrame`, aligning both `.is-active` section highlighting and `#spine-fill` height directly to the top-bar offset threshold (`topBarHeight + 20px`).

## 3. Repository Structure
- `/index.html`: Single-page application with CSS design tokens, shared SVG symbols, declarative resource data, and interactive state logic.
- `/server.js`: Minimal Express static server on `0.0.0.0:3000` serving `/pdfs`, `/docs`, and `/index.html`.
- `/pdfs/`: Clinical toxicology PDF guidelines (Ramathibodi Poison Center protocols).
- `/docs/ARDS_presentation.html`: Bilingual (TH/EN) 28-slide interactive ARDS fellowship deck with deduplicated medical image assets (`ARDS_IMAGES`).
