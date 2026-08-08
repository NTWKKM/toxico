# ARCHITECTURE.md — Toxico Course Bookmarks

## 1. Components
- **Header & Command Bar**: Sticky top bar containing app title, live global search input, quick category/type filter pills, progress/stats counter, and dark/light theme switcher.
- **Category Sections & Grid**: Responsive CSS grid rendering link cards categorized into toxicological clinical modules (Introduction, Emergencies, Substances, Analgesics, Alcohols, Bites & Stings, Pesticides, Hazmat, Metals, Caustics, Methemoglobinemia, Plants/Mushrooms, Research Papers).
- **Resource Cards**: Interactive links with visual badges (Video vs Paper vs Article), favorite toggle button (star icon), watched/completed checkbox toggle, and smooth hover micro-interactions.
- **Empty State Component**: Fallback UI rendered dynamically when search or filter queries return zero matching cards.

## 2. Data Flow
- **Static Content Baseline**: HTML structure holds all course resources, metadata tags, YouTube URLs, and PubMed/emDocs references.
- **Client State Management (LocalStorage)**:
  - Theme state (`light` / `dark`) stored in `localStorage.theme`.
  - Favorites list stored as array of resource IDs/hrefs in `localStorage.toxico_favorites`.
  - Progress tracker (completed/watched resource hrefs) stored in `localStorage.toxico_completed`.
- **Search & Reactive Filter Loop**:
  - `input` listener on search bar normalizes search query (lowercase, trimmed).
  - Active filter tab state ("All", "Videos", "Articles", "Favorites", "Completed") filters elements by data attributes (`data-type`, `data-href`).
  - Hides empty subheadings (`h3`) and parent section containers when all nested cards are filtered out.
  - Updates progress summary bar dynamically.

## 3. Key Decisions
- **Zero-Dependency Native Stack**: Built with pure HTML5, vanilla CSS (CSS Variables + Glassmorphism), and Vanilla JS ES6 to guarantee offline-first operation, instant loading times, and zero build tool overhead.
- **LocalStorage Persistence**: Enables medical residents and emergency physicians to track study progress and bookmark high-yield clinical lectures without requiring external database or auth backend.
- **Progressive Enhancement**: Full search and view functionality works even without localStorage; localStorage adds personal study tracking seamlessly.
