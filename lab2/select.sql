-- Лабораторна робота № 2
-- З дисципліни Бази даних та інформаційні системи
-- Студента групи МІТ-31 Іваницької Анни

-- SYNTAX OF SELECT COMMAND
-- SELECT column1, column2, ...
-- FROM table_name
-- WHERE condition
-- GROUP BY column1
-- HAVING condition
-- ORDER BY column1 ASC/DESC
-- LIMIT n OFFSET m;

-- The WHERE clause filters rows before any grouping or aggregation occurs. It is used to specify conditions on individual rows.
-- The HAVING clause filters groups of rows after they have been grouped by the GROUP BY clause. It is used to specify conditions on groups of rows. 
-- Typically used with aggregate functions to filter groups based on the results of those functions. (COUNT, AVG, MIN, ...)


-- 1. Обрати всі записи з таблиці wood_types
SELECT * FROM wood_types;

-- 2. Обрати всі записи з таблиці wood_characteristics
SELECT * FROM wood_characteristics;

-- 3. Обрати всі записи з таблиці wood_suppliers
SELECT * FROM wood_suppliers;

SELECT * FROM price;

SELECT * FROM common_uses;

SELECT * FROM hardness_char;

-- 4. Обрати певні стовпці з таблиці wood_suppliers
SELECT id, supplier_name FROM wood_suppliers;

-- 5. Обрати певні стовпці з таблиці wood_types
SELECT id, name FROM wood_types;

-- 6. Обрати певні стовпці з таблиці wood_types та вивести тільки ті, що мають певну назву в стовпці common_uses
SELECT name, uses_id FROM wood_types WHERE uses_id = 5;

-- 7. Обрати стовпці з таб. wood_characteristics + вивести тільки ті, що мають певне значення в стовпці hardness
SELECT density, hardness_id FROM wood_characteristics WHERE hardness_id = 1;

-- 8. Обрати стовпці з таб. wood_characteristics + вивести тільки ті, що мають певне значення в стовпці hardness
-- connecting THREE tables
SELECT w.name, wch.density, h.hardness
FROM wood_characteristics AS wch
INNER JOIN hardness_char AS h ON wch.hardness_id = h.id
INNER JOIN wood_types AS w ON wch.id=w.char_id

-- 9. connecting FOUR tables
SELECT w.name, wch.density, h.hardness, cu.common_uses
FROM wood_characteristics AS wch
INNER JOIN hardness_char AS h ON wch.hardness_id = h.id
INNER JOIN wood_types AS w ON wch.id = w.char_id
INNER JOIN common_uses AS cu ON cu.id = w.char_id

-- 10. LEFT JOIN, FULL JOIN (no difference in this example, cause all rows were full with data)
SELECT w.name, wch.density, h.hardness
FROM wood_characteristics AS wch
LEFT JOIN hardness_char AS h ON wch.hardness_id = h.id
LEFT JOIN wood_types AS w ON wch.id=w.char_id


-- 11. Обрати стовпці з таб. wood_types + вивести тільки ті, що починаються з певного символа в стовпці name, %=0 або більше будь-яких символів
SELECT name, scientific_name FROM wood_types WHERE name LIKE 'M%';

-- 12. Select all columns in table wood_characteristics + display which have density > 0.95
SELECT * FROM wood_characteristics WHERE density > 0.95;

-- 13. Select all columns in table wood_characteristics + display which have density <= 0.53
SELECT * FROM wood_characteristics WHERE density <= 0.53;

-- 14. Select all columns in table wood_characteristics + display which have co in color column + sort by density column ASC
SELECT * FROM wood_characteristics WHERE color LIKE 'Co%' ORDER BY density ASC;

-- 15. Select some columns in table wood_characteristics + display which have co in color column + sort by density column DESC
SELECT id, density, color FROM wood_characteristics WHERE color LIKE 'Co%' ORDER BY density DESC;

-- 16. Select some columns in table wood_characteristics + display which have 'B%' in color column + sort by id column DESC
SELECT id, density, color FROM wood_characteristics WHERE color LIKE 'B%' ORDER BY id DESC;

-- 17. Select two columns in table wood_types + sort by name column ASC (by alphabet)
SELECT name, scientific_name FROM wood_types ORDER BY name ASC;

-- 18. Select 2 columns in table wood_types + display which have '%ch%' in name column +  sort by name column DESC (in reverse)
SELECT name, scientific_name FROM wood_types WHERE name LIKE '%ch%' ORDER BY name DESC;

-- 19. Select 3 columns in table wood_types + display which have '%Plywood%' in common_uses column +  sort by scientific_name column ASC
SELECT name, w.scientific_name, cu.common_uses 
FROM wood_types AS w
JOIN common_uses AS cu ON cu.id = w.uses_id
WHERE cu.common_uses LIKE '%Plywood%' ORDER BY scientific_name ASC;

-- 20. CROSS JOIN made all 50 types = Plywood
SELECT name, w.scientific_name, cu.common_uses 
FROM wood_types AS w
CROSS JOIN common_uses AS cu
WHERE cu.common_uses LIKE '%Plywood%' ORDER BY scientific_name ASC;

