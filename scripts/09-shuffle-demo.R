# Live demo for Lecture 09: analyzing the villager-card shuffle.
#
# Expected spreadsheet (one worksheet in the shared workbook), one row per
# student per round:
#
#   round | sex    | age_at_death
#   ------+--------+-------------
#   0     | Female | 78            <- round 0 = the real pairing on the cards
#   0     | Male   | 64
#   1     | Female | 51            <- round 1 = after the first shuffle
#   ...
#
# Sex never moves. Only the age halves get shuffled between rounds.

library(tidyverse)
library(readxl)
library(coursekata)   # pre(), shuffle(), do(), gf_*()

# 1. Load ---------------------------------------------------------------

path  <- "shuffle-cards.xlsx"   # download the shared workbook to here
sheet <- "shuffle"              # name of the worksheet with the class entries

cards <- read_excel(path, sheet = sheet) |>
  transmute(
    round        = as.integer(round),
    sex          = str_to_title(str_trim(sex)),
    age_at_death = as.numeric(age_at_death)
  ) |>
  drop_na()

count(cards, round)             # every round should have one row per student

# 2. Boxplots: round 0 (real) vs. the shuffled rounds ---------------------

cards |>
  mutate(round_label = if_else(round == 0, "Round 0 (real)",
                               paste("Round", round, "(shuffled)"))) |>
  gf_boxplot(age_at_death ~ sex, fill = ~ sex, show.legend = FALSE) |>
  gf_facet_wrap(~ round_label) |>
  gf_labs(x = "Sex", y = "Age at death (years)")

# 3. Group means and PRE in each round ------------------------------------

by_round <- cards |>
  group_by(round) |>
  summarize(
    mean_female = mean(age_at_death[sex == "Female"]),
    mean_male   = mean(age_at_death[sex == "Male"]),
    diff        = mean_male - mean_female,
    pre         = pre(age_at_death ~ sex, data = pick(everything()))
  )
by_round

# 4. Dot plot: shuffled PREs, with the real one marked ---------------------

pre_real <- by_round |> filter(round == 0) |> pull(pre)

by_round |>
  filter(round > 0) |>
  gf_dotplot(~ pre, binwidth = 0.005, fill = "grey60") |>
  gf_vline(xintercept = pre_real, color = "#d53a19", linewidth = 1.5) |>
  gf_labs(x = "PRE (red line = real cards)", y = "")

# 5. Finale: fill in the whole null distribution --------------------------
# Same idea as the cards, but 1000 shuffles instead of a handful.

round0 <- cards |> filter(round == 0)

set.seed(2025)
null_pre <- do(1000) * pre(shuffle(age_at_death) ~ sex, data = round0)

gf_histogram(~ pre, data = null_pre, bins = 30, boundary = 0,
             fill = "grey70", color = "white") |>
  gf_vline(xintercept = pre_real, color = "#d53a19", linewidth = 1.5) |>
  gf_labs(x = "PRE from a shuffled data set", y = "Number of shuffles")

mean(null_pre$pre >= pre_real)  # p-value for the class's card deck
