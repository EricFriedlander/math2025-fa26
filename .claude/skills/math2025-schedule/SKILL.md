---
name: math2025-schedule
description: Conventions for the MATH 2025 course schedule table in index.qmd (the site homepage): the 10 columns, icon shortcodes and dimmed-icon cells, lecture vs homework numbering, and how to publish the next commented-out row. Use whenever adding, editing, or publishing a schedule row, or linking a new slide, AE, HW, prepare, or project page from the schedule.
---

# Schedule (`index.qmd`) conventions

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
