# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A [Quarto](https://quarto.org/) website for **MATH 2025: Multiple Regression Analysis** (Fall 2026, College of Idaho). Scaffolded from the Fall 2025 offering (`MATH2025FA25`). Deployed to GitHub Pages (`quarto publish gh-pages`) at `https://ericfriedlander.github.io/math2025-fa26/`, source at `github.com/EricFriedlander/math2025-fa26`.

See `TODO.md` for everything that still needs updating before the semester starts — check it before assuming any date, link, or number in this repo is current.

## Global principles

- **Ask clarifying questions one at a time** when requirements are ambiguous, before making changes.
- Keep this file up to date with changes to the workflow or project structure.
- Prefer commas, colons, and regular dashes to em dashes in student-facing documents.

## R packages

Managed via `renv`. Run `renv::install(...)` + `renv::snapshot()` when adding a new package to a `.qmd` file.

## Architecture

| Path | Purpose |
|------|---------|
| `_quarto.yml` | Master config: site title, sidebar nav, theming, footer, output format |
| `index.qmd` | Course homepage — the schedule, as a hand-written markdown table (see the `math2025-schedule` skill) |
| `computing-*.qmd` | Computing access / inference-summary / R-resources pages |
| `_extensions/quarto-ext/fontawesome/` | Vendored Font Awesome shortcode extension (`{{< fa ... >}}`), used by the schedule table |
| `.claude/skills/math2025-canvas/` | This course's Canvas conventions (course/group IDs, module & assignment naming, due-date rules, description template) — pairs with the global `canvas-course-editor` skill, which handles the API mechanics |
| `_freeze/` | Quarto's computed-output cache (`execute: freeze: auto`) — not committed by default here |
| `_site/` | Generated static site — do not edit directly, not committed |

All assignments (readings, activities, homework, project) and slides are published to the schedule page (`index.qmd`, the site homepage), a hand-written markdown table.

### Computing platform: CofI Posit Workbench

FA26 uses the College of Idaho's own Posit Workbench (RStudio Server), not Deepnote and not Posit Cloud. Students sign in with their CofI email/password and work in `.qmd` files, in a subfolder they create per assignment. `computing-access.qmd` is the student-facing setup page.

The Workbench URL is centralized in `_variables.yml` as `rstudio_url` and referenced everywhere via `{{< var rstudio_url >}}` — the servers are being updated mid-semester and the address may change, so a future URL change should be a single edit there. The one exception is the sidebar "RStudio" tool `href` in `_quarto.yml`: Quarto's `{{< var >}}` shortcode only substitutes inside rendered `.qmd` content, not inside `_quarto.yml` itself, so that href is a literal string kept in sync by hand (both spots carry a comment pointing at the other).

Many `ae/` and `hw/` files still carry a legacy `.ipynb` twin from when Deepnote/Jupyter was under consideration. These are not rendered (`_quarto.yml` excludes `*.ipynb`) and are not being kept in sync — treat the `.qmd` as the only source of truth. `.github/prompts/ConvertQmdToJupyter.prompt.md` is legacy and unused.

## Schedule (`index.qmd`) conventions

Column layout, icon cells, numbering rules, and how to publish the next commented-out row are in the `math2025-schedule` skill (`.claude/skills/math2025-schedule/`). Load it before editing `index.qmd`.

## Key conventions

- **Nav registration**: new pages must be added to the `contents:` list in `_quarto.yml` sidebar to appear in navigation.
- **Slide metadata**: each slide deck sets its own `footer`/`logo`/`bibliography` in YAML front matter (no shared `_metadata.yml` in this repo, unlike newer course sites).
- **Freeze**: `execute: freeze: auto` — computed outputs cache in `_freeze/`. This has been observed to reuse stale content after a prose-only edit (no code chunk changes) to a file that was already rendered once this session — a second `quarto render` can silently keep the old text instead of picking up the edit. If a rendered page in `_site/` doesn't reflect a recent source change, delete that file's `_freeze/<path>/` entry (or `.quarto/` and `_freeze/` entirely for a guaranteed-clean rebuild) and re-render before concluding the edit didn't take.

## Theming

Ported from the PPOL-6500 course site (`~/Documents/Teaching/ppol-6500-summer2026`) so both courses share one College of Idaho visual identity: Atkinson Hyperlegible font, Coyote Purple (`#533860`) sidebar/footer, gold (`#FFCB70`) dark-mode links, and a working light/dark toggle (the sidebar stays purple in both themes, so `style/math2025.scss` carries a few CSS overrides forcing the tool-icon and dark-mode-toggle colors to stay legible against it). Light theme: `style/math2025.scss`; dark-mode overrides: `style/dark.scss`; both wired into `format.html.theme` in `_quarto.yml`. `slides/slides.scss` carries the matching reveal.js look plus this course's existing helper classes (`.question`, `.poll`, `.appex`, `.goal`, `.smaller`, etc.) — keep new slide helper classes there, not in the site theme files.

## Exercise / answer boxes

AEs and homeworks mark up tasks with two custom fenced divs instead of hand-numbered `### Exercise N` headings:

```markdown
::: {.exercise}
Task text goes here.
:::

::: {.answer}

:::
```

`.exercise` boxes auto-number themselves via a CSS counter (`counter-reset: exercise` on `body`, incremented in `.exercise::before`), so exercises can be added, removed, or reordered without renumbering by hand. `.answer` boxes render as an empty dashed box labeled "Your answer" for students to fill in. The canonical rule set is `style/exercise-boxes.css`, wired site-wide via `format.html.css` in `_quarto.yml`.

Students download and render AE/HW `.qmd` files standalone in their own RStudio Workbench folder, outside this project, so the site's `_quarto.yml` and its `css:` key never apply there. Every AE/HW `.qmd` therefore also carries its own copy of the same rules inline, via `format.html.include-in-header.text` in its YAML (see `ae/ae-01-getting-started.qmd` for the pattern to copy). If `style/exercise-boxes.css` changes, copy the update into every AE/HW's inline `<style>` block too — the two are intentionally duplicated, not shared by reference, because a standalone render has no way to reach `style/`.
