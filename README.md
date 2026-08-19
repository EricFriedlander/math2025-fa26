# MATH 2025: Multiple Regression Analysis — Fall 2026

This repository contains the course website and materials for MATH 2025 — Multiple Regression Analysis at the College of Idaho, Fall 2026, taught by Dr. Eric Friedlander.

Scaffolded from the Fall 2025 offering (`MATH2025FA25`). See `TODO.md` for what still needs updating before the semester starts, and `CLAUDE.md` for repo structure and conventions.

## Technology stack

- **Website framework**: [Quarto](https://quarto.org/)
- **Deployment**: GitHub Pages, via `quarto publish gh-pages`
- **Version control**: Git/GitHub
- **Development environment**: RStudio/VS Code

## Local development

### Prerequisites

- [Quarto](https://quarto.org/docs/get-started/) installed
- [R](https://www.r-project.org/) and [RStudio](https://posit.co/download/rstudio-desktop/) (optional but recommended)

### Getting started

1. **Clone the repository**:
   ```bash
   git clone https://github.com/EricFriedlander/math2025-fa26.git
   cd math2025-fa26
   ```
2. **Preview the website locally**:
   ```bash
   quarto preview
   ```
3. **Build the website**:
   ```bash
   quarto render
   ```

### VS Code tasks

The workspace includes a VS Code task for convenient development:
- **Quarto Preview**: starts the local development server. Access via `Ctrl+Shift+P` → "Tasks: Run Task" → "Quarto Preview".

## Project structure

```
├── .github/                    # GitHub configuration
├── ae/                        # Application exercises
├── data/                      # Course datasets
├── hw/                        # Homework assignments
├── images/                    # Course images and assets
├── prepare/                   # Preparation materials
├── project/                   # Course project materials
├── scripts/                   # Helper scripts
├── slides/                    # Lecture slides
├── _quarto.yml                # Main Quarto configuration
├── index.qmd                  # Course homepage
├── schedule.qmd               # Course schedule (reads schedule.xlsx)
├── schedule.xlsx              # Schedule data
├── syllabus.qmd                # Course syllabus
├── CLAUDE.md                  # Repo structure and conventions
├── TODO.md                    # Pre-semester checklist
└── README.md                  # This file
```

## Deployment

The website is deployed to GitHub Pages via `quarto publish gh-pages`.

- **Live site**: https://ericfriedlander.github.io/math2025-fa26/
- **GitHub repository**: https://github.com/EricFriedlander/math2025-fa26

## Common tasks

### Adding new content

1. Create/edit `.qmd` files for new pages.
2. Update `_quarto.yml` if adding to navigation.
3. Preview changes locally with `quarto preview`.
4. Commit and push, then `quarto publish gh-pages` to deploy.

### Updating the schedule

- Edit `schedule.qmd` for the main schedule page logic.
- Update `schedule.xlsx` for the underlying data — see the column definitions in `CLAUDE.md`.

### Modifying course information

- Course title/description: `_quarto.yml` and `index.qmd`.
- Syllabus: `syllabus.qmd`.
- Course policies: `support.qmd`.

## License

This course content is licensed for educational use. Please contact Dr. Eric Friedlander for permissions regarding reuse or distribution.
