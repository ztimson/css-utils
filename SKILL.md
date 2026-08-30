---
name: CSS Utilities
description: How to style all HTML websites using @ztimson/css-utils (bootstrap inspired)
modified: 2026-08-29T00:00:00.000Z
---

# SCSS Utility Framework

Two files: `_theme.scss` (utility classes) and `_components.scss` (styled elements). No build step config needed beyond Sass with the `sass:map` module. Import both once globally, theme before components.

## Theme Setup

All colors/tokens live in `:root` as CSS custom properties — edit these, not the utility classes:

```scss
--theme-background
--theme-background-contrast
--theme-primary
--theme-primary-contrast
--theme-accent
--theme-accent-contrast

--theme-info
--theme-success
--theme-warn
--theme-danger
--theme-black
--theme-white

--theme-animation
--theme-content-width
--theme-font
--theme-radius

// Light/dark aware variables (auto via `light-dark()`):
--theme-surface
--theme-border
--theme-muted
--theme-text
--theme-darker (transparent overlay)
--theme-lighter (transparent overlay)
--theme-shade      // = darker in light mode, lighter in dark mode
--theme-shade-alt  // inverse of --theme-shade

// Breakpoints & spacing
$breakpoints: (xs: 0, sm: 576px, md: 768px, lg: 992px, xl: 1200px);
$sizes: (0: 0, 1: 0.25rem, 2: 0.5rem, 3: 1rem, 4: 1.5rem, 5: 2.5rem);
```

Every color in `$variant-colors` (`primary, accent, background, surface, info, success, warn, danger, muted, border, text, black, white`) auto-generates `--theme-{color}-lighter` / `-darker` CSS vars (`color-mix` 80% toward white/black). These back the `-lighter`/`-darker` utility classes below — don't hand-write them.

Force a scheme on any element: `.theme-light` / `.theme-dark`, defaults to system preference.

## "Fix" Classes (reboot/reset helpers)

Apply `.fix` on `body`/root wrapper for all resets, or pick individual ones:

| Class            | Purpose                                                     |
|------------------|---------------------------------------------------------------|
| `.fix-anchor`    | Styled `<a>` links using `--theme-primary`                  |
| `.fix-button`    | `cursor: pointer` on enabled buttons                        |
| `.fix-dom`       | 100% height/width, no margin/padding, box-sizing border-box |
| `.fix-focus`     | Removes outline/tap highlight                               |
| `.fix-font`      | Base font sizing/weights for headings & form elements       |
| `.fix-scrollbar` | Styled webkit scrollbars using `--theme-muted`               |
| `.fix`           | All of the above                                             |

Other misc: `.center` (absolute centering), `.clamp` (max content width), `.reset` (`all: revert`).

## Color Utilities

Pattern: `.b-{color}` (border), `.bg-{color}` (background + auto contrast text), `.fg-{color}` (text color).

Base colors: `black, white, background, background-contrast, primary, primary-contrast, accent, accent-contrast, surface, border, text, muted, lighter, darker, info, success, warn, danger`

- `primary` and `accent` auto-apply their `-contrast` color as text/decoration when used via `.bg-primary` / `.bg-accent`.
- `lighter` / `darker` here are the transparent shade overlays, not color variants.

**Lighter/darker color variants** (`.bg-{color}-lighter`, `.bg-{color}-darker`, `.fg-{color}-lighter`, `.fg-{color}-darker` — no border variant) for every color in `$variant-colors`: `primary, accent, background, surface, info, success, warn, danger, muted, border, text, black, white`.

`.bg-shade` / `.bg-shade-alt` (scheme-aware shade), `.bg-transparent`.

### Glow

`.bg-glow-{primary|accent|info|success|warn|danger}{,-sm,-lg}` — radial glow from top-left corner, spread fixed at 110%, intensity varies by suffix (`-sm`=25%, none=50%, `-lg`=75%). Combine with any background: `.bg-black.bg-glow-primary-lg`.

## Typography (`.fs-*`)

- Weight/style: `fs-bolder, fs-bold, fs-normal, fs-lighter, fs-italic, fs-norm`
- Decoration: `fs-none, fs-strike, fs-underline` (combinable)
- Size scale: `fs-1`(1rem) → `fs-7`(2.5rem)
- Wrapping: `fs-break, fs-truncate, fs-nowrap, fs-wrap`
- Case: `fs-lowercase, fs-uppercase, fs-capitalize`

## Borders

- Radius: `.br-circle, .br-pill`, plus scaled `.br{t|tl|tr|b|bl|br}-{0-5}` (size keys from `$sizes`)
- Style: `.b-dash, .b-dot, .b-double, .b-none, .b-solid`
- Width (per breakpoint + direction): `.b-{0-5}`, `.b{s|t|e|b}-{0-5}` (s/t/e/b = left/top/right/bottom, logical-ish)

## Spacing (margin/padding)

