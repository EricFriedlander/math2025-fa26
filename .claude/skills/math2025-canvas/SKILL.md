---
name: math2025-canvas
description: >
  The MATH 2025 (Multiple Regression Analysis, Fall 2026) course's own Canvas conventions:
  which Canvas course and assignment groups to write to, how lecture modules and their items
  are named and ordered, how AE and HW assignments are titled/pointed/dated, the exact
  description HTML each assignment carries, how data CSVs are distributed, and the repo-side
  follow-through of filling in `[Canvas]()` links and re-rendering. Use this whenever pushing
  this course's material to Canvas — "update Canvas for lecture N," "add this week's AE and HW
  to Canvas," "post the module for Wednesday," "create the HW-04 assignment" — before creating
  or editing anything in the course. This skill supplies the course's style and rollout recipe
  only; pair it with the canvas-course-editor skill, which supplies the API mechanics.
---

# MATH 2025 FA26 Canvas conventions

This skill is the course-specific *style guide and rollout recipe* for pushing MATH 2025
(Fall 2026) material to Canvas. It does not know how to call the Canvas API — for that, also
load the global `canvas-course-editor` skill, which covers `canvasapi` usage, auth, and rate
limits. Load both together: `canvas-course-editor` for mechanics, this skill for what the
content of *this course* should actually look like.

## Target

- Canvas base: `https://cofi.instructure.com`
- Course ID: **`18743`** (`MATH-2025-01`, term "2026 Fall")

`canvas-course-editor` defaults `CANVAS_COURSE_ID` to `18673` (PPOL-6500) — **that is the
wrong course**. Always export both explicitly before running any snippet:

```bash
export CANVAS_BASE_URL=https://cofi.instructure.com
export CANVAS_COURSE_ID=18743
```

And always call `confirm_target(course)` before any write, per the base skill's safety rule.
Assignment group IDs and a snapshot of existing modules/assignments are in
`references/course-ids.md`.

## Read live state first

Before creating anything, list the course's current modules and assignments (see
`references/course-ids.md` for a ready snippet). The stored IDs there are a convenience for
looking things up quickly — the live API is the authority, and this file goes stale as the
semester progresses.

## Module conventions

- **Name**: `Lecture N — <Topic> (<Dow>, <Mon D>)`, using an em dash. Example:
  `Lecture 2 — Exploratory Data Analysis (Wed, Sep 2)`. `<Topic>` matches the Topic column of
  that lecture's row in `index.qmd`'s schedule table.
- **Position**: one past the last existing lecture module.
- **Item order** — always Prepare → Slides → AE → HW. Never reorder. Omit any item whose
  content doesn't exist for that lecture (e.g. a lecture with no AE just skips that item).
  1. `ExternalUrl` — `Prepare: Reading for Lecture N`
  2. `ExternalUrl` — `Slides: <slide deck's own YAML title>` (this is the deck's own `title:`
     front matter, which is often worded differently from the schedule's Topic column — use the
     deck's title, not the schedule's)
  3. `Assignment` — the AE, titled exactly as the Canvas assignment (see below)
  4. `Assignment` — the HW, titled exactly as the Canvas assignment
- **URLs**: always point at the **published site**,
  `https://ericfriedlander.github.io/math2025-fa26/<path>.html` — never a repo-relative path.
  `curl -sI` each URL and confirm it 200s before creating the module item; if it doesn't, the
  page needs a `quarto render` / `quarto publish gh-pages` first.
- Create the module **unpublished** unless told otherwise (see Publishing below).

## Assignment conventions

- **Names**: `AE-NN: <title>` / `HW-NN: <title>`, where `<title>` is the `.qmd` file's own YAML
  `title:` with its `AE NN:` / `HW NN:` prefix stripped off. Note the punctuation mismatch: the
  Canvas name uses a hyphen (`AE-03`), the `.qmd` title uses a space (`AE 03`) — keep it that
  way, don't "fix" it to match.
- **Assignment group**: AEs go in **Application Exercises**, HWs go in **Homework** (IDs in
  `references/course-ids.md`).
- **Points**:
  - AEs are **always 10 points**.
  - HWs take the number from that file's own `# Grading (N pts)` heading in the `.qmd` — don't
    guess or reuse a previous HW's point value (HW-01 = 22, HW-02 = 17; they vary).
- **Fixed fields** on every AE/HW assignment:
  ```python
  submission_types=['online_upload']
  allowed_extensions=['qmd', 'html']
  grading_type='percent'
  ```
