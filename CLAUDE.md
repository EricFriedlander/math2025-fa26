# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A [Quarto](https://quarto.org/) website for **MATH 2025: Multiple Regression Analysis** (Fall 2026, College of Idaho). Scaffolded from the Fall 2025 offering (`MATH2025FA25`). Deployed to GitHub Pages (`quarto publish gh-pages`) at `https://ericfriedlander.github.io/math2025-fa26/`, source at `github.com/EricFriedlander/math2025-fa26`.

See `TODO.md` for everything that still needs updating before the semester starts — check it before assuming any date, link, or number in this repo is current.

## Global principles

- **Ask clarifying questions one at a time** when requirements are ambiguous, before making changes.
- Keep this file up to date with changes to the workflow or project structure.
- Prefer commas, colons, and regular dashes to em dashes in student-facing documents.

## Build and preview

```bash
quarto preview                # render + open a live-reloading local server
quarto render                 # full render to _site/
quarto render <file>.qmd      # render a single file (much faster than a full render)
quarto render syllabus.qmd --to pdf
quarto publish gh-pages       # deploy to GitHub Pages
```

A VS Code task ("Quarto Preview") runs `quarto preview` — `Ctrl+Shift+P` → "Tasks: Run Task".

### R packages

Managed via `renv` (`renv.lock`, `renv/`). All packages the site depends on are installed for R 4.6.1 and the project is in sync (`renv::status()`). A full `quarto render` succeeds, including the syllabus PDF. Run `renv::install(...)` + `renv::snapshot()` when adding a new package to a `.qmd` file.

## Architecture

| Path | Purpose |
|------|---------|
| `_quarto.yml` | Master config: site title, sidebar nav, theming, footer, output format |
| `index.qmd` | Course homepage — the schedule, as a hand-written markdown table (see below) |
| `about.qmd` | Course overview / instructor bio page (formerly the homepage) |
| `syllabus.qmd` | Full syllabus (renders to HTML and PDF) |
| `support.qmd`, `links.qmd` | Course-support and useful-links pages |
| `computing-*.qmd` | Computing access / inference-summary / R-resources pages |
| `slides/` | Reveal.js lecture slides, one `.qmd` per lecture, numbered to match the lecture number |
| `ae/` | Application exercises (in-class activities), numbered to match the lecture number |
| `hw/` | Homework assignments, numbered by assignment number (not lecture number) |
| `prepare/` | Pre-class reading assignments, numbered to match the lecture number |
| `project/` | Final project materials (overview, rubrics, pilot/preliminary/draft/final/poster pages) |
| `data/` | Datasets used in slides, AEs, and homework |
| `images/` | Site images (`logo.png`, etc.) |
| `style/` | Site/slide theming (`math2025.scss`, `dark.scss`, `slides.scss` is in `slides/` instead, `exercise-boxes.css`) |
| `_extensions/quarto-ext/fontawesome/` | Vendored Font Awesome shortcode extension (`{{< fa ... >}}`), used by the schedule table |
| `scripts/` | Helper scripts (e.g. `UpdateCensus.R`) not part of the rendered site |
| `_freeze/` | Quarto's computed-output cache (`execute: freeze: auto`) — not committed by default here |
| `_site/` | Generated static site — do not edit directly, not committed |

All assignments (readings, activities, homework, project) and slides are published to the schedule page (`index.qmd`, the site homepage), a hand-written markdown table.

### Computing platform: CofI Posit Workbench

FA26 uses the College of Idaho's own Posit Workbench (RStudio Server), not Deepnote and not Posit Cloud. Students sign in with their CofI email/password and work in `.qmd` files, in a subfolder they create per assignment. `computing-access.qmd` is the student-facing setup page.

The Workbench URL is centralized in `_variables.yml` as `rstudio_url` and referenced everywhere via `{{< var rstudio_url >}}` — the servers are being updated mid-semester and the address may change, so a future URL change should be a single edit there. The one exception is the sidebar "RStudio" tool `href` in `_quarto.yml`: Quarto's `{{< var >}}` shortcode only substitutes inside rendered `.qmd` content, not inside `_quarto.yml` itself, so that href is a literal string kept in sync by hand (both spots carry a comment pointing at the other).

