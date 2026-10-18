# Cosmicflows-4 (Tully et al. 2023, ApJ 944, 94), galaxy GROUPS table.
# Source: VizieR catalog J/ApJ/944/94, table "groups".
# We use groups rather than individual galaxies so that rows are independent
# (galaxies in the same group share one distance and one velocity).
#   distance_mpc: luminosity distance in megaparsecs (Dist)
#   velocity_kms: recession velocity relative to the cosmic microwave
#                 background, in km/s (V3k)
url <- paste0(
  "https://vizier.cds.unistra.fr/viz-bin/asu-tsv?-source=J/ApJ/944/94/groups",
  "&-out=1PGC,Ngal,Dist,V3k&-out.max=unlimited"
)
raw <- read.delim(url, comment.char = "#", skip = 0, stringsAsFactors = FALSE)
raw <- raw[-c(1, 2), ]  # drop the units and dashes rows

cf4 <- data.frame(
  pgc          = as.integer(raw$X1PGC),
  n_galaxies   = as.integer(raw$Ngal),
  distance_mpc = as.numeric(raw$Dist),
  velocity_kms = as.numeric(raw$V3k)
)
cf4 <- cf4[complete.cases(cf4) & cf4$distance_mpc > 0, ]
write.csv(cf4, "data/cosmicflows4.csv", row.names = FALSE)
