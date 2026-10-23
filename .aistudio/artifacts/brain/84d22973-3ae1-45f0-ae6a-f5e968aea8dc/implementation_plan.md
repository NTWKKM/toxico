# Deterministic Section Scroll & Top-Bar Offset Alignment

This update refines the scroll and active-section detection mechanics so clicking any navigation tab in the top bar brings its corresponding section header to a guaranteed, uniform offset directly beneath the sticky top bar, while synchronizing the active highlight and vertical progress spine to that exact geometric threshold.

## User Review & Critical Decisions

> [!IMPORTANT]
> Both key architectural decisions were confirmed during clarification to eliminate scroll clamping on lower or collapsed sections and unify click vs. scroll highlighting.

- **Confirmed Decision 1 — Dynamic Bottom Spacer Runway**: Dynamically compute and apply bottom runway spacing so even the final section (`Articles`) or collapsed sections have sufficient scrollable document height to position their `.section-header` at the exact offset below `.top-bar`.
- **Confirmed Decision 2 — Unified Top-Bar Offset Threshold**: Align both the active navigation state (`.is-active`) and the vertical progress spine tip (`#spine-fill`) to a single deterministic viewport offset measured from the bottom edge of `.top-bar`.

---

## 1. Overview & Core Concept

- **What It Does**: Standardizes section navigation and scroll-spy tracking around a single viewport anchor line (`topBarBottom + sectionOffset`), ensuring every top-nav click lands at the exact same visual gap below the sticky header and immediately highlights the intended section without post-scroll drift.
- **Target Audience / Persona**: Clinical toxicology fellows, residents, and instructors rapidly jumping between lecture videos, clinical guidelines, and reference papers across desktop and mobile viewports.
- **Key Value**: Eliminates the common scroll-clamping bug where short or bottom sections cannot reach the top of the viewport, and prevents active-tab flicker or desynchronization when smooth scrolling finishes.

---

## 2. User Experience & Visual Design

- **Key User Flows**:
  1. **Top-Nav Section Jump**: Clicking `Lectures`, `Guidelines`, or `Articles` intercepts default hash jumping, uncollapses the target section if collapsed, clears conflicting search/favorite filters if the section is hidden, updates the dynamic bottom runway, and smoothly scrolls the window so the target `.section-header` lands at a consistent `20px` gap below `.top-bar`.
  2. **Brand Wordmark Reset**: Clicking `Toxico Index` smoothly scrolls back to `top: 0` and resets the active state to the first visible section.
  3. **Continuous Scroll & Collapse Sync**: Expanding/collapsing sections, resizing the viewport, or filtering resources immediately recalculates the required bottom runway and updates the spine fill and active tab.
- **Visual Identity & Theme**:
  - Preserves the high-contrast Alabaster (`#F3F1EC`) and Carbon Ink (`#121211`) / Obsidian (`#0B0B0A`) clinical editorial palette, `Outfit` + `Plus Jakarta Sans` + `JetBrains Mono` (`tabular-nums`) typography, and Clinical Vermilion (`#C83E2B` / `#E85D4A`) spine accent.
  - Ensures the vertical `.spine-track` terminates cleanly at the bottom of the last visible section rather than stretching into empty bottom spacer runway.
- **Interactive Feedback & Motion**:
  - Smooth programmatic scrolling (`window.scrollTo({ top, behavior: 'smooth' })`) paired with a scroll-target lock that holds the clicked section active during transit and seamlessly hands off to the threshold detector upon arrival.

---

## 3. Key Product Decisions & Trade-Offs

- **Decision 1: Programmatic Offset Scrolling Over Native CSS Hash Jumps**
  - *Chosen Approach*: Intercept `.top-nav a` clicks with `preventDefault()` and compute the exact target scroll position using `window.scrollY + headerRect.top - (topBarHeight + offsetGap)`.
  - *Why*: Native `#hash` jumps rely on static `scroll-margin-top`, which does not adapt when `.top-bar` wraps on narrower viewports or when a collapsed section expands on click. Measuring `.top-bar.getBoundingClientRect().bottom` guarantees pixel-accurate placement at any viewport width.
  - *Alternatives Considered*: Static media-query `scroll-margin-top` values, which fail when dynamic layout changes occur during the click handler.
- **Decision 2: Dynamic Bottom Runway Calculation**
  - *Chosen Approach*: Calculate the minimum extra bottom padding needed so the last visible section header can reach the target offset line (`topBarHeight + offsetGap`) at maximum scroll, applying it dynamically while keeping `.spine-track` bounded to the actual content height.
  - *Why*: Without extra scroll runway at the bottom of the page, clicking `Guidelines` or `Articles` (or collapsing upper sections) hits `maxScroll` early, leaving the target header halfway down the screen and unable to trigger top-offset highlighting.
  - *Alternatives Considered*: Fixed large `padding-bottom: 80vh`, which leaves excessive blank space when not needed or still falls short on tall monitors.

---

## 4. Technical Architecture & Data Strategy *(Technical Reference)*

- **Architecture & Component Diagram**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│                       Sticky Top Bar (.top-bar)                         │
│  [Brand Wordmark]      [Segmented Nav (.top-nav)]      [Search/Filters] │
└───────────────┬────────────────────────┬───────────────────────┬────────┘
                │                        │                       │
                ▼                        ▼                       ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                Viewport Offset Controller & Runway Engine               │
│  • Measures live .top-bar height + consistent visual gap (20px)         │
│  • Computes & applies dynamic bottom runway so last section reaches top │
│  • Scrolls window to exact target Y on nav click                        │
└────────────────────────────────────────┬────────────────────────────────┘
                                         │
                                         ▼
┌─────────────────────────────────────────────────────────────────────────┐
│            Unified Spine & Active Section Synchronizer (rAF)            │
│  • Anchor Line: anchorViewportY = topBarBottom + offsetGap +triggerLead │
│  • Updates #spine-fill height to match anchorViewportY along track      │
│  • Toggles .is-active on .top-nav & .section, .is-reached on headers/h3 │
└─────────────────────────────────────────────────────────────────────────┘
```

- **Data Model & State**:
  - `HEADER_OFFSET_GAP` (`20px`): Consistent visual breathing room between the bottom border of `.top-bar` and the top of `.section-header`.
  - `navTargetSectionId` & `navTargetScrollY`: Tracks an active programmatic scroll in progress until `window.scrollY` reaches `navTargetScrollY` (within `2px` tolerance) or user input/timeout expires.
- **Interactive Component & State Mapping**:
  - **Top-Nav Click Handler**: Uncollapses target section if needed -> clears filter if target section is hidden -> calls `updateBottomRunway()` synchronously -> computes exact `targetScrollY` for `targetRecord.header` -> sets `navTargetSectionId` -> invokes `window.scrollTo({ top: targetScrollY, behavior: 'smooth' })` -> triggers `scheduleScrollUpdate()`.
  - **Runway & Spine Bounds Calculator (`updateBottomRunway`)**: Invoked on filter change, section collapse toggle, and window resize. Computes how much additional scroll distance is required for the last visible `.section-header` to align with `topBarHeight + HEADER_OFFSET_GAP`, updates the page bottom padding accordingly, and constrains `.spine-track` height to the bottom of the last visible section.
  - **Threshold Scroll Synchronizer (`updateScrollProgress`)**: Uses the unified anchor line just below `.top-bar` to determine `lineTipViewportY` and `activeSectionId`, guaranteeing that when any `.section-header` rests at the scroll offset, its `.spine-title` and `.top-nav` link are deterministically marked `.is-active`.
