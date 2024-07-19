-- Staging area for setting up the workflow to avoid messing with original data
CREATE TABLE layoffs_staging 
LIKE layoffs;

-- Insert data into the staging table to ensure we have workable data to reference
INSERT INTO layoffs_staging
SELECT * FROM layoffs;

-- Identify duplicates using row_number()
WITH duplicate_cte AS (
    SELECT *,
    ROW_NUMBER() OVER (
        PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, 
        stage, country, funds_raised_millions
        ORDER BY company, location, industry, total_laid_off, percentage_laid_off, `date`, 
        stage, country, funds_raised_millions
    ) AS row_num
    FROM layoffs_staging
)
-- Delete duplicates
DELETE FROM layoffs_staging
WHERE company IN (
    SELECT company
    FROM duplicate_cte
    WHERE row_num > 1
);

-- Check to ensure duplicates are removed
SELECT * 
FROM layoffs_staging;

-- Creating a second staging table for further processing
CREATE TABLE layoffs_staging2 AS
SELECT * 
FROM layoffs_staging;

-- Trimming company names
UPDATE layoffs_staging2
SET company = TRIM(company);

-- Standardizing industry names
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Cleaning country names
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- Converting date to proper format
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2 -- Only do this in your staging area 
MODIFY COLUMN `date` DATE;

-- Handling null values
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

-- Filling in missing industry data
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- Removing rows with missing critical data
DELETE FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Dropping unnecessary columns
ALTER TABLE layoffs_staging2 DROP COLUMN row_num;

-- Final cleaned data
SELECT * 
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE company = 'Casper';
