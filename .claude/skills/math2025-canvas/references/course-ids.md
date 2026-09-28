# MATH 2025 FA26 — Canvas IDs

Snapshot taken **2026-09-08**. The course and assignment-group IDs below are stable for the
semester. Everything else (modules, assignments, points, due dates, published state) drifts as
the course is built out — **treat the live API as authoritative** and use this file only as a
quick lookup / starting point, not as ground truth. Re-list before trusting it for anything that
matters (see the snippet at the bottom).

## Stable

- Base URL: `https://cofi.instructure.com`
- Course ID: **`18743`** (`MATH-2025-01 Multiple Regression Analysis`, term "2026 Fall")
- Assignment groups:

  | ID | Name | Weight | Position |
  |---|---|---|---|
  | `46820` | Homework | 15% | 1 |
  | `48693` | Application Exercises | 10% | 2 |
  | `48694` | Exam 01 | 25% | 3 |
  | `48695` | Exam 02 | 25% | 4 |
  | `48696` | Final Project | 25% | 5 |
  | `49170` | Preparation | 0% | 6 |

- `241903` — **Roll Call Attendance**: 0 pts, in the Homework group, `omit_from_final_grade=True`.
  Pre-existing course infrastructure, not part of the lecture rollout — leave it alone.

## Snapshot as of 2026-09-28 (will go stale — verify before relying on it)

### Modules

| ID | Position | Name |
|---|---|---|
| `78130` | 1 | Course Information |
| `78126` | 2 | Lecture 0 — Welcome to MATH 2025! (Wed, Aug 26) |
| `78127` | 3 | Lecture 1 — The Big Picture (Mon, Aug 31) |
| `78682` | 4 | Lecture 2 — Exploratory Data Analysis (Wed, Sep 2) |
| `78918` | 5 | Lecture 3 — Data Cleaning (Wed, Sep 9) |
| `78951` | 6 | Lecture 4 — Introduction to Simple Linear Regression (Mon, Sep 14) |
| `78952` | 7 | Lecture 5 — Categorical Predictors (Wed, Sep 16) — full Prepare/Slides/AE/HW item set |
| `78987` | 8 | Lecture 6 — Residuals & Least Squares (Mon, Sep 21) — full Prepare/Slides/AE item set (no HW), fully published |
| `79101` | 9 | Lecture 7 — Model Evaluation (Wed, Sep 23) — Slides/AE/HW item set (no Prepare — it moved to Lecture 8's module when the Islands content shifted), fully published |
| `79118` | 10 | Lecture 8 — Study Design, Sampling & the Islands (Mon, Sep 28) — full Prepare/Slides/AE item set (no HW), fully published |
| `79162` | 11 | Lecture 9 — Modeling Life Expectancy on the Islands (Wed, Sep 30) — Prepare item only so far (`ExternalUrl`, not an assignment — see note below), unpublished |

The next lecture module should be created at `position=12`.

Note: the Islands/inference content and its Prepare assignment originally lived under a
Lecture 7 module; when the schedule shifted that content to Lecture 8, the Prepare module item
(`404269`, assignment `243763`) was moved into the new Lecture 8 module rather than duplicated,
and the module itself was renamed from its stale "Intro to Islands & inference" wording to match
the current schedule's Topic column. If a lecture's module name and the `index.qmd` Topic column
ever disagree, that's a sign of exactly this kind of content shift — check before assuming the
module name is current.

⚠️ `create_module`/`create_module_item` with `published: True` in the payload does **not**
actually publish on creation (observed 2026-09-14: modules 78951/78952 and their ExternalUrl
items came back `published=False` despite the flag) — always re-`.edit(module={'published': True})`
(and same for each item) after creating, then re-verify.

### AE / HW / Prepare assignments

| ID | Name | Group | Points | Grading type | Due |
|---|---|---|---|---|---|
| `242372` | AE-01: Getting Started | Application Exercises | 10 | points | 2026-09-02T16:50:00Z |
| `242686` | AE-02: Exploratory Data Analysis | Application Exercises | 10 | points | 2026-09-09T16:50:00Z |
| `243284` | AE-03/04: Bike rentals in Washington, DC | Application Exercises | 20 | points | 2026-09-16T16:50:00Z |
| `242687` | HW-01: Dr. F's Coffee | Homework | 22 | points | 2026-09-09T16:50:00Z |
| `243285` | HW-02: Park access | Homework | 17 | points | 2026-09-16T16:50:00Z |
| `243518` | AE-05: The Coffee Truck | Application Exercises | 10 | points | 2026-09-21T16:50:00Z |
| `243519` | HW-03: The Coffee Truck | Homework | 30 | points | 2026-09-23T16:50:00Z |
| `243762` | AE-06/07: Comparing Models with the Coffee Truck | Application Exercises | 20 | points | 2026-09-28T16:50:00Z |
| `243763` | Prepare: Reading for Lecture 8 | Preparation | 0 | points | 2026-09-28T16:50:00Z |
| `243850` | HW-04: Education & median income in US Counties | Homework | 30 | points | 2026-09-30T16:50:00Z |
| `244041` | AE-08: Collecting Data on the Islands | Application Exercises | 10 | points | 2026-09-30T16:50:00Z |

Note: AE-03 was renamed AE-03/04 and its points bumped 10 → 20 when the bikeshare activity was
split across lectures 3 and 4; the same assignment (`243284`) is linked from both lecture
modules rather than creating a separate AE-04. Same pattern for AE-06, renamed AE-06/07 and
bumped 10 → 20 pts, linked from both the Lecture 6 and Lecture 7 modules.

Note: on 2026-09-21, all assignments except `241903` (Roll Call Attendance) were switched to
`grading_type='points'`. This is now the course standard.

Note: `243763` was originally created as the Lecture 7 Prepare assignment, then renamed and
its due date moved to 2026-09-28 when the Islands content shifted to Lecture 8 — see the
Modules section note above.

⚠️ **Correction (2026-09-28): the assignment-based Prepare item (`243763`/`404269` on Lecture 8)
was a one-off, not a new course standard.** It was initially misread as "the current convention
as of 2026-09-21" and a second one was created the same way for Lecture 9 (assignment `244042`,
module item `404785`) before the user caught it and had both deleted. Every other lecture's
Prepare item (Lectures 4-9 confirmed live) is a plain `ExternalUrl` module item titled
`Prepare: Reading for Lecture N`, pointing straight at the published prepare page — **no
separate Canvas assignment, no gradebook entry, no completion requirement.** Follow that format
for all future lectures unless the user explicitly asks for another one-off like Lecture 8's.

All assignments and modules listed above are **published** as of this snapshot, except module
`79162` (Lecture 9), which is unpublished and still needs a manual publish in the Canvas UI.

### Data files uploaded to Canvas course files

| File ID | Filename | Used by |
|---|---|---|
| `1778991` | `dcbikeshare.csv` | AE-03/04 |
| `1778992` | `parks.csv` | HW-02 |

## Snippet to re-list live state

```python
import os
os.environ['CANVAS_BASE_URL'] = 'https://cofi.instructure.com'
os.environ['CANVAS_COURSE_ID'] = '18743'
from scripts.canvas_client import get_course
course = get_course()

for g in course.get_assignment_groups():
    print(g.id, g.name, g.group_weight, g.position)

for a in course.get_assignments():
    print(a.id, a.name, a.assignment_group_id, a.points_possible, a.due_at, a.published)

for m in course.get_modules():
    print(m.id, m.position, m.name)
```

Run from `~/.claude/skills/canvas-course-editor` with `pixi run python -c "..."`.
