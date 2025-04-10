# Set the destination directory
destination <- file.path(getwd(), "housing-price-dataset.zip")

# Run the curl command to download the dataset
system(paste(
  "curl -L -o", destination,
  "https://www.kaggle.com/api/v1/datasets/download/sukhmandeepsinghbrar/housing-price-dataset"
))

# Verify the download
if (file.exists(destination)) {
  cat("File successfully downloaded to:", destination, "\n")
} else {
  cat("Failed to download the file.\n")
}

# Unzip the downloaded file
unzip_dir <- file.path(getwd(), "housing-price-dataset")
unzip(destination, exdir = unzip_dir)
cat("File successfully unzipped to:", unzip_dir, "\n")

data <- read_csv("housing-price-dataset/Housing.csv")

# Load necessary libraries
library(dplyr)

data<-data%>%
mutate(bathrooms = ifelse(is.na(as.numeric(bathrooms)), 0, as.numeric(bathrooms)), 
zipcode = as.factor(zipcode), 
bed_bth_ratio = ifelse(bedrooms == 0, 0, bathrooms / bedrooms), 
`zip code region` = as.factor(ifelse(grepl("980", zipcode), "Region 1", ifelse(grepl("981", zipcode), "Region 2", "Region 3"))), 
`factor levels` = ifelse(bed_bth_ratio == 1, "factor 1", ifelse(bed_bth_ratio > 1, "factor 2", "factor 3")), 
price = log(price), 
sqft_living = log(sqft_living), sqft_living15 = log(sqft_living15),
blocks = ifelse(sqft_living < 7.258, "Block 1", ifelse(sqft_living >= 7.258 & sqft_living < 7.550, "Block 2", ifelse(sqft_living >= 7.550 & sqft_living < 7.832, "Block 3", "Block 4"))))%>%
filter_all(all_vars(!is.na(.)))%>%select(-yr_renovated)

# Remove outliers in the dataset
remove_outliers <- function(data, column) {
  # Calculate the mean and standard deviation
  mean <- mean(data[[column]], na.rm = TRUE)
  max_distance <- sd(data[[column]], na.rm = TRUE) * 3

  # Calculate the absolute difference from the mean for each observation
  abs_diff <- abs(data[[column]] - mean)

  # Identify the outliers
  outliers <- which(abs_diff >= max_distance)

  # Count the number of outliers
  count <- length(outliers)

  # Remove the outliers from the data frame
  data <- data[-outliers, ]

  # Print the count
  print(paste("Number of outliers removed:", count))

  # Return the cleaned data
  return(data)
}

data <- remove_outliers(data, "bathrooms")
data <- remove_outliers(data, "bedrooms")
data<-remove_outliers(data, "sqft_living")
data<-remove_outliers(data, "sqft_living15")

write_csv(data, "Preprocessed_Housing.csv")

# Clean up: remove the downloaded zip file and unzipped directory
file.remove(destination)

if (!file.exists(destination)) {
  cat("Zipped file successfully deleted.\n")
} else {
  cat("Failed to delete the zipped file.\n")
}

