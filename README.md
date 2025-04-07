# House Price Analysis: The Impact of Bathroom-to-Bedroom Ratio
This repository details an analysis designed to determine if houses with equal to or more bathrooms than bedrooms tend to cost more across all price ranges. The study employs a complete randomized block design, with blocks defined by quantiles of the bathroom-to-bedroom ratio, an F-test to assess differences, and bootstrap confidence intervals to validate the results.
Overview
The key steps in our analysis are as follows:
- Ratio Calculation: Compute the bathroom-to-bedroom ratio for every house.
- Randomized Block Design: Partition the dataset into blocks based on quantile ranges of the ratio and randomize within each block.
- Statistical Testing: Perform an F-test to evaluate whether houses with a higher proportion of bathrooms (i.e., equal or more bathrooms relative to bedrooms) are priced higher.
- Bootstrap Analysis: Estimate confidence intervals within each block via bootstrap resampling to measure reliability of the effect.

## Methodology
### 1. Ratio Calculation
- Metric Definition:
The primary metric is defined as:    ![image](https://github.com/user-attachments/assets/ddb05d40-6554-463a-8eb9-a2ed58cd9e63)

- Implementation:
Using the raw dataset, each house’s ratio is computed to capture the amenity balance between bathrooms and bedrooms. This ratio serves as a continuous variable that informs subsequent grouping and testing steps.

### 2. Randomized Block Design
- Design Rationale:
To account for inherent variability in housing data, a complete randomized block design was adopted. By grouping houses with similar bathroom-to-bedroom ratios (based on quantiles), we control for extraneous variation that could cloud the relationship between the ratio and house prices.
- Blocking by Quantile:
The full range of ratio values was divided into several quantile-based blocks. Houses falling within the same quantile are assumed to be more comparable.
- Randomization within Blocks:
Within each block, the order of cases or assignment to treatment comparisons was randomized. This ensures that any systematic biases are minimized and that our subsequent statistical tests are more robust.

### 3. F-Test Analysis
- Objective:
An F-test was conducted to compare the variance between groups (houses grouped by the bathroom-to-bedroom ratio) relative to the variance within groups.
- Findings:
Results from the F-test indicated a statistically significant difference in house prices: houses with equal to or more bathrooms relative to bedrooms consistently tend to be more expensive, regardless of the overall price range.

### 4. Bootstrap Confidence Intervals
- Purpose:
To further assess the precision and stability of our findings, bootstrap resampling was performed within each block.
- Process:- A large number of bootstrap samples were generated from each quantile-defined block.
- Confidence intervals were computed for key statistics (e.g., mean differences in pricing) using these resampled datasets.

- Outcome:
The bootstrap confidence intervals reinforced the F-test results, providing additional evidence that the observed effect is statistically reliable.

## Conclusion
The combined analysis demonstrates that houses with a bathroom-to-bedroom ratio indicating equal to or more bathrooms than bedrooms are statistically priced higher across all examined price ranges. The robust approach—using a complete randomized block design, F-test, and bootstrap confidence intervals—ensures that our findings are both reliable and valid.

This README provides a clear narrative of how the analysis was performed, ensuring that readers understand the data treatment, experimental design, and statistical testing that support our findings. 

### Accessing the Data

[Kaggle Getting Started](https://www.kaggle.com/docs/api#authentication)