-- 21. Select 3 columns in table wood_types + display which have '%Musical%' in common_uses column +  sort by image_url column DESC (in reverse)
SELECT name, w.image_url, cu.common_uses 
FROM wood_types AS w
JOIN common_uses AS cu ON cu.id = w.uses_id
WHERE common_uses LIKE '%Musical%' ORDER BY image_url DESC;

-- 22. FOUR tables + looking on the PRICES
SELECT pr.supplier_price, ws.supplier_name, w.name, cu.common_uses
FROM wood_types AS w
JOIN common_uses AS cu ON cu.id = w.uses_id
JOIN price AS pr ON w.id = pr.woodtype_id
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
WHERE pr.supplier_price < 400 ORDER BY pr.supplier_price ASC;

--23. FOUR tables + looking on the PRICES + SORT by supplier_name
SELECT ws.supplier_name, pr.supplier_price, w.name, cu.common_uses
FROM wood_types AS w
JOIN common_uses AS cu ON cu.id = w.uses_id
JOIN price AS pr ON w.id = pr.woodtype_id
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
WHERE pr.supplier_price < 400 ORDER BY ws.supplier_name ASC;

--24. FOUR tables + looking on the HIGHEST PRICES
SELECT pr.supplier_price, ws.supplier_name, w.name, cu.common_uses
FROM wood_types AS w
JOIN common_uses AS cu ON cu.id = w.uses_id
JOIN price AS pr ON w.id = pr.woodtype_id
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
WHERE pr.supplier_price > 1000 ORDER BY pr.supplier_price DESC;

--25. FOUR tables + looking for specific supplier + sort by date
SELECT pr.supplier_price, ws.supplier_name, w.name, pr.sup_date
FROM wood_types AS w
JOIN price AS pr ON w.id = pr.woodtype_id
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
WHERE supplier_name LIKE '%G%' ORDER BY pr.sup_date DESC;

--26. Select 2 rows in wood_suppliers + give new name
SELECT gmail, supplier_name AS "Ім'я" FROM wood_suppliers;

--27. Select 2 rows in wood_suppliers + give new name + set Limit 10
SELECT phone_number, supplier_name AS "Ім'я" FROM wood_suppliers LIMIT 10;

--28. Select 2 rows in wood_suppliers + give new name + set Limit 10 + set start point
SELECT phone_number, supplier_name AS "Ім'я" FROM wood_suppliers LIMIT 10 OFFSET 3;

--29. Select 2 rows in wood_suppliers + give new name + set Limit  + set start point
SELECT supplier_name, gmail AS "Ім'я" FROM wood_suppliers LIMIT 5 OFFSET 11;

-- to check tree id's
SELECT id, name FROM wood_types

-- 30. LOOKING FOR THE CHEAPEST OAK
SELECT w.name, pr.supplier_price, ws.supplier_name, ws.phone_number
FROM price AS pr
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
JOIN wood_types AS w ON w.id = pr.woodtype_id
WHERE pr.woodtype_id = 1 ORDER BY pr.supplier_price ASC;

-- 31. LOOKING WHICH AVG TREE PRICE IS LOWER
SELECT w.name, AVG(pr.supplier_price)
FROM wood_types AS w
JOIN price AS pr ON w.id = pr.woodtype_id
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY w.name
ORDER BY AVG(pr.supplier_price) ASC;


-- 32. ALL DATES with names of suppliers
SELECT pr.sup_date, pr.supplier_price, ws.supplier_name
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id;

-- 33. ALL DATES with names of suppliers
SELECT pr.sup_date, pr.supplier_price, ws.supplier_name
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
WHERE pr.sup_date > '2023-12-01'
ORDER BY pr.sup_date ASC; 

-- 34. ALL DATES with names of suppliers
SELECT pr.sup_date, pr.supplier_price, ws.supplier_name
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
WHERE pr.sup_date BETWEEN '2023-12-01' AND '2024-01-01'
ORDER BY pr.sup_date ASC; 

-- 35. the same, another syntax
SELECT pr.sup_date, pr.supplier_price, ws.supplier_name
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
WHERE pr.sup_date >'2023-12-01' AND pr.sup_date <= '2024-01-01'
ORDER BY pr.sup_date ASC; 

-- 36. more dates
SELECT pr.sup_date, pr.supplier_price, ws.supplier_name
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
WHERE pr.sup_date <'2023-11-01'
ORDER BY pr.sup_date DESC; 

-- 37. ALL DATES with names of suppliers
SELECT pr.sup_date, pr.supplier_price, ws.supplier_name
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
WHERE pr.sup_date BETWEEN '2024-02-01' AND '2024-02-12'
ORDER BY pr.sup_date ASC; 

-- 38. ALL DATES with names of suppliers
SELECT pr.sup_date, pr.supplier_price, ws.supplier_name
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
WHERE pr.sup_date BETWEEN '2023-09-01' AND '2023-10-20'
ORDER BY pr.sup_date DESC; 

