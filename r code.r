# Load necessary libraries
library(ggplot2)

# Generate sample data
set.seed(123)
data <- data.frame(
  group = rep(c("A", "B"), each = 50),
  score = c(rnorm(50, mean = 75, sd = 10), rnorm(50, mean = 80, sd = 12))
)

# View the first few rows of the data
head(data)

# Summary statistics
summary_stats <- data.frame(
  group = c("A", "B"),
  mean = tapply(data$score, data$group, mean),
  sd = tapply(data$score, data$group, sd),
  median = tapply(data$score, data$group, median),
  min = tapply(data$score, data$group, min),
  max = tapply(data$score, data$group, max)
)

print("Summary Statistics:")
print(summary_stats)

# Perform a t-test to compare the means of the two groups
t_test_result <- t.test(score ~ group, data = data)
print("T-Test Result:")
print(t_test_result)

# Create a simple linear regression model
model <- lm(score ~ group, data = data)
print("Linear Regression Model Summary:")
print(summary(model))

# Plot the data
ggplot(data, aes(x = group, y = score, color = group)) +
  geom_boxplot() +
  geom_jitter(width = 0.2) +
  theme_minimal() +
  labs(title = "Boxplot of Scores by Group", x = "Group", y = "Score")

# Plot the regression line
ggplot(data, aes(x = as.numeric(group), y = score)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  theme_minimal() +
  labs(title = "Linear Regression of Scores by Group", x = "Group (Numeric)", y = "Score")
