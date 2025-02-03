-- CLEANING THE DATA

SELECT *
FROM layoffs;

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging 
SELECT *
FROM layoffs;

SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, industry, total_laid_off,`date`) AS row_num
FROM layoffs_staging;
        
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;
        
        
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM layoffs_staging
)
DELETE
FROM duplicate_cte
WHERE row_num > 1;




CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` text,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` text,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT *
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM layoffs_staging
WHERE row_num > 1;


DELETE
FROM duplicate_cte
WHERE row_num > 1;

SELECT *
FROM layoffs_staging2;


SELECT company,(TRIM(company))
FROM layoffs_staging2;


UPDATE layoffs_staging2
SET company = TRIM(company);



SELECT DISTINCT industry
FROM layoffs_staging2;


UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';


SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT `date`
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;



SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';


SELECT *
FROM layoffs_staging2
WHERE industry is NULL
OR industry = '';


SELECT *
FROM layoffs_staging2
WHERE company = 'Bally%';


SELECT*
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    AND t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;


UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;

-- EXPLORATORY DATA ANALYSIS


SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;


SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;


SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;


SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;


SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;


SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;


SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;


WITH Rolling_Sum AS
(
SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off) AS Total_off 
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY `MONTH` 
)
SELECT `MONTH`, Total_off, SUM(Total_Off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Sum;


SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;


WITH rank_laid_off AS
(
SELECT company, YEAR(`date`) AS years, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
GROUP BY company, years
ORDER BY 3 DESC
), Company_year_ranking AS
(
SELECT company, years, total_off,
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_off DESC) AS ranking
FROM rank_laid_off
WHERE years IS NOT NULL
)
-- Selecting the top 5 companies with the most layoffs for each year
SELECT *
FROM Company_year_ranking
WHERE ranking <= 5;
















        
        
        
        
        
        