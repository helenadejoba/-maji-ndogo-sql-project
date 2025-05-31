SHOW Tables;
SELECT 
    *
FROM
    data_dictionary;
SELECT 
    *
FROM
    location
LIMIT 5;

SELECT 
    *
FROM
    visits
LIMIT 5;

SELECT 
    *
FROM
    water_source
LIMIT 5;

SELECT DISTINCT
    type_of_water_source
FROM
    water_source;
    
-- Write an SOL query that retrieves all records from this table where the time in_ queue
-- is more than some crazy time, say 500 min. How would it feel to queue 8 hours for water?
SELECT 
    *
FROM
    visits
WHERE
    time_in_queue > 500
LIMIT 10;

SELECT 
    *
FROM
    water_source
WHERE
    source_id IN ('AkKi00881224' , 'SoRu37635224',
        'SoRu36096224',
        'AmRu14089224',
        'AkRu0water_quality5234224',
        'HaZa21742224',
        'KiRu28935224');

SELECT 
    *
FROM
    water_quality
LIMIT 5;

-- where the subject_quality_score is 10 -- only looking for home taps -- 
-- and where the source was visited a second time. What will this tell us?
SELECT 
    *
FROM
    water_quality
WHERE
    subjective_quality_score = 10
        AND visit_count = 2;
        
SELECT 
    *
FROM
    well_pollution
LIMIT 5;

-- a query that checks if the results is Clean but the biological column is > 0.81.
SELECT 
    *
FROM
    well_pollution
WHERE
    results = 'clean' AND biological > 0.01;
    
    -- we need to indentify the  records that mistakenly have the world clean in the
SELECT 
    *
FROM
    well_pollution
WHERE
    results = 'clean' AND biological > 0.01
        AND description LIKE 'clean%';
    
CREATE TABLE well_pollution_copy AS (SELECT * FROM
    well_pollution);
-- Case 1a: Update descriptions that mistakenly mention 'Clean Bacteria: E. coli to
-- 'Bacteria: E. coli'
SELECT 
    *
FROM
    well_pollution
WHERE
    results = 'clean' AND biological > 0.01
        AND description LIKE 'clean%';
        
        SET session sql_safe_updates = OFF;
        
UPDATE well_pollution 
SET 
    description = 'Bacteria: E. coli'
WHERE
    description = 'Clean Bacteria: E. coli';
        
-- Case 1b: Update the descriptions that mistakenly mention
-- 'Clean ' to Bacteria: Giardia Lamblia to 'Bacteria: Giardia Lamblia'
	UPDATE well_pollution 
SET 
    description = 'Bacteria: Giardia Lamblia'
WHERE
    description = 'Clean Bacteria: Giardia Lamblia';
    
-- Case 2: Update the "result' to ':Contaminated: Biological' where
-- 'biological is greater than 0.01 plus current results is 'Clean'
UPDATE well_pollution 
SET 
    results = 'Contaminated: Biological'
WHERE
    biological > 0.01 AND results = 'Clean';



