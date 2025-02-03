# Layoff Data Cleaning and EDA Project

This project focuses on cleaning and performing exploratory data analysis (EDA) on a dataset related to layoffs across various companies and industries. The dataset was cleaned and processed using SQL to ensure its consistency and accuracy, followed by detailed exploratory analysis to uncover key insights.

## Project Overview

The dataset contains information about companies that have conducted layoffs, including the number of employees laid off, the industry, the location, and other relevant details. The goal of this project was to clean the data and perform various analyses to uncover trends and patterns regarding layoffs across industries and time.

## Key Steps

### 1. Data Cleaning
The data cleaning process involved several key steps:
- **Removing Duplicate Records**: Identified and removed duplicate entries to ensure data accuracy.
- **Trimming Whitespaces**: Removed unnecessary spaces in string fields such as company names, industry, and country.
- **Fixing Inconsistent Values**: Standardized certain fields, like the `industry` column, to ensure consistency.
- **Handling Missing Data**: Addressed missing values by replacing them with appropriate data or marking them as `NULL` where necessary.
- **Converting Data Types**: Ensured that the `date` field was correctly formatted to a `DATE` type.

### 2. Exploratory Data Analysis (EDA)
Key analyses conducted on the cleaned data include:
- **Summarizing Total Layoffs**: Grouped data by company, industry, country, and year to analyze total layoffs.
- **Visualizing Trends Over Time**: Explored the relationship between layoffs and dates to identify any patterns or trends over the years.
- **Analyzing Industry-Specific Trends**: Investigated how layoffs were distributed across different industries and which ones had the most significant impacts.
- **Yearly Analysis**: Analyzed layoffs by year to observe changes over time.
- **Top Layoff Companies**: Identified the companies with the highest number of layoffs in each year.
