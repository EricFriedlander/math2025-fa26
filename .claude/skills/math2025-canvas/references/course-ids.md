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

- `241903` — **Roll Call Attendance**: 0 pts, in the Homework group, `omit_from_final_grade=True`.
  Pre-existing course infrastructure, not part of the lecture rollout — leave it alone.

## Snapshot as of 2026-09-08 (will go stale — verify before relying on it)

### Modules

| ID | Position | Name |
|---|---|---|
| `78130` | 1 | Course Information |
| `78126` | 2 | Lecture 0 — Welcome to MATH 2025! (Wed, Aug 26) |
| `78127` | 3 | Lecture 1 — The Big Picture (Mon, Aug 31) |
| `78682` | 4 | Lecture 2 — Exploratory Data Analysis (Wed, Sep 2) |
| `78918` | 5 | Lecture 3 — Introduction to Simple Linear Regression (Wed, Sep 9) |

The next lecture module should be created at `position=6`.

### AE / HW assignments

| ID | Name | Group | Points | Due |
|---|---|---|---|---|
| `242372` | AE-01: Getting Started | Application Exercises | 10 | 2026-09-02T16:50:00Z |
| `242686` | AE-02: Exploratory Data Analysis | Application Exercises | 10 | 2026-09-09T16:50:00Z |
| `243284` | AE-03: Bike rentals in Washington, DC | Application Exercises | 10 | 2026-09-14T16:50:00Z |
| `242687` | HW-01: Dr. F's Coffee | Homework | 22 | 2026-09-09T16:50:00Z |
| `243285` | HW-02: Park access | Homework | 17 | 2026-09-16T16:50:00Z |

### Data files uploaded to Canvas course files

| File ID | Filename | Used by |
|---|---|---|
| `1778991` | `dcbikeshare.csv` | AE-03 |
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