- **Due dates** — always at `16:50Z` (10:50am MDT / America/Denver, end of the class period):
  - **AEs** are due at the end of the *next* class meeting after the lecture they're assigned in
    (not the same day) — matches AE-01 (assigned Aug 31, due Sep 2) and AE-02 (assigned Sep 2,
    due Sep 9).
  - **HWs** take their due date from the **Notes column of `index.qmd`'s live schedule table**
    (e.g. "HW 2 Due" on a given row), not from any other source.
  - ⚠️ `TODO.md` contains an older FA26 due-date table for homeworks that has drifted out of
    sync with the schedule (e.g. it says HW 2 is due Sep 25; the live schedule says Sep 16).
    **The `index.qmd` schedule always wins** — treat `TODO.md`'s table as stale unless you've
    just cross-checked it against the schedule and confirmed they agree.
- **Publishing**: create assignments **unpublished** by default, and say so plainly when
  reporting back to the user — publishing is the instructor's call, not something to do
  automatically. Only skip this if the user has explicitly asked for it to go live.

## Assignment description HTML

Every AE/HW description follows this exact shape, in this order. Keep it a fill-in-the-blank
template rather than freelancing new wording:

```html
<p>Webpage: https://ericfriedlander.github.io/math2025-fa26/<ae-or-hw path>.html</p>
<p>Template (click download button on this github page): <a href="https://github.com/EricFriedlander/math2025-fa26/blob/master/<ae-or-hw path>.qmd" target="_blank">https://github.com/EricFriedlander/math2025-fa26/blob/master/<ae-or-hw path>.qmd</a></p>
<p>Data (download this and upload it into your <code>data</code> folder): <a href="<canvas file download URL, with verifier>"><filename>.csv</a></p>
<p>Remember: You much upload TWO documents, a .qmd and a .html file.</p>
```

- Omit the Data paragraph entirely for assignments that don't need a local file (several early
  assignments pull data straight from the internet in their `read_csv()` call — check the `.qmd`
  before assuming a CSV is needed).
- The last line's "You much upload" is a preexisting typo already baked into every live
  assignment (AE-01, AE-02, HW-01). Match it verbatim for consistency rather than silently
  fixing only the new ones — if it's ever worth fixing, fix it everywhere in one pass, flagged
  to the user first.

## Data files

When an AE/HW's `.qmd` reads a local CSV (check for a `data/<file>.csv` path in a `read_csv()`
call), upload that file to Canvas course files with `course.upload(<path>)` before creating the
assignment. Build the description's Data link from the URL Canvas hands back — **keep the
`verifier=` query parameter**, it's required for the link to resolve without a login prompt.
AE-01, AE-02, and HW-01 needed no data upload because they load from the internet; AE-03 and
HW-02 were the first to need one (`dcbikeshare.csv`, `parks.csv`).

## Repo-side follow-through

Creating the Canvas assignment is half the job — the `.qmd` files need the resulting link:

1. Find the placeholder in the new `ae/*.qmd` and `hw/*.qmd` files: `[Canvas]()`.
2. Fill it with `https://cofi.instructure.com/courses/18743/assignments/<assignment id>`,
   matching one of the two established sentence patterns (don't invent new wording):
   - AE files: `Go to the assignment for this activity in [Canvas](<url>) to get started.`
   - HW files: `Log into [Canvas](<url>), navigate to HW-NN and upload the ...`
3. Every link inside `ae/` and `hw/` files must be **absolute** (these are standalone student
   templates rendered outside this Quarto project — a repo-relative link would 404 for a
   student). This applies to the Canvas link and any other link you touch in those files.
4. Re-render the touched files: `quarto render ae/<file>.qmd`, `quarto render hw/<file>.qmd`.
   If the rendered HTML doesn't reflect the edit, it's the known stale-`_freeze/` issue —
   delete that file's `_freeze/<path>/` entry and re-render.
5. Verify: `grep -n "Canvas" ae/<file>.qmd hw/<file>.qmd` shows no empty `[Canvas]()` left, and
   the rendered `_site/.../*.html` contains an `href` with the right assignment ID.

## Reporting back

State plainly: the Canvas assignment URLs created, their published/unpublished state, and which
repo files were edited and re-rendered. If anything was left unpublished, say so explicitly and
that it needs a manual publish in the Canvas UI.
