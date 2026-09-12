
# GetCoffeeTruckData.R
# Pull class data from the Grinnell stat2games Coffee Truck game
# (https://www.stat2games.sites.grinnell.edu/games/coffeetruck.html), used in
# slides/05-categorical-predictors.qmd and ae/ae-05-coffee-truck.qmd.
#
# The game writes every round played (by anyone, in any class) to one shared,
# public table. A bare GET to the endpoint below returns the whole table (as
# CSV, last 3 months by default); this script POSTs a groupid/date range
# filter server-side instead of downloading everything and filtering locally.
# Requires: httr2, readr

suppressPackageStartupMessages({
  library(httr2)
  library(readr)
})

GROUP_ID <- "MATH2025FA26"   # the group name the whole class plays under
FROM_DATE <- "2026-09-01"    # adjust to the day the activity is run
TO_DATE   <- "2026-12-31"
OUT_PATH  <- "../data/coffeetruck-class.csv"  # run from scripts/, writes to data/

resp <- request("https://www.stat2games.sites.grinnell.edu/data/coffeetruck/getdata.php") |>
  req_body_form(
    groupid  = GROUP_ID,
    playerid = "",
    fromdate = FROM_DATE,
    todate   = TO_DATE,
    getdata  = "Download CSV"
  ) |>
  req_perform()

writeLines(resp_body_string(resp), OUT_PATH)

coffee <- read_csv(OUT_PATH, show_col_types = FALSE)
message("Wrote: ", normalizePath(OUT_PATH), " (", nrow(coffee), " rows)")

# To refresh the small illustrative dataset used in the slides
# (data/coffeetruck-demo.csv), play a quick round yourself, then filter down
# to the baseline settings (Music = none, Price = $3, TimeOfDay = Lunch)
# across a handful of Location levels before writing out a subset.
