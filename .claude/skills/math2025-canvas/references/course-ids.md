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

## Snapshot as of 2026-09-21 (will go stale — verify before relying on it)

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
| `78987` | 8 | Lecture 6 — Residuals, Least Squares, and Model Evaluation (Mon, Sep 21) — full Prepare/Slides/AE item set (no HW). Module itself is published; the new Slides (`404267`) and AE-06 (`404268`) items are **unpublished** — publish by hand. |
| `79101` | 9 | Lecture 7 — Intro To Islands & Project (Wed, Sep 23) — one item, the 0-pt Prepare assignment (`404269`, `must_mark_done`). Module and item both **unpublished**. |

The next lecture module should be created at `position=10`.

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
| `243762` | AE-06: Comparing Models with the Coffee Truck | Application Exercises | 10 | points | 2026-09-23T16:50:00Z |
| `243763` | Prepare: Reading for Lecture 7 | Preparation | 0 | points | 2026-09-23T16:50:00Z |

Note: AE-03 was renamed AE-03/04 and its points bumped 10 → 20 when the bikeshare activity was
split across lectures 3 and 4; the same assignment (`243284`) is linked from both lecture
modules rather than creating a separate AE-04.

Note: on 2026-09-21, all assignments except `241903` (Roll Call Attendance) were switched to
`grading_type='points'` (four — AE-03/04, AE-05, HW-02, HW-03 — were backfilled from
`'percent'`; point values unchanged). This is now the course standard.

Note: AE-06 (`243762`) and the Lecture 7 Prepare assignment (`243763`), created 2026-09-21, are
**unpublished**, as are their module items and module `79101` — publish by hand in the Canvas
UI when ready.

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
