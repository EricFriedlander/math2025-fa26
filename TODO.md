# Pre-class To-Do List: MATH 2025 Fall 2026

Checklist of everything that needs attention before the first day of class. Scaffolded from the Fall 2025 offering (`MATH2025FA25`) — see `CLAUDE.md` for repo structure and conventions.

---

## Decided

- [x] **Computing platform: CofI Posit Workbench** (`{{< var rstudio_url >}}` / `_variables.yml`), not Deepnote and not Posit Cloud. The Workbench servers are being updated this semester and the URL may change mid-semester — see the "URL may change" item below. See `computing-access.qmd`, `CLAUDE.md`.
- [x] **FA26 academic calendar**, from the [College of Idaho catalog](https://collegeofidaho.smartcatalogiq.com/current/undergraduate-catalog/academic-calendar): classes begin Wed Aug 26, Labor Day Mon Sep 7, drop deadline Sep 9, Fall Break Thu-Fri Oct 15-16, withdraw deadline Nov 19, Thanksgiving Break Mon-Fri Nov 23-27, last day of classes Thu Dec 3, finals Mon-Thu Dec 7-10 (exact slot for our MW 10:50am section not yet published by the registrar).
- [x] **Meeting pattern**: MW 10:50am-12:05pm, CML 105.

---

## Done this pass

- [x] Reinstalled/added R packages for R 4.6.1 via `renv` (`corrplot`, `countdown`, `coursekata`, `emo`, `fivethirtyeight`, `GGally`, `ggformula`, `gt`, `hexSticker`, `infer`, `IRkernel`, `ISLR2`, `janitor`, `kableExtra`, `moderndive`, `mosaic`, `mosaicData`, `olsrr`, `openintro`, `palmerpenguins`, `patchwork`, `plotly`, `priceR`, `rms`, `Stat2Data`, `supernova`, `tidycensus`, `tidymodels`, `yardstick`, `writexl`) and snapshotted. `renv::status()` reports in sync. A full `quarto render` (including `syllabus.qmd --to pdf`) now succeeds.
- [x] Filled in all FA26 MW lecture dates in `schedule.xlsx` (26 class meetings, lectures 0-25, matching the existing arc exactly), added a Labor Day row, dedicated Friday due-date rows for HW 01-07, and wired the `project` column for all five remaining deliverables (previously only the pilot was linked).
- [x] Re-dated Thanksgiving Break (Mon Nov 23 / Wed Nov 25), Exam 1 (Wed Oct 14), Exam 2 (Wed Dec 2), and the Poster Session row (placeholder date Dec 7 within the Dec 7-10 finals window — see below).
- [x] Swapped every Deepnote reference for the CofI Posit Workbench across `computing-access.qmd`, `links.qmd`, `_quarto.yml`, all 14 AE intro callouts, all 7 HW intro callouts, `slides/00-welcome.qmd`, `slides/01-big-picture.qmd`, `slides/04-slr-fit-prediction.qmd`, the `kable()` comments in `slides/10-model-eval.qmd`/`18-comparison.qmd`, and all six `project/` deliverable pages (team file-sharing there now reads "shared RStudio Project folder" rather than Deepnote's/Posit Cloud's shareable-project model). `ae` schedule links point at repo paths.
- [x] **Centralized the Workbench URL** in `_variables.yml` (`rstudio_url`), referenced everywhere via `{{< var rstudio_url >}}` — a mid-semester URL change (servers are being updated) is now a one-line edit there, **except** the "RStudio" sidebar tool `href` in `_quarto.yml`, which Quarto's shortcode can't reach and must be kept in sync by hand (comment left at both spots pointing to the other).
- [x] Updated meeting days/times/room (MW 10:50am-12:05pm, CML 105) in `syllabus.qmd` and `index.qmd`.
- [x] Fixed the prerequisite in `syllabus.qmd` (was self-referential `MATH-2025`; now `MATH-1025, ... or CSCI-1040 ... or qualifying placement score`, matching the current catalog).
- [x] Fixed the catalog description typo (`MAT-2025 rather than MAT-1025` → `MATH-2025 rather than MATH-1025`).
- [x] Re-dated `syllabus.qmd` "Important dates", `slides/19-exam-02-review.qmd` (`Wed, Dec 3` → `Wed, Dec 2`), `support.qmd`'s office-hours pledge date (`9/3` → `9/2`), and the "For Monday"/"For Wednesday" to-do slides in `01-big-picture.qmd`/`02-multivariate-relationships.qmd` (day pattern shifted because lecture 1 now falls on a Monday).
- [x] Re-dated all six project deadline pages and `project-overview.qmd`'s summary table (see table below).
- [x] Fixed the broken YAML delimiter (and malformed `format:` indentation) in `ae/ae-18-comparison.qmd`.
- [x] Fixed the three dead `mat212wi25.netlify.app` links: `hw/hw-01.qmd` (rewritten to point at `computing-r-resources.qmd`, since neither RStudio-IDE nor Quarto-anatomy anchors exist on this site's decks), `hw/hw-02.qmd` → `/slides/01-big-picture.html#when-things-go-wrong`, `hw/hw-06.qmd` → `/slides/15-mlr-inference.html#mlr-hypothesis-test-treatment`.
- [x] Fixed the "the folder your just made" typo in all 7 `hw/*.qmd` files.
- [x] Fixed `hw/hw-07.qmd` referring to itself as "Homework 8" / `hw-08.qmd`.
- [x] Stripped stale FA25 Canvas `/assignments/NNNNNN` deep links down to the bare `CANVAS_ID_TBD` course URL (13 AE files) so only one token per file needs replacing once Canvas exists.
- [x] Marked office hours **TBD** everywhere they appeared (`syllabus.qmd`, `index.qmd`, `slides/00-welcome.qmd`) pending the FA26 schedule.

### FA26 due-date table (as entered in `schedule.xlsx` / project pages)

| Item | Due |
|------|-----|
| HW 01 | Fri Sep 18 |
| HW 02 | Fri Sep 25 |
| HW 03 | Fri Oct 2 |
| HW 04 | Fri Oct 9 |
| HW 05 | Fri Oct 23 |
| HW 06 | Fri Oct 30 |
| HW 07 | Fri Nov 13 |
| Project 1: Pilot | Wed Nov 4 |
| Project 2: Power | Wed Nov 11 |
| Project 3: Preliminary | Wed Nov 18 |
| Project 4: Full draft | Mon Nov 30 |
| Project 5: Final + Poster | Finals week, Dec 7-10 (slot TBD) |

Sanity-check the HW spread against however the semester actually unfolds — it was chosen to front-load HW so nothing but the project is due after Nov 13.

---

## Struck (not actually issues)

- ~~Re-date the hardcoded "November 15" references in `ae-15/16/17`, `slides/16`, `slides/17`~~ — these are the PVPC rail-trail data's *collection dates* (April 5-Nov 15, 2005), not course dates. Leave as-is.
- ~~Re-date "January 1" / "September 11" in `hw/hw-07.qmd`~~ — dataset vintage for the LEGO themes (Jan 1, 2018-Sep 11, 2020), not course dates. Leave as-is.

---

## Infrastructure

- [x] Create `EricFriedlander/math2025-fa26` on GitHub and push — **the remote already exists and `master` is pushed** (`origin` points at it, `d63f23b` is on `origin/master`), so this is effectively done; just keep pushing new commits.
- [x] `quarto publish gh-pages`, then confirm GitHub Pages is enabled in repo settings — `gh api repos/EricFriedlander/math2025-fa26/pages` currently 404s, so Pages has never been turned on. The site now renders cleanly end-to-end, so this is unblocked.
- [ ] **Workbench URL may change mid-semester** (servers being updated) — when it does, update `rstudio_url` in `_variables.yml` AND the "RStudio" sidebar tool `href` in `_quarto.yml` (the latter can't be centralized; Quarto shortcodes don't reach `_quarto.yml`).
- [x] Canvas course now exists (`https://cofi.instructure.com/courses/18743`, unpublished) — replaced all `CANVAS_ID_TBD` tokens with `18743` across `_quarto.yml`, `links.qmd`, and the AE/HW files. The four committed `project/*.html` build artifacts still carry the old token in their rendered sidebars; they'll pick up the fix on the next `quarto render`.
- [ ] Confirm the exact Dec 7-10 final-exam slot for our MW 10:50am section with the registrar, then replace the "exact slot TBD" placeholder in `schedule.xlsx` and `project/project-final.qmd` / `project/project-poster.qmd`.
- [x] Decide and fill in real office hours for FA26 — Tue & Wed 2:15pm-3:45pm, Thu 3:00pm-4:00pm, Boone 126B, set in `syllabus.qmd`, `about.qmd`, `slides/00-welcome.qmd`.

---

## Deferred

- [ ] **AE numbering reconciliation.** File numbers, in-file titles, folder names students are told to create, and Canvas assignment names all disagree (e.g. `ae-18-comparison.qmd` is titled "AE 11"; `ae-15`/`ae-16` both reference "AE-08"; `ae-10` references "AE 05"). No `ae-04` or `ae-12`; both `ae-05-conditions.qmd` and `ae-05-sbi-ht.qmd` exist for lecture 5; `ae-08-math-models-conditions` and `ae-14-cat-int` exist only as `.ipynb` (no `.qmd`, so no schedule link and no rendered page). Needs one deliberate renumbering pass, not mixed into date/platform fixes.
- [ ] Once AE numbering is fixed, fill in the `ae` column for the schedule rows still missing it (lecture 8 onward mostly), and consider whether `ae-08`/`ae-14` need `.qmd` versions written to match the rest of the course.
- [ ] Course logo — `images/logo.png` is reused from FA25 as-is; regenerate via `GenerateSticker.R` if you want a year change.
- [ ] Review slides for anything time-sensitive (dataset vintages, current events) — e.g. `slides/00-welcome.qmd`'s COVID/FiveThirtyEight reference from March 2020.
- [ ] The syllabus lists logistic regression as a learning objective, but there are no logistic-regression slides — decide whether to add them or drop the objective.
- [ ] Review the AI / academic integrity policy for 2026.
- [ ] Review the accommodations statement for the current term.
- [ ] Decide whether groups of two still fits enrollment (`project/project-overview.qmd`).
- [ ] Re-check every `data/` CSV still loads, especially anything sourced via `scripts/UpdateCensus.R`.
- [x] Update the Canvas course link in `_quarto.yml` sidebar tools once the real URL exists (see Infrastructure above).
