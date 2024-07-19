-- Data Cleaning

Select *
FROM layoffs;

-- 1. Removing Duplicates (if they are any if we don't need it)
-- 2. Standardize the Data (according to professional standards)
-- 3. Null values or blank values (to populate if we can)
-- 4. Remove colums or rows where its not nessesory 



-- staging area for staging or setting up my work flow to not mess with original data
CREATE TABLE layoffs_staging
LIKE layoffs;
--
-- NEVER work on the raw data its not best practice 
Select *
FROM layoffs_staging;
-- We need to insert the data form the table we are working with to insure that we have workable data to refrence to
INSERT layoffs_staging
SELECT *
FROM layoffs;


SELECT *,
row_number() OVER(
partition by company, industry, total_laid_off, percentage_laid_off,'date') as row_num
FROM layoffs_staging;

WITH duplicate_cte as 
(
SELECT *,
row_number() OVER(
partition by company, location, industry, total_laid_off, percentage_laid_off,'date', 
stage, country, funds_raised_millions) as row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;


SELECT *
FROM layoffs_staging
WHERE company = 'Casper';



WITH duplicate_cte as 
(
SELECT *,
row_number() OVER(
partition by company, location, industry, total_laid_off, percentage_laid_off,'date', 
stage, country, funds_raised_millions) as row_num
FROM layoffs_staging
)
DELETE #The delete stamtment is like an update thats why it didn't update  
FROM duplicate_cte
WHERE row_num > 1;




CREATE TABLE `layoffs_staging2` (
  `company` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `industry` varchar(255) DEFAULT NULL,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` float DEFAULT NULL,
  `date` text,
  `stage` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `funds_raised_millions` float DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

INSERT INTO layoffs_staging2
SELECT *,
row_number() OVER(
partition by company, location, industry, total_laid_off, percentage_laid_off,'date', 
stage, country, funds_raised_millions) as row_num
FROM layoffs_staging;




DELETE
FROM layoffs_staging2
WHERE row_num > 1;

SELECT *
FROM layoffs_staging2;

-- Standardizing Data


SELECT company, trim(company)
FROM layoffs_staging2;


UPDATE layoffs_staging2
SET company = trim(company);

SELECT distinct(industry)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';



SELECT distinct(country), trim(trailing '.' from country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = trim(trailing '.' from country)
WHERE country LIKE 'United States%';

SELECT `date`
FROM layoffs_staging2;



UPDATE layoffs_staging2
SET `date` = str_to_date(`date`,'%m/%d/%Y');

ALTER TABLE layoffs_staging2 -- Only do this with/ when you in your stagging area 
MODIFY COLUMN `date` DATE;


SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

UPDATE layoffs_staging2
SET industry = null
WHERE industry = '';

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging2
WHERE COMPANY LIKE 'Bally%';

SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE t1.industry IS NULL -- Make sure to check both NULL and blank/empty spaces
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL -- Make sure to check both NULL and blank/empty spaces
AND t2.industry IS NOT NULL;

SELECT *
FROM layoffs_staging2;



SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;