Per breakpoint, uses `$sizes` keys (0–5):
- All sides: `.m-{s}`, `.p-{s}`
- Axis: `.mx-{s}, .my-{s}, .px-{s}, .py-{s}`
- Direction: `.m{s|t|e|b}-{size}`, `.p{s|t|e|b}-{size}`
- Auto: `.m-auto, .mx-auto, .my-auto, .m{dir}-auto`

## Flexbox / Grid Layout

- Display: `.d-{block|inline|inline-block|flex|inline-flex|grid|inline-grid|table|table-row|table-cell|none}`
- Direction shorthand: `.flex-c` (column), `.flex-cr` (col-reverse), `.flex-r`, `.flex-rr`; inline variants `.flex-inline-*`
- Grow/shrink: `.flex-fill, .flex-fill-even, .flex-grow-{0-3}, .flex-shrink-{0-3}`
- Wrap: `.flex-nowrap, .flex-wrap`
- `align-items/content/self-{start|end|center|baseline|stretch}`
- `justify-{start|end|center|between|around|evenly}`
- `gap-{0-5}`
- `order-{0-5}`

## Position / Sizing

- `.pos-{abs|fix|rel|static|stick}`
- Offsets (0–100 step via `$divisible`): `.top-{n}, .bottom-{n}, .start-{n}, .end-{n}` (percent)
- `.h-{n}`, `.w-{n}` (percent) + `.h-auto, .w-auto`
- `.fit-{contain|cover|fill|scale|none}` (object-fit)
- `.float-{start|end|none}`
- `.visible, .hidden` (visibility, not display)

## Other Utilities

- `.animate, .animate-none, .animate-color, .animate-opacity, .animate-pos, .animate-trans`
- `.o-{0,10,20,25,30,33,34,40,50,60,66,70,75,80,90,100}` (opacity)
- `.overflow{-x|-y}-{auto|hidden|scroll|visible}`
- `.shadow-none` to `.shadow-5`, directional `.shadow-{top|bottom|start|end}`, `.shadow-inset-{1,2}`, `.shadow-drop{,-sm,-lg}`, colored `.shadow-{primary|accent|info|success|warn|danger}`
- `.select-{all|auto|none|text}` (user-select)
- `.z-{0-5}`
- `.curs-{name}` — full CSS cursor keyword list (pointer, grab, not-allowed, zoom-in, etc.)
- `.hover:hover`, `.curs-hover` — brightness(125%) on hover

## Responsive Breakpoints

Every layout/spacing/flex utility above is generated per breakpoint suffix: `-sm-, -md-, -lg-, -xl-` (min-width media queries) plus a `-print-` variant for `@media print`. No suffix = base/xs.

Example: `w-md-50` → 50% width from `md` breakpoint up. `d-lg-flex` → flex display from `lg` up.

---

# Component Classes

Styled elements from `_components.scss`. Most support color variants by adding a modifier class matching a theme color: `info, success, warn, danger, primary, accent, black, white` (component-dependent, see below). No background/divider overrides needed — components are seamless with theme surfaces.

| Class | Element | Notes |
|---|---|---|
| `.banner` | `div` | Alert/notice box. Default `info`. Variants: `success, warn, danger, info, primary, accent, black, white`. |
| `.button` | `button` | Default neutral (`--theme-shade`). Variants: `info, success, danger, warn, primary, accent, white, black`. |
| `.card` | `div` | Surface panel, padding + subtle shadow. |
| `.checkbox` | `label > input[type=checkbox] + span` | Custom check, disabled fades label text. |
| `.radio` | `label > input[type=radio] + span` | Custom radio dot, disabled fades label text. |
| `.chip` | `span`/`div` | Small pill badge, muted text. |
| `.expander` | `details.expander > summary + .expander-body` | Must use native `<details>/<summary>`; marker rotates on `[open]`, body has top border. |
| `.indicator` | `div`/`span` | Round icon/status badge. Default `info`. Variants: `warn, danger, success, primary, accent, white, black`. |
| `.input` | `input`, `textarea.input` | Surface form control. `textarea.input` is vertically resizable. `input[type=color].input` styled swatch. |
| `.input-group` | `div > .input/.button/.select` children | Bootstrap-style joined controls, no inner borders/dividers; colored `.button` children keep their own bg/text. |
| `.select` | `select.select` | Styled dropdown; `[multiple]` gets scrollable option list with hover/checked highlighting. |
| `.range` | `input[type=range].range` | Custom track + thumb, themed via `--theme-accent`. |
| `.table` | `table.table` | Bordered table. `.select` modifier = clickable rows with accent hover highlight. `.striped` modifier = zebra rows. |
| `.toggle` | `label > input[type=checkbox] + span` | Switch-style checkbox. |

**Disabled state:** form controls (`.input`, `.select`, `.range`, `.checkbox`/`.radio`/`.toggle` inputs) fade to 50% opacity and mute their label `span` automatically via `:disabled`.

**Color variant convention:** where supported, just add the theme color name as a class alongside the component class, e.g. `<div class="banner danger">`, `<button class="button primary">`, `<span class="indicator success">`.