-- 39. the same, another syntax
SELECT pr.sup_date, pr.supplier_price, ws.supplier_name
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
WHERE pr.sup_date >='2023-10-02'
ORDER BY pr.sup_date ASC; 


-- 40. ALL MONEY THAT SUPPLIERS EARNED 
SELECT ws.supplier_name, SUM(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
ORDER BY SUM(pr.supplier_price) ASC; 

-- 41. max price of each supplier
SELECT ws.supplier_name, MAX(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
ORDER BY MAX(pr.supplier_price) DESC; 

-- 42. avg price of each supplier
SELECT ws.supplier_name, AVG(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
ORDER BY AVG(pr.supplier_price) ASC; 

-- 43. max price of each supplier that is > 1000
SELECT ws.supplier_name, MAX(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING MAX(pr.supplier_price) > 1000
ORDER BY MAX(pr.supplier_price) DESC; 

-- 44. max price of each supplier that is > 800 + limit
SELECT ws.supplier_name, MAX(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING MAX(pr.supplier_price) > 800
ORDER BY MAX(pr.supplier_price) DESC
LIMIT 5; 

-- 45. max price of each supplier that is > 800 + limit + offset
SELECT ws.supplier_name, MAX(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING MAX(pr.supplier_price) > 800
ORDER BY MAX(pr.supplier_price) DESC
LIMIT 5 OFFSET 2; 

-- 46. min price of each supplier that is < 600
SELECT ws.supplier_name, MIN(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING MIN(pr.supplier_price) < 600
ORDER BY MIN(pr.supplier_price) ASC; 

-- 47. min price of each supplier that is < 600 + limit
SELECT ws.supplier_name, MIN(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING MIN(pr.supplier_price) < 600
ORDER BY MIN(pr.supplier_price) ASC
LIMIT 8; 

-- 48. min price of each supplier that is < 600 + limit + offset
SELECT ws.supplier_name, MIN(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING MIN(pr.supplier_price) < 600
ORDER BY MIN(pr.supplier_price) ASC
LIMIT 5 OFFSET 4; 

-- 49. avg price of each supplier + limit
SELECT ws.supplier_name, AVG(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
ORDER BY AVG(pr.supplier_price) DESC
LIMIT 10; 

-- 50. avg price of each supplier + limit + offset
SELECT ws.supplier_name, AVG(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
ORDER BY AVG(pr.supplier_price) ASC
LIMIT 9 OFFSET 4; 


-- 51. avg price for G names (WHERE)
SELECT ws.supplier_name, AVG(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
WHERE ws.supplier_name LIKE 'G%'
GROUP BY ws.supplier_name;

-- 52. avg price for B names (WHERE)
SELECT ws.supplier_name, AVG(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
WHERE ws.supplier_name LIKE 'A%'
GROUP BY ws.supplier_name;

-- 53. avg price for K names (WHERE)
SELECT ws.supplier_name, AVG(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
WHERE ws.supplier_name LIKE 'K%'
GROUP BY ws.supplier_name;

-- 54. max price for K names (WHERE)
SELECT ws.supplier_name, MAX(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
WHERE ws.supplier_name LIKE 'K%'
GROUP BY ws.supplier_name;

-- 55. max price for E names (WHERE)
SELECT ws.supplier_name, MAX(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
WHERE ws.supplier_name LIKE 'E%'
GROUP BY ws.supplier_name;

-- 56. max price for E names (WHERE)
SELECT ws.supplier_name, MAX(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
WHERE ws.supplier_name LIKE 'H%'
GROUP BY ws.supplier_name;

-- 57. min price for U names (WHERE)
SELECT ws.supplier_name, MIN(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
WHERE ws.supplier_name LIKE 'U%'
GROUP BY ws.supplier_name;

-- 58. min price for M names (WHERE)
SELECT ws.supplier_name, MIN(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
WHERE ws.supplier_name LIKE 'M%'
GROUP BY ws.supplier_name;

-- 59. min price for N names (WHERE)
SELECT ws.supplier_name, MIN(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
WHERE ws.supplier_name LIKE 'N%'
GROUP BY ws.supplier_name;

-- 60. min price for M names (WHERE)
SELECT ws.supplier_name, MIN(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
WHERE ws.supplier_name LIKE 'M%'
GROUP BY ws.supplier_name;


-- 61. min price for M names + (WHERE) HAVING
SELECT ws.supplier_name, MIN(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
WHERE ws.supplier_name LIKE 'M%'
GROUP BY ws.supplier_name
HAVING MIN(pr.supplier_price) >= 300;

-- 62. min price + HAVING 1
SELECT ws.supplier_name, MIN(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING MIN(pr.supplier_price) >= 600;

-- 63. min price + HAVING 3
SELECT ws.supplier_name, MIN(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING MIN(pr.supplier_price) > 800;

-- 64. min price + HAVING 4
SELECT ws.supplier_name, MIN(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING MIN(pr.supplier_price) > 400;

-- 65. min price + HAVING 5
SELECT ws.supplier_name, MIN(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING MIN(pr.supplier_price) < 400;

-- 66. min price + HAVING 6
SELECT ws.supplier_name, MIN(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING MIN(pr.supplier_price) <= 360
ORDER BY MIN(pr.supplier_price) ASC;

-- 67. max price + HAVING 7
SELECT ws.supplier_name, MAX(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING MAX(pr.supplier_price) < 600
ORDER BY MAX(pr.supplier_price) ASC;

-- 68. max price + HAVING 8
SELECT ws.supplier_name, MAX(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING MAX(pr.supplier_price) < 800
ORDER BY MAX(pr.supplier_price) DESC;

-- 69. max price + HAVING 9
SELECT ws.supplier_name, MAX(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING MAX(pr.supplier_price) >= 1000
ORDER BY MAX(pr.supplier_price) DESC;

-- 70. max price + HAVING 10
SELECT ws.supplier_name, MAX(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING MAX(pr.supplier_price) >= 960
ORDER BY MAX(pr.supplier_price) DESC;

-- 71. max price + HAVING 11
SELECT ws.supplier_name, MAX(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING MAX(pr.supplier_price) = 960;

-- 72. avg price + HAVING 12
SELECT ws.supplier_name, AVG(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING AVG(pr.supplier_price) < 500
ORDER BY AVG(pr.supplier_price) ASC;

-- 73. avg price + HAVING 13
SELECT ws.supplier_name, AVG(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING AVG(pr.supplier_price) <= 423
ORDER BY AVG(pr.supplier_price) ASC;

-- 74. avg price + HAVING 14 (range)
SELECT ws.supplier_name, AVG(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING AVG(pr.supplier_price) > 600 AND AVG(pr.supplier_price) < 800
ORDER BY AVG(pr.supplier_price) ASC;

-- 75. avg price + HAVING 15 (range)
SELECT ws.supplier_name, AVG(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING AVG(pr.supplier_price) > 900 AND AVG(pr.supplier_price) < 1100
ORDER BY AVG(pr.supplier_price) DESC;

-- 76. avg price + HAVING 16 (range)
SELECT ws.supplier_name, AVG(pr.supplier_price)
FROM price AS pr 
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING AVG(pr.supplier_price) > 1000;


-- 77. COUNT suppliers' rate 1
SELECT ws.supplier_name, COUNT(pr.supplier_id)
FROM price AS pr
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name;

-- 78. COUNT suppliers' rate 2
SELECT ws.supplier_name, COUNT(pr.supplier_id)
FROM price AS pr
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING COUNT(pr.supplier_id) > 5;

-- 79. COUNT suppliers' rate 3
SELECT ws.supplier_name, COUNT(pr.supplier_id)
FROM price AS pr
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING COUNT(pr.supplier_id) < 5;

-- 80. COUNT suppliers' rate 4
SELECT ws.supplier_name, COUNT(pr.supplier_id)
FROM price AS pr
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING COUNT(pr.supplier_id) = 5;

-- 81. COUNT suppliers' rate 5
SELECT ws.supplier_name, COUNT(pr.supplier_id)
FROM price AS pr
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING COUNT(pr.supplier_id) < 5
ORDER BY COUNT(pr.supplier_id) ASC;

-- 82. COUNT suppliers' rate 6
SELECT ws.supplier_name, COUNT(pr.supplier_id)
FROM price AS pr
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING COUNT(pr.supplier_id) > 5
ORDER BY COUNT(pr.supplier_id) DESC;

-- 83. COUNT suppliers' rate 7
SELECT ws.supplier_name, COUNT(pr.supplier_id)
FROM price AS pr
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING COUNT(pr.supplier_id) > 4
ORDER BY ws.supplier_name ASC;

-- 84. COUNT suppliers' rate 8
SELECT ws.supplier_name, COUNT(pr.supplier_id)
FROM price AS pr
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING COUNT(pr.supplier_id) > 4
ORDER BY ws.supplier_name ASC
LIMIT 10 OFFSET 3;

-- 85. COUNT suppliers' rate 9
SELECT ws.supplier_name, COUNT(pr.supplier_id)
FROM price AS pr
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING COUNT(pr.supplier_id) <= 4
ORDER BY ws.supplier_name DESC
LIMIT 8 OFFSET 2;

-- 86. COUNT suppliers' rate 10
SELECT ws.supplier_name, COUNT(pr.supplier_id)
FROM price AS pr
JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
GROUP BY ws.supplier_name
HAVING COUNT(pr.supplier_id) <= 4
ORDER BY COUNT(pr.supplier_id) ASC
LIMIT 8 OFFSET 2;


-- 87. Use of GROUP BY on hardness + avg on hardness
SELECT h.hardness, AVG(wch.density)
FROM wood_characteristics AS wch
JOIN hardness_char AS h ON h.id = wch.hardness_id
GROUP BY h.hardness
ORDER BY h.hardness DESC;

-- 88. hardness
SELECT h.hardness, MAX(wch.density)
FROM wood_characteristics AS wch
JOIN hardness_char AS h ON h.id = wch.hardness_id
GROUP BY h.hardness
ORDER BY h.hardness DESC;

-- 89. Use of GROUP BY on wood_characteristics table + using HAVING as a condition for group value 
SELECT h.hardness, SUM(wch.density)
FROM wood_characteristics AS wch
JOIN hardness_char AS h ON h.id = wch.hardness_id
GROUP BY h.hardness
HAVING SUM(wch.density) > 10
ORDER BY h.hardness ASC;

-- 90. Use of GROUP BY on wood_characteristics table + using HAVING as a condition for group value 
SELECT h.hardness, SUM(wch.density)
FROM wood_characteristics AS wch
JOIN hardness_char AS h ON h.id = wch.hardness_id
GROUP BY h.hardness
HAVING SUM(wch.density) < 15
ORDER BY h.hardness ASC;

-- 91. TWO tables joined 1
SELECT w.name, w.scientific_name, wch.color
FROM wood_types AS w
JOIN wood_characteristics AS wch ON wch.id = w.char_id;

-- 92. TWO tables joined 2
SELECT w.name, w.scientific_name, wch.color
FROM wood_types AS w
JOIN wood_characteristics AS wch ON wch.id = w.char_id
ORDER BY w.name ASC;

-- 93. TWO tables joined 3
SELECT wch.color, w.scientific_name, w.name
FROM wood_types AS w
JOIN wood_characteristics AS wch ON wch.id = w.char_id
ORDER BY wch.color ASC;

-- 94. TWO tables joined 4
SELECT wch.color, w.scientific_name, w.name, wch.density
FROM wood_types AS w
JOIN wood_characteristics AS wch ON wch.id = w.char_id
ORDER BY wch.color ASC;

-- 95. TWO tables joined 5
SELECT wch.color, w.scientific_name, w.name, wch.density
FROM wood_types AS w
JOIN wood_characteristics AS wch ON wch.id = w.char_id
ORDER BY wch.density DESC;

-- 96. TWO tables joined 6
SELECT wch.color, w.scientific_name, w.name, wch.density
FROM wood_types AS w
JOIN wood_characteristics AS wch ON wch.id = w.char_id
ORDER BY wch.density DESC
LIMIT 5;

-- 97. TWO tables joined 7
SELECT w.name, w.scientific_name, wch.color, wch.density, h.hardness
FROM wood_types AS w
JOIN wood_characteristics AS wch ON wch.id = w.char_id
JOIN hardness_char AS h ON h.id = wch.hardness_id
ORDER BY wch.density DESC;

-- 98. TWO tables joined 8
SELECT w.name, w.scientific_name, wch.color, wch.density, h.hardness
FROM wood_types AS w
JOIN wood_characteristics AS wch ON wch.id = w.char_id
JOIN hardness_char AS h ON h.id = wch.hardness_id
ORDER BY wch.density DESC
LIMIT 10;

-- 99. TWO tables joined 9
SELECT w.name, w.scientific_name, wch.color, wch.density, h.hardness
FROM wood_types AS w
JOIN wood_characteristics AS wch ON wch.id = w.char_id
JOIN hardness_char AS h ON h.id = wch.hardness_id
WHERE h.hardness LIKE 'H%'
ORDER BY wch.density DESC;

-- 100. TWO tables joined 10
SELECT w.name, w.scientific_name, wch.color, wch.density, h.hardness
FROM wood_types AS w
JOIN wood_characteristics AS wch ON wch.id = w.char_id
JOIN hardness_char AS h ON h.id = wch.hardness_id
WHERE h.hardness LIKE 'M%'
ORDER BY wch.density DESC;






-- -- 30. Use of GROUP BY on wood_types table + AVG
-- SELECT common_uses, AVG(sup_id) FROM wood_types GROUP BY common_uses;

-- -- 31. Use of GROUP BY on wood_characteristics table + AVG
-- SELECT hardness, AVG(density) FROM wood_characteristics GROUP BY hardness;

-- -- 32. Use of GROUP BY on wood_characteristics table + MIN value in each group
-- SELECT hardness, MIN(density) FROM wood_characteristics GROUP BY hardness;

-- -- 33. Use of GROUP BY on wood_characteristics table + MAX value in each group
-- SELECT hardness, MAX(density) FROM wood_characteristics GROUP BY hardness;

-- -- 34. Use of GROUP BY on wood_characteristics table + counts amount of rows in each group
-- SELECT hardness, COUNT(density) FROM wood_characteristics GROUP BY hardness;

-- -- 35. Use of GROUP BY on wood_characteristics table + counts deviation (відхилення) in each group
-- SELECT hardness, STDDEV(density) FROM wood_characteristics GROUP BY hardness;


-- -- 36. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id
-- SELECT w.name, s.supplier_name
-- FROM wood_suppliers AS s
-- JOIN wood_types w ON s.id=w.sup_id;

-- -- 37. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id
-- SELECT w.name, s.supplier_name
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id

-- -- 38. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + GROUPING WASNT GOOD HERE
-- SELECT w.name, s.supplier_name
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- GROUP BY s.supplier_name, w.name;

-- -- 39. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + order by w.name
-- SELECT w.name, s.supplier_name
-- FROM wood_suppliers AS s
-- JOIN wood_types w ON s.id=w.sup_id
-- ORDER BY w.name;

-- -- 40. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + WHWER NAME CONDITION + order by w.name + LIMIT
-- SELECT w.name, s.supplier_name
-- FROM wood_suppliers AS s
-- JOIN wood_types w ON s.id=w.sup_id
-- WHERE w.name LIKE '%e%'
-- ORDER BY w.name
-- LIMIT 10;

-- -- 41. Select 1column in wood_types and wood_char + join ids 
-- SELECT wc.density, w.common_uses
-- FROM wood_characteristics AS wc
-- JOIN wood_types w ON wc.id=w.char_id

-- -- 42. Select 1column in wood_types and wood_char + join ids + AVG dencity for common uses + ORDER BY avr dencity ASC
-- SELECT AVG(wc.density), w.common_uses
-- FROM wood_characteristics AS wc
-- JOIN wood_types w ON wc.id=w.char_id
-- GROUP BY w.common_uses
-- ORDER BY AVG(wc.density) ASC;

-- -- 43. Select 1column in wood_types and wood_char + join ids + AVG dencity for common uses + ORDER BY avr dencity DESC + LIMIT
-- SELECT AVG(wc.density), w.common_uses
-- FROM wood_characteristics AS wc
-- JOIN wood_types w ON wc.id=w.char_id
-- GROUP BY w.common_uses
-- ORDER BY AVG(wc.density) DESC
-- LIMIT 10;

-- -- 44. Select 1column in wood_types and wood_char + join ids + MIN dencity for common uses + ORDER BY avr dencity ASC + LIMIT
-- SELECT MIN(wc.density), w.common_uses
-- FROM wood_characteristics AS wc
-- JOIN wood_types w ON wc.id=w.char_id
-- GROUP BY w.common_uses
-- ORDER BY MIN(wc.density) ASC
-- LIMIT 9;

-- -- 45. Select 1column in wood_types and wood_char + join ids + MAX dencity for common uses + ORDER BY avr dencity DESC + LIMIT
-- SELECT MAX(wc.density), w.common_uses
-- FROM wood_characteristics AS wc
-- JOIN wood_types w ON wc.id=w.char_id
-- GROUP BY w.common_uses
-- ORDER BY MAX(wc.density) DESC
-- LIMIT 9;

-- -- 46. Select 1column in wood_types and wood_char + join ids + AVG dencity for common uses + ORDER BY avr dencity DESC + LIMIT + offset
-- SELECT AVG(wc.density), w.common_uses
-- FROM wood_characteristics AS wc
-- JOIN wood_types w ON wc.id=w.char_id
-- GROUP BY w.common_uses
-- ORDER BY AVG(wc.density) DESC
-- LIMIT 6 OFFSET 13;

-- -- 47. Select 1column in wood_types and wood_char + join ids + AVG dencity for common uses + ORDER BY avr dencity DESC + LIMIT + offset
-- SELECT AVG(wc.density), w.common_uses
-- FROM wood_characteristics AS wc
-- JOIN wood_types w ON wc.id=w.char_id
-- GROUP BY w.common_uses
-- HAVING AVG(wc.density) > 0.9
-- ORDER BY AVG(wc.density) DESC;

-- -- 48. Select 1column in wood_types and wood_char + join ids + AVG dencity for common uses + ORDER BY avr dencity DESC + wood_types + HAVING > 0.9
-- SELECT AVG(wc.density), w.common_uses
-- FROM wood_characteristics AS wc
-- JOIN wood_types w ON wc.id=w.char_id
-- GROUP BY w.common_uses
-- HAVING AVG(wc.density) > 0.9
-- ORDER BY AVG(wc.density) DESC;

-- -- 49. Select 1column in wood_types and wood_char + join ids + AVG dencity for common uses + ORDER BY avr dencity DESC + wood_types + HAVING < 0.7
-- SELECT AVG(wc.density), w.common_uses
-- FROM wood_characteristics AS wc
-- JOIN wood_types w ON wc.id=w.char_id
-- GROUP BY w.common_uses
-- HAVING AVG(wc.density) < 0.7
-- ORDER BY AVG(wc.density) DESC;

-- -- 50. Select 1column in wood_types and wood_char + join ids + AVG dencity for common uses + ORDER BY avr dencity DESC + wood_types + HAVING AVG < 0.7 + LIMIT
-- SELECT AVG(wc.density), w.common_uses
-- FROM wood_characteristics AS wc
-- JOIN wood_types w ON wc.id=w.char_id
-- GROUP BY w.common_uses
-- HAVING AVG(wc.density) < 0.7
-- ORDER BY AVG(wc.density) DESC
-- LIMIT 5;

-- -- 51. Select 1column in wood_types and wood_char + join ids + MAX dencity for common uses + ORDER BY avr dencity DESC + wood_types + HAVING MAX < 0.7
-- SELECT MAX(wc.density), w.common_uses
-- FROM wood_characteristics AS wc
-- JOIN wood_types w ON wc.id=w.char_id
-- GROUP BY w.common_uses
-- HAVING MAX(wc.density) < 0.7
-- ORDER BY MAX(wc.density) DESC;

-- -- 52. Select 1column in wood_types and wood_char + join ids + MAX dencity for common uses + ORDER BY avr dencity DESC + wood_types + HAVING MAX > 0.95
-- SELECT MAX(wc.density), w.common_uses
-- FROM wood_characteristics AS wc
-- JOIN wood_types w ON wc.id=w.char_id
-- GROUP BY w.common_uses
-- HAVING MAX(wc.density) > 0.95
-- ORDER BY MAX(wc.density) DESC;

-- -- 53. Select 1column in wood_types and wood_char + join ids + MAX dencity for common uses + ORDER BY avr dencity DESC + wood_types + HAVING MAX > 0.8 + LIMIT 8 + OFFSET 8
-- SELECT MAX(wc.density), w.common_uses
-- FROM wood_characteristics AS wc
-- JOIN wood_types w ON wc.id=w.char_id
-- GROUP BY w.common_uses
-- HAVING MAX(wc.density) > 0.8
-- ORDER BY MAX(wc.density) DESC
-- LIMIT 8 OFFSET 8;

-- -- 54. Select 1column in wood_suppliers and wood_char + join ids 
-- SELECT ws.contact_info, wc.color
-- FROM wood_characteristics AS wc
-- JOIN wood_suppliers ws ON wc.id=ws.id;

-- -- 55. Select 1column in wood_suppliers and wood_char + join ids + the same but different syntax + order by color asc
-- SELECT ws.contact_info, wc.color
-- FROM wood_characteristics AS wc
-- JOIN wood_suppliers ws USING(id)
-- ORDER BY color ASC;

-- -- 56. Select 1column in wood_suppliers and wood_char + join ids + the same but different syntax + order by color desc
-- SELECT ws.contact_info, wc.color
-- FROM wood_characteristics AS wc
-- JOIN wood_suppliers ws USING(id)
-- ORDER BY color DESC;

-- -- 57. Select 1column in wood_suppliers and wood_char + join ids + the same but different syntax + order by color asc + limit
-- SELECT ws.contact_info, wc.color
-- FROM wood_characteristics AS wc
-- JOIN wood_suppliers ws USING(id)
-- ORDER BY color ASC
-- LIMIT 10;

-- -- 58. Select 1column in wood_suppliers and wood_char + join ids + the same but different syntax + order by hardness asc
-- SELECT ws.contact_info, wc.color, wc.hardness
-- FROM wood_characteristics AS wc
-- JOIN wood_suppliers ws USING(id)
-- ORDER BY hardness ASC;

-- -- 59. Select 1column in wood_suppliers and wood_char + join ids + the same but different syntax + order by hardness asc
-- SELECT COUNT(id), hardness
-- FROM wood_characteristics
-- GROUP BY hardness
-- ORDER BY COUNT(hardness) ASC;

-- -- 60. Count amount by groups of hardness
-- SELECT COUNT(id), hardness
-- FROM wood_characteristics
-- GROUP BY hardness

-- -- 61. COUNT amount by groups of hardness + order by count asc
-- SELECT COUNT(id), hardness
-- FROM wood_characteristics
-- GROUP BY hardness
-- ORDER BY COUNT(hardness) ASC;

-- -- 62. COUNT amount by groups of hardness + order by count asc
-- SELECT COUNT(id), hardness
-- FROM wood_characteristics
-- GROUP BY hardness
-- ORDER BY COUNT(hardness) DESC;

-- -- 63. COUNT amount by groups of hardness + order by count desc + having (condition)
-- SELECT COUNT(id), hardness
-- FROM wood_characteristics
-- GROUP BY hardness
-- HAVING COUNT(id) > 16
-- ORDER BY COUNT(hardness) DESC;

-- -- 64. COUNT amount by groups of hardness + order by count desc + having (condition2)
-- SELECT COUNT(id), hardness
-- FROM wood_characteristics
-- GROUP BY hardness
-- HAVING COUNT(id) < 17
-- ORDER BY COUNT(hardness) DESC;

-- -- 65. COUNT amount by groups of hardness + order by count desc + having (condition3)
-- SELECT COUNT(id), hardness
-- FROM wood_characteristics
-- GROUP BY hardness
-- HAVING COUNT(id) < 20
-- ORDER BY COUNT(hardness) DESC;

-- -- 66. COUNT amount by groups of hardness + order by count desc + having (condition3)
-- SELECT COUNT(id), hardness
-- FROM wood_characteristics
-- GROUP BY hardness
-- HAVING COUNT(id) <= 20
-- ORDER BY COUNT(hardness) ASC;


-- -- 67. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id
-- SELECT w.name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id;

-- -- 68. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id
-- SELECT w.name, s.supplier_id, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id;

-- -- 69. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id
-- SELECT w.name, s.supplier_id, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id;

-- -- 70. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id
-- SELECT w.name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id;

-- -- 71. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + order by supplier_name asc
-- SELECT w.name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- ORDER BY s.supplier_name ASC;

-- -- 72. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + order by supplier_name desc + limit
-- SELECT w.name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- ORDER BY s.supplier_name DESC
-- LIMIT 7;

-- -- 73. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + order by name asc
-- SELECT w.name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- ORDER BY w.name ASC;

-- -- 74. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + order by name desc
-- SELECT w.name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- ORDER BY w.name DESC;

-- -- 75. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + order by name desc + LIMIT + OFFSET
-- SELECT w.name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- ORDER BY w.name DESC
-- LIMIT 5 OFFSET 10;

-- -- 76. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + order by name asc + LIMIT + OFFSET
-- SELECT w.name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- ORDER BY w.name ASC
-- LIMIT 8 OFFSET 12;

-- -- 77. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %A%
-- SELECT w.name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.name LIKE '%A%';

-- -- 78. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %ca%%
-- SELECT w.name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.name LIKE '%ca%';

-- -- 79. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %B%
-- SELECT w.name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.name LIKE '%B%';

-- -- 80. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where B%
-- SELECT w.name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.name LIKE 'B%';

-- -- 81. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %C%
-- SELECT w.name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.name LIKE '%C%';

-- -- 82. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where C%
-- SELECT w.name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.name LIKE 'C%';

-- -- 83. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %Ch%
-- SELECT w.name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.name LIKE '%Ch%';

-- -- 84. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %E%
-- SELECT w.name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.name LIKE '%E%';

-- -- 85. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %E% + order
-- SELECT w.name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.name LIKE '%E%'
-- ORDER BY w.name DESC;

-- -- 86. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %F% + order
-- SELECT w.name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.name LIKE '%F%'
-- ORDER BY w.name DESC;

-- -- 87. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %F% + order
-- SELECT w.name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.name LIKE '%ro%'
-- ORDER BY w.name DESC;

-- -- 88. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %r% + order + scientific_name
-- SELECT w.scientific_name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.name LIKE '%r%'
-- ORDER BY w.scientific_name DESC;

-- -- 89. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %ro% + order + scientific_name + desc
-- SELECT w.scientific_name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.scientific_name LIKE '%ro%'
-- ORDER BY w.scientific_name DESC;

-- -- 90. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %ro% + order + scientific_name + asc
-- SELECT w.scientific_name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.scientific_name LIKE '%ro%'
-- ORDER BY w.scientific_name ASC;

-- -- 91. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %ro% + order + scientific_name + asc
-- SELECT w.scientific_name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.scientific_name LIKE 'A%'
-- ORDER BY w.scientific_name ASC;

-- -- 92. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where A% + order + scientific_name + asc + limit
-- SELECT w.scientific_name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.scientific_name LIKE 'A%'
-- ORDER BY w.scientific_name ASC
-- LIMIT 5;

-- -- 93. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where C% + order + scientific_name + asc
-- SELECT w.scientific_name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.scientific_name LIKE 'C%'
-- ORDER BY w.scientific_name ASC;

-- -- 94. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %C% + order + scientific_name + asc
-- SELECT w.scientific_name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.scientific_name LIKE '%C%'
-- ORDER BY w.scientific_name ASC;

-- -- 95. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %F% + order + scientific_name + asc
-- SELECT w.scientific_name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.scientific_name LIKE '%F%'
-- ORDER BY w.scientific_name ASC;

-- -- 96. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %S% + order + scientific_name + asc
-- SELECT w.scientific_name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.scientific_name LIKE '%S%'
-- ORDER BY w.scientific_name ASC;

-- -- 96. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %S% + order + scientific_name + desc
-- SELECT w.scientific_name, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.scientific_name LIKE '%S%'
-- ORDER BY w.scientific_name DESC;

-- -- 97. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %S% + order + scientific_name + desc
-- SELECT w.scientific_name, w.name, s.supplier_name
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.scientific_name LIKE '%S%'
-- ORDER BY w.scientific_name DESC;

-- -- 98. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %S% + order + scientific_name + asc
-- SELECT w.scientific_name, w.name, w.common_uses, s.supplier_name
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.scientific_name LIKE '%S%'
-- ORDER BY w.scientific_name ASC;

-- -- 99. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %J% + order + scientific_name + asc
-- SELECT w.scientific_name, w.name, w.common_uses, s.supplier_name
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.scientific_name LIKE '%J%'
-- ORDER BY w.scientific_name ASC;

-- -- 100. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %S% + order + scientific_name + desc
-- SELECT w.scientific_name, w.name, w.common_uses, s.supplier_name, s.contact_info
-- FROM wood_suppliers AS s
-- JOIN wood_types AS w ON s.id=w.sup_id
-- WHERE w.scientific_name LIKE '%J%'
-- ORDER BY w.scientific_name DESC;

-- -- Висновок: у ході лабораторної роботи було детально опрацьовано всі аргументи SELECT 
-- -- в різних комбінаціях та варіаціях. Були задіяні три таблиці, що були заповнені певними 
-- -- даними, для роботи з SELECT.