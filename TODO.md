# Pre-class To-Do List: MATH 2025 Fall 2026

Checklist of everything that needs attention before the first day of class. Scaffolded from the Fall 2025 offering (`MATH2025FA25`) — see `CLAUDE.md` for repo structure and conventions.

---

## Decide first (blocks other work)

- [ ] Deepnote vs. Posit Workbench for FA26 — every AE/HW intro callout and the `ae`/`hw` schedule columns depend on this. Both `.qmd` and `.ipynb` were copied over undecided.
- [ ] Get the College of Idaho Fall 2026 academic calendar: first/last class day, breaks, final exam slot.

---

## Infrastructure

- [ ] Reinstall R packages for R 4.6.1 (`tidyverse`, `gt`, `mosaic`, `ggformula`, `broom`, `knitr`, `countdown`, `kableExtra`, `plotly`, `readxl`, `fontawesome`, `glue`) — nothing with an R chunk renders until this is done. `readxl` currently fails with an `undefined symbol` error, not just "package missing," so this may need a full reinstall from source rather than `update.packages()`.
- [ ] Create `EricFriedlander/math2025-fa26` on GitHub and push (see below).
- [ ] `quarto publish gh-pages`, then confirm GitHub Pages is enabled in repo settings.
- [ ] Consider `renv::init()` to pin package versions and prevent this recurring.
- [ ] Replace all `CANVAS_ID_TBD` tokens once the Canvas course exists: `grep -rn CANVAS_ID_TBD .`

---

## Schedule (`schedule.xlsx`)

- [ ] Fill in all 25+ lecture dates for the FA26 MW pattern (all dates were cleared during scaffolding).
- [ ] Re-date Thanksgiving break, Exam 1, Exam 2, and the poster session.
- [ ] Confirm the 25-lecture arc still fits the FA26 calendar.
- [ ] The `ae` and `hw` columns were normalized to `/ae/...` and `/hw/...` repo paths (replacing FA25's Deepnote share links, several of which were dead `https://deepnote.com/` placeholders anyway). If Deepnote is chosen, swap in real share links row by row.

---

## Syllabus (`syllabus.qmd`)

- [ ] Update meeting days/times and room (FA25: MW 1:35–2:50pm, CML 208).
- [ ] Update office hours (FA25: Mon 3:30–4:30, Tue 10:20–11:20, Thu 1:30–3:30, Boone 126B).
- [ ] **Fix the prerequisite** — currently reads "MATH-2025, grade of C- or better," i.e. the course lists itself as its own prereq. Carried over unchanged from FA25.
- [ ] **Fix the catalog description** — says "MAT-2025 rather than MAT-1025" (wrong prefix; `index.qmd` has the corrected "MATH-2025 rather than MATH-1025" wording).
- [ ] Review the AI / academic integrity policy for 2026.
- [ ] Review the accommodations statement for the current term.
- [ ] `quarto render syllabus.qmd --to pdf` once R packages are working.

---

## Front page (`index.qmd`)

- [ ] Update subtitle/meeting-time/office-hours details for FA26.

---

## Project (`project/`)

- [ ] Re-date all six deadline pages: `project-pilot.qmd` (was Nov 5), `project-power.qmd` (Nov 12), `project-preliminary.qmd` (Nov 19), `project-draft.qmd` (Dec 1), `project-final.qmd` / `project-poster.qmd` (Dec 10).
- [ ] Confirm the poster session lands in the FA26 final-exam slot.
- [ ] Decide whether groups of two still fits enrollment.

---

## Assignments

- [ ] Re-date the hardcoded "November 15" references in `ae/ae-15-mlr-inference.qmd`, `ae/ae-16-mlr-conditions.qmd`, `ae/ae-17-multicollinearity.qmd`, `slides/16-mlr-conditions.qmd`, `slides/17-multicollinearity.qmd`.
- [ ] Fix `hw/hw-07.qmd` (references "January 1" and "September 11" — check both are intentional and correct for FA26).
- [ ] Decide whether HW 01–07 is the right count for the FA26 calendar.
- [ ] Reconcile AE numbering gaps carried over from FA25 (no `ae-04`, no `ae-12`; both `ae-05-conditions.qmd` and `ae-05-sbi-ht.qmd` exist for lecture 5).
- [ ] Re-check every `data/` CSV still loads, especially anything sourced via `scripts/UpdateCensus.R`.
- [ ] Fix a broken YAML delimiter in `ae/ae-18-comparison.qmd` — the file starts with `7---` instead of `---`, so its `title:` frontmatter is silently dropped on render (carried over unchanged from FA25, where the built page also renders without a title).
- [ ] Fix three links to the old MAT-212 Winter 2025 site (predecessor to MATH2025FA25, never updated even in FA25) that don't point at this repo: `hw/hw-01.qmd:40`, `hw/hw-02.qmd:175`, `hw/hw-06.qmd:105`, all `https://mat212wi25.netlify.app/slides/...`. Slide numbering differs between that site and this one (e.g. its `01-welcome` is this repo's `00-welcome`), so map each anchor by hand rather than doing a straight URL swap.

---

## Content

- [ ] Course logo — `images/logo.png` is reused from FA25 as-is; regenerate via `GenerateSticker.R` if you want a year change.
- [ ] Review slides for anything time-sensitive (dataset vintages, current events).
- [ ] The syllabus lists logistic regression as a learning objective, but there are no logistic-regression slides — decide whether to add them or drop the objective.

---

## GitHub / deployment

- [ ] `gh repo create EricFriedlander/math2025-fa26 --public --source=. --push` (or push manually once the remote exists).
- [ ] `quarto publish gh-pages` — **do this only after** the R-package issue above is resolved; a full `quarto render` currently fails on `schedule.qmd` and the slide decks.
- [ ] Update the Canvas course link and RStudio/Posit link in `_quarto.yml` sidebar tools if they change.
