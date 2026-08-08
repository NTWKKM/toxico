# DESIGN.md — Braun / Bauhaus Design System & UI Specs

## 1. Design Philosophy
Inspired by **Dieter Rams (Braun)** and **Bauhaus Principles** ("Form follows function", honest minimalism, bold geometric grid, high legibility, tactile visual feedback, zero ornamental glassmorphism).

## 2. Design Tokens

### Typography & Grid
- **Font Stack**: `Inter`, -apple-system, BlinkMacSystemFont, 'Helvetica Neue', Arial, sans-serif.
- **Font Weights**: 400 (Regular), 500 (Medium), 600 (Semi-Bold), 700 (Bold), 800 (Extra-Bold for display headers).
- **Letter Spacing**: `-0.02em` for headers, `0.05em` for uppercase labels & indicator badges.

### Light Mode Palette (Braun Pebble & Charcoal)
- **Primary Accent (Signal Amber/Orange)**: `#FF4500` (Braun Signal Orange)
- **Secondary Accent (Industrial Yellow)**: `#F59E0B` (Dieter Rams Dial Yellow)
- **Completed / Active Green**: `#10B981` (Signal Green LED)
- **Background Body**: `#F4F3EF` (Braun Off-White / Matte Pebble)
- **Card / Surface Background**: `#FFFFFF` (Solid Off-White Matte)
- **Control Bar Background**: `#EBE8E1` (Matte Recessed Panel)
- **Text Primary**: `#111111` (Deep Charcoal Ink)
- **Text Muted**: `#555555` (Slate Gray)
- **Border & Grid Color**: `#D1CDC2` (Solid Crisp 1.5px Border)

### Dark Mode Palette (Industrial Matte Charcoal)
- **Primary Accent (Signal Orange)**: `#FF6B35`
- **Secondary Accent (Industrial Yellow)**: `#FBBF24`
- **Completed / Active Green**: `#34D399`
- **Background Body**: `#121212` (Matte Carbon)
- **Card / Surface Background**: `#1C1C1C` (Solid Dark Panel)
- **Control Bar Background**: `#252525` (Recessed Control Surface)
- **Text Primary**: `#F0EFEA` (Warm Paper White)
- **Text Muted**: `#A0A0A0` (Medium Gray)
- **Border & Grid Color**: `#333333` (Crisp Contrast Lines)

## 3. Component Architecture & UI Controls
- **Header Panel**: Solid matte control surface with grid borders, clean typography, uppercase section label, and tactile rocker switch for light/dark mode.
- **Tactile Filter Tabs**: Recessed button panel with solid indicator pills that invert colors when selected (Braun radio-button feel).
- **Resource Cards**:
  - Crisp solid 1.5px border, subtle 2px offset border effect or clean flat inset shadow.
  - Signal LED dot or badge indicating type (`VIDEO` / `ARTICLE`).
  - Tactile favorite star button & checkmark completion toggle with distinct color signals.
- **Progress Tracker Gauge**: Geometric linear progress meter with percentage display and numerical breakdown (Total / Videos / Papers / Completed).

## 4. Accessibility & Principles
- Strict high-contrast ratio (WCAG AAA for text).
- Tactile keyboard focus states (`outline: 2px solid var(--primary)` with offset).
- Semantic HTML tags and screen reader accessibility attributes.
