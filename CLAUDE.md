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
| `index.qmd` | Course homepage — renders the schedule table by reading `schedule.xlsx` |
| `about.qmd` | Course overview / instructor bio page (formerly the homepage) |
| `syllabus.qmd` | Full syllabus (renders to HTML and PDF) |
| `schedule.xlsx` | **Source of truth for the schedule** — see column definitions below |
| `support.qmd`, `links.qmd` | Course-support and useful-links pages |
| `computing-*.qmd` | Computing access / inference-summary / R-resources pages |
| `slides/` | Reveal.js lecture slides, one `.qmd` per lecture, numbered to match the lecture number |
| `ae/` | Application exercises (in-class activities), numbered to match the lecture number |
| `hw/` | Homework assignments, numbered by assignment number (not lecture number) |
| `prepare/` | Pre-class reading assignments, numbered to match the lecture number |
| `project/` | Final project materials (overview, rubrics, pilot/preliminary/draft/final/poster pages) |
| `data/` | Datasets used in slides, AEs, and homework |
| `images/` | Site images (`logo.png`, etc.) |
| `scripts/` | Helper scripts (e.g. `UpdateCensus.R`) not part of the rendered site |
| `_freeze/` | Quarto's computed-output cache (`execute: freeze: auto`) — not committed by default here |
| `_site/` | Generated static site — do not edit directly, not committed |

All assignments (readings, activities, homework, project) and slides are published to the schedule page (`index.qmd`, the site homepage), which reads `schedule.xlsx` for what to publish and where to link.

### Computing platform: CofI Posit Workbench

FA26 uses the College of Idaho's own Posit Workbench (RStudio Server), not Deepnote and not Posit Cloud. Students sign in with their CofI email/password and work in `.qmd` files, in a subfolder they create per assignment. `computing-access.qmd` is the student-facing setup page.

The Workbench URL is centralized in `_variables.yml` as `rstudio_url` and referenced everywhere via `{{< var rstudio_url >}}` — the servers are being updated mid-semester and the address may change, so a future URL change should be a single edit there. The one exception is the sidebar "RStudio" tool `href` in `_quarto.yml`: Quarto's `{{< var >}}` shortcode only substitutes inside rendered `.qmd` content, not inside `_quarto.yml` itself, so that href is a literal string kept in sync by hand (both spots carry a comment pointing at the other).

Many `ae/` and `hw/` files still carry a legacy `.ipynb` twin from when Deepnote/Jupyter was under consideration. These are not rendered (`_quarto.yml` excludes `*.ipynb`) and are not being kept in sync — treat the `.qmd` as the only source of truth. `.github/prompts/ConvertQmdToJupyter.prompt.md` is legacy and unused.

Many `ae/` and `hw/` files still carry a legacy `.ipynb` twin from when Deepnote/Jupyter was under consideration. These are not rendered (`_quarto.yml` excludes `*.ipynb`) and are not being kept in sync — treat the `.qmd` as the only source of truth. `.github/prompts/ConvertQmdToJupyter.prompt.md` is legacy and unused.

## `schedule.xlsx` column definitions

Each row corresponds to one class day of the week and usually — but not always — corresponds to a class period (e.g. an assignment can be due on a day with no lecture). 12 columns:

1. **Publish** — `x` if the row should be published, blank otherwise. Not displayed on the site.
2. **Lecture** — lecture number (1, 2, 3, …), or blank if there's no lecture that day.
3. **DOW** — day of week (M, T, W, TH, F).
4. **Date** — class date, `MM/DD/YYYY`.
5. **Topic** — the class topic or other relevant info; usually the slide title, shortened if needed.
6. **Prepare** — reading to complete before class: `/prepare/xx-<slug>.qmd`.
7. **Slides** — that day's slides: `/slides/xx-<slug>.qmd`.
8. **AE** — that day's in-class activity: `/ae/xx-<slug>.qmd`.
9. **HW** — homework due that day: `/hw/hw-xx.qmd`.
10. **Project** — project deliverable due that day (rare): `/project/<slug>.qmd`.
11. **Notes** — published notes (e.g. "HW 1 due / HW 2 assigned").
12. **Eric's Notes** — private notes, not published.

Numbers on activities, slides, and prepare assignments track the **lecture** number. Homework numbers track the **assignment** number, independent of lecture.

## Key conventions

- **Nav registration**: new pages must be added to the `contents:` list in `_quarto.yml` sidebar to appear in navigation.
- **Slide metadata**: each slide deck sets its own `footer`/`logo`/`bibliography` in YAML front matter (no shared `_metadata.yml` in this repo, unlike newer course sites).
- **Freeze**: `execute: freeze: auto` — computed outputs cache in `_freeze/`. This has been observed to reuse stale content after a prose-only edit (no code chunk changes) to a file that was already rendered once this session — a second `quarto render` can silently keep the old text instead of picking up the edit. If a rendered page in `_site/` doesn't reflect a recent source change, delete that file's `_freeze/<path>/` entry (or `.quarto/` and `_freeze/` entirely for a guaranteed-clean rebuild) and re-render before concluding the edit didn't take.
- **Ignored from render**: `TODO.md`, `README.md`, `CLAUDE.md` (see `.quartoignore`); `exam/*.qmd` and `*.ipynb` (see `_quarto.yml` render exclusions).
