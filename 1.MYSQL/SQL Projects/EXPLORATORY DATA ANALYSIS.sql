-- EXPLORATORY DATA ANALYSIS

SELECT *
FROM layoffs_staging2;

-- looking at which companies laid of the most people and what was the highest recorded layoffs made
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;
-- Looking at companies that closed down or went bankrupt or under
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;
-- Looking at the group by total laid off
SELECT company,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;
-- looking at date ranges to when people where laid off
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

-- Looking at verious or different things like industry, country etc
SELECT country,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT * #looking at the whole table
FROM layoffs_staging2;

SELECT YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;


SELECT stage,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- looking at percentages laid off 
SELECT company,SUM(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- doing rolling sums or total of layoffs

SELECT substring(`date`,
1/*this the column position*/,
7 /*the position of the date format so year month(this is position 2) day*/) AS `MONTH`,
SUM(total_laid_off)
FROM layoffs_staging2
WHERE substring(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

WITH Rolling_total AS
(
SELECT substring(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE substring(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_off,
SUM(total_off) OVER (ORDER BY `MONTH`) AS Rolling_total
FROM Rolling_Total;

-- looking at layoffs by company and date
SELECT company,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;


SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company,YEAR(`date`)
ORDER BY 3 DESC;

With Company_year (company, years, total_laid_off) As
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company,YEAR(`date`)
),
Company_year_Rank As
(
SELECT *, 
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) Ranking
FROM Company_year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_year_Rank
WHERE Ranking <= 5
;