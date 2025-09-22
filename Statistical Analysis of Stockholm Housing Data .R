# =====================================================================
# Statistical Analysis of Housing Market Data in Stockholm
# Author: Prashant Kumar Singh
# =====================================================================

# ---- Setup ----
library(readxl)
library(dplyr)
library(DescTools)
library(e1071)
library(mosaic)

# Use here::here() if project root is set up with RStudio Project
data_path <- file.path("data", "dataset03.xlsx")
DataSet <- read_xlsx(data_path)

# Convert categorical variables into factors
DataSet <- DataSet %>%
  mutate(
    REGION  = factor(REGION),
    TYPE    = factor(TYPE),
    BALCONY = factor(BALCONY)
  )

# Check for missing values
if (sum(is.na(DataSet)) > 0) {
  warning("Dataset contains missing values!")
}

# =====================================================================
# Exercise 1 – Descriptive Statistics of Starting Price
# =====================================================================

mean_sp <- mean(DataSet$STARTING_PRICE)
median_sp <- median(DataSet$STARTING_PRICE)
mode_sp <- Mode(DataSet$STARTING_PRICE)

quantiles_sp <- quantile(DataSet$STARTING_PRICE)
IQR_sp <- IQR(DataSet$STARTING_PRICE)
range_sp <- diff(range(DataSet$STARTING_PRICE))

sd_sp  <- sd(DataSet$STARTING_PRICE)
var_sp <- var(DataSet$STARTING_PRICE)
skewness_sp <- skewness(DataSet$STARTING_PRICE)

outliers <- subset(
  DataSet,
  STARTING_PRICE < quantiles_sp[2] - 1.5 * IQR_sp |
    STARTING_PRICE > quantiles_sp[4] + 1.5 * IQR_sp
)

# Plotting
hist(DataSet$STARTING_PRICE,
     main = "Histogram of Starting Price",
     xlab = "Starting Price"
)
boxplot(DataSet$STARTING_PRICE,
        main = "Boxplot of Starting Price",
        ylab = "Starting Price"
)

# =====================================================================
# Exercise 2 – Housing Type by Region
# =====================================================================

tally_total <- tally(~ REGION + TYPE, data = DataSet)
tally_proportion <- tally(~ REGION + TYPE, data = DataSet, margins = TRUE, format = "proportion")

barplot(
  t(tally_total),
  main = "Housing Types by Region",
  xlab = "Regions",
  legend = colnames(tally_total),
  col = c("red", "blue", "green")
)

# =====================================================================
# Exercise 3 – Area by Region
# =====================================================================

fav_stats <- favstats(~ AREA | REGION, data = DataSet)
boxplot(AREA ~ REGION, data = DataSet, main = "Area by Region")

# =====================================================================
# Exercise 4 – Correlation between Area and Price
# =====================================================================

plot(DataSet$AREA, DataSet$STARTING_PRICE,
     main = "Scatterplot of Area vs Starting Price",
     xlab = "Area",
     ylab = "Starting Price",
     col = "blue"
)
cor_pearson  <- cor(DataSet$AREA, DataSet$STARTING_PRICE, method = "pearson")
cor_spearman <- cor(DataSet$AREA, DataSet$STARTING_PRICE, method = "spearman")
cor_kendall  <- cor(DataSet$AREA, DataSet$STARTING_PRICE, method = "kendall")

# =====================================================================
# Exercise 5 – Simple Linear Regression
# =====================================================================

simple_reg <- lm(STARTING_PRICE ~ AREA, data = DataSet)
summary(simple_reg)

plot(DataSet$AREA, DataSet$STARTING_PRICE,
     main = "Linear Regression of Starting Price vs. Area",
     xlab = "Area",
     ylab = "Starting Price",
     col = "blue"
)
abline(simple_reg, col = "orange", lwd = 2.5)

# =====================================================================
# Exercise 6 – Multiple Regression
# =====================================================================

mult_reg <- lm(STARTING_PRICE ~ REGION + TYPE + BALCONY + ROOMS + AREA,
               data = DataSet)
summary(mult_reg)

# =====================================================================
# Exercise 7 – Prediction on Test Data
# =====================================================================

test_path <- file.path("data", "test.xlsx")
test_data <- read_xlsx(test_path) %>% as.data.frame()
predicted_values <- predict(mult_reg, test_data)

# Save predictions
write.csv(predicted_values, file = "results/predicted_values.csv", row.names = FALSE)
