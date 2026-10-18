# Saved from slides/14 setup chunk when the lecture was refactored.
# Draft simulation of a 10,000-galaxy "population" built from Hubble 1929/1931 values.
# 1. Load required library
library(dplyr)

# ==============================================================================
# STEP 1: CREATE THE HISTORICAL SAMPLE DATA FRAME (n = 32)
# ==============================================================================

# Original 1929 Points
hubble_1929 <- data.frame(
  galaxy   = c("S. Mag.", "L. Mag.", "NGC 224", "NGC 598", "NGC 221", "NGC 4736", 
               "NGC 5055", "NGC 5194", "NGC 4826", "NGC 5236", "NGC 1068", "NGC 5457", 
               "NGC 4753", "NGC 5585", "NGC 4449", "NGC 4649", "NGC 4486", "NGC 4151", 
               "NGC 4621", "NGC 4526", "NGC 4565", "NGC 4594", "NGC 5005", "NGC 5846"),
  distance = c(0.032, 0.034, 0.275, 0.275, 0.275, 0.9, 0.9, 0.9, 0.9, 0.9, 1.0, 
               1.4, 1.4, 1.4, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0, 2.0),
  velocity = c(170, 290, -130, -70, -185, 290, 200, 290, 150, -30, 920, 200, 
               290, 300, 200, 1090, 800, 960, 500, 850, 500, 1140, 900, -30),
  source   = "1929 Original Sample"
)

# 1931 Cluster Additions
hubble_1931 <- data.frame(
  galaxy   = c("Virgo Cluster", "Pegasus Cluster", "Pisces Cluster", "Cancer Cluster", 
               "Perseus Cluster", "Coma Cluster", "Ursa Major Cluster", "Leo Cluster"),
  distance = c(2.0, 11.5, 12.0, 15.0, 16.0, 26.0, 26.0, 32.0),
  velocity = c(890, 3810, 4630, 4820, 5230, 7500, 11800, 19600),
  source   = "1931 Cluster Additions"
)

# Combine historical vectors
historical_sample <- rbind(hubble_1929, hubble_1931)

# ==============================================================================
# STEP 2: EXTRACT TREND PARAMETERS & SIMULATE THE POPULATION (N = 10,000)
# ==============================================================================

# Extract realistic linear baseline constraints from historical vectors
fit_real     <- lm(velocity ~ distance, data = historical_sample)
true_coefs   <- coef(fit_real)
residual_sd  <- sigma(fit_real)

set.seed(101)
N_population  <- 10000
N_simulated   <- N_population - nrow(historical_sample)

# Generate unobserved cosmic population data using extracted parameters
pop_distance  <- runif(N_simulated, min = 0.03, max = 35.0)
pop_velocity  <- true_coefs[1] + (true_coefs[2] * pop_distance) + rnorm(N_simulated, mean = 0, sd = residual_sd)

simulated_population <- data.frame(
  galaxy   = paste0("Gal_", 1:N_simulated),
  distance = pop_distance,
  velocity = pop_velocity,
  source   = "Unobserved Population Structure"
)

# Match historical metadata structure to seamlessly merge them into the population master
historical_for_pop <- historical_sample %>% 
  mutate(source = "Historical Base Points")

# Final merged complete population dataframe containing the sample baseline
cosmic_population <- rbind(simulated_population, historical_for_pop)