Many `ae/` and `hw/` files still carry a legacy `.ipynb` twin from when Deepnote/Jupyter was under consideration. These are not rendered (`_quarto.yml` excludes `*.ipynb`) and are not being kept in sync — treat the `.qmd` as the only source of truth. `.github/prompts/ConvertQmdToJupyter.prompt.md` is legacy and unused.

Many `ae/` and `hw/` files still carry a legacy `.ipynb` twin from when Deepnote/Jupyter was under consideration. These are not rendered (`_quarto.yml` excludes `*.ipynb`) and are not being kept in sync — treat the `.qmd` as the only source of truth. `.github/prompts/ConvertQmdToJupyter.prompt.md` is legacy and unused.

## Schedule (`index.qmd`) conventions

The schedule used to be read from `schedule.xlsx` via `readxl`/`gt`; it is now a plain markdown pipe table written directly in `index.qmd`, one row per class day. It usually — but not always — corresponds to a class period (e.g. an assignment can be due on a day with no lecture). 10 columns:

1. **Lecture** — lecture number (1, 2, 3, …), blank if there's no lecture that day, `x` for a day marked off with no lecture (e.g. Thanksgiving break).
2. **DOW** — day of week (M, T, W, TH, F).
3. **Date** — class date, formatted like `Aug 26`.
4. **Topic** — the class topic or other relevant info; usually the slide title, shortened if needed.
5. **Prepare** — reading to complete before class, as a `{{< fa book >}}` shortcode link to `/prepare/xx-<slug>.qmd`.
6. **Slides** — that day's slides, `{{< fa laptop >}}` linking to `/slides/xx-<slug>.qmd`.
7. **AE** — that day's in-class activity, `{{< fa users >}}` linking to `/ae/xx-<slug>.qmd`.
8. **HW** — homework due that day, `{{< fa pen-to-square >}}` linking to `/hw/hw-xx.qmd`.
9. **Project** — project deliverable due that day (rare), `{{< fa chart-line >}}` linking to `/project/<slug>.qmd`.
10. **Notes** — published notes (e.g. "HW 1 due / HW 2 assigned").

Numbers on activities, slides, and prepare assignments track the **lecture** number. Homework numbers track the **assignment** number, independent of lecture.

**Icon cells**: when a row has no link for a given column, the cell still shows that column's icon, dimmed via `[{{< fa book >}}]{.fa-dim}` (the `.fa-dim` rule lives in `style/math2025.scss`) — this reproduces the old `gt`/`fontawesome` dimmed-icon look. Icons render via the vendored `_extensions/quarto-ext/fontawesome` extension.

**Publishing a row**: unpublished rows sit right below the visible table body, each wrapped individually in its own HTML comment (`<!-- | ... | -->`) so publishing is a one-line uncomment with no reordering — rows are already in date order and every commented row is contiguous with the ones above it. To publish the next row, delete its `<!-- ` / ` -->` markers; do not move it. A short reminder comment at the bottom of `index.qmd` explains this. Content inside HTML comments is never parsed, so links to not-yet-written files (a not-yet-created `/hw/hw-03.qmd`, etc.) raise no broken-link warnings until that row is published.

## Key conventions

- **Nav registration**: new pages must be added to the `contents:` list in `_quarto.yml` sidebar to appear in navigation.
- **Slide metadata**: each slide deck sets its own `footer`/`logo`/`bibliography` in YAML front matter (no shared `_metadata.yml` in this repo, unlike newer course sites).
- **Freeze**: `execute: freeze: auto` — computed outputs cache in `_freeze/`. This has been observed to reuse stale content after a prose-only edit (no code chunk changes) to a file that was already rendered once this session — a second `quarto render` can silently keep the old text instead of picking up the edit. If a rendered page in `_site/` doesn't reflect a recent source change, delete that file's `_freeze/<path>/` entry (or `.quarto/` and `_freeze/` entirely for a guaranteed-clean rebuild) and re-render before concluding the edit didn't take.
- **Ignored from render**: `TODO.md`, `README.md`, `CLAUDE.md` (see `.quartoignore`); `exam/*.qmd` and `*.ipynb` (see `_quarto.yml` render exclusions).

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
