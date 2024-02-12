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


-- 1. Обрати всі записи з таблиці wood_types
SELECT * FROM wood_types

-- 2. Обрати всі записи з таблиці wood_characteristics
SELECT * FROM wood_characteristics

-- 3. Обрати всі записи з таблиці wood_suppliers
SELECT * FROM wood_suppliers;

-- 4. Обрати певні стовпці з таблиці wood_suppliers
SELECT id, supplier_name FROM wood_suppliers;

-- 5. Обрати певні стовпці з таблиці wood_types
SELECT id, name FROM wood_types;

- 6. Обрати певні стовпці з таблиці wood_types та вивести тільки ті, що мають певну назву в стовпці common_uses
SELECT name, common_uses FROM wood_types WHERE common_uses = 'Furniture, Flooring';

-- 7. Обрати стовпці з таб. wood_characteristics + вивести тільки ті, що мають певне значення в стовпці hardness
SELECT density, hardness FROM wood_characteristics WHERE hardness = 'Soft';

-- 8. Обрати стовпці з таб. wood_characteristics + вивести тільки ті, що мають певне значення в стовпці hardness, %=0 або більше будь-яких символів
SELECT density, hardness FROM wood_characteristics WHERE hardness LIKE 'M%';

-- 9. Обрати стовпці з таб. wood_types + вивести тільки ті, що починаються з певного символа в стовпці name
SELECT name, scientific_name FROM wood_types WHERE name LIKE 'M%';

--10. Select all columns in table wood_characteristics + display which have density > 0.95
SELECT * FROM wood_characteristics WHERE density > 0.95;

--11. Select all columns in table wood_characteristics + display which have density <= 0.53
SELECT * FROM wood_characteristics WHERE density <= 0.53;

--12. Select all columns in table wood_characteristics + display which have co in color column + sort by density column ASC
SELECT * FROM wood_characteristics WHERE color LIKE 'Co%' ORDER BY density ASC;

--13. Select some columns in table wood_characteristics + display which have co in color column + sort by density column DESC
SELECT id, density, color FROM wood_characteristics WHERE color LIKE 'Co%' ORDER BY density DESC;

--14. Select some columns in table wood_characteristics + display which have 'B%' in color column + sort by id column DESC
SELECT id, density, color FROM wood_characteristics WHERE color LIKE 'B%' ORDER BY id DESC;

--15. Select two columns in table wood_types + sort by name column ASC (by alphabet)
SELECT name, scientific_name FROM wood_types ORDER BY name ASC;

--16. Select 2 columns in table wood_types + display which have '%ch%' in name column +  sort by name column DESC (in reverse)
SELECT name, scientific_name FROM wood_types WHERE name LIKE '%ch%' ORDER BY name DESC;

--17. Select 3 columns in table wood_types + display which have '%Plywood%' in common_uses column +  sort by scientific_name column ASC
SELECT name, scientific_name, common_uses FROM wood_types WHERE common_uses LIKE '%Plywood%' ORDER BY scientific_name ASC;

--18. Select 3 columns in table wood_types + display which have '%Musical%' in common_uses column +  sort by image_url column DESC (in reverse)
SELECT name, image_url, common_uses FROM wood_types WHERE common_uses LIKE '%Musical%' ORDER BY image_url DESC;

--19. Select 3 columns in table wood_types + display which have sup_id < 3 + sort by name column ASC
SELECT name, common_uses, sup_id  FROM wood_types WHERE sup_id < 3 ORDER BY name ASC;

--20. Select 3 columns in table wood_types + display which have sup_id < 4 + sort by sup_id column ASC
SELECT name, common_uses, sup_id  FROM wood_types WHERE sup_id < 4 ORDER BY sup_id ASC;

--21. Select 3 columns in table wood_types + display which have sup_id >= 17 + sort by common_uses column DESC
SELECT name, common_uses, sup_id  FROM wood_types WHERE sup_id >= 17 ORDER BY common_uses DESC;

--22. Select 2 columns in table wood_suppliers + display which supplier_name have '%eo%' + sort by supplier_id column DESC
SELECT supplier_id, supplier_name FROM wood_suppliers WHERE supplier_name LIKE '%o%' ORDER BY supplier_id DESC;


--23. Select 2 rows in wood_suppliers + give new name
SELECT supplier_id, supplier_name AS "Ім'я" FROM wood_suppliers;

--24. Select 2 rows in wood_suppliers + give new name + set Limit 10
SELECT supplier_id, supplier_name AS "Ім'я" FROM wood_suppliers LIMIT 10;

--25. Select 2 rows in wood_suppliers + give new name + set Limit 10 + set start point
SELECT supplier_id, supplier_name AS "Ім'я" FROM wood_suppliers LIMIT 10 OFFSET 3;

--26. Select 2 rows in wood_suppliers + give new name + set Limit  + set start point
SELECT supplier_id, supplier_name AS "Ім'я" FROM wood_suppliers LIMIT 5 OFFSET 11;


-- 27. Use of GROUP BY on wood_types table
SELECT common_uses, SUM(sup_id) FROM wood_types GROUP BY common_uses;

-- 28. Use of GROUP BY on wood_characteristics table
SELECT hardness, SUM(density) FROM wood_characteristics GROUP BY hardness;

-- 29. Use of GROUP BY on wood_characteristics table + using HAVING as a condition for group value 
SELECT hardness, SUM(density) FROM wood_characteristics 
GROUP BY hardness 
HAVING SUM(density) > 10;

-- 30. Use of GROUP BY on wood_types table + AVG
SELECT common_uses, AVG(sup_id) FROM wood_types GROUP BY common_uses;

-- 31. Use of GROUP BY on wood_characteristics table + AVG
SELECT hardness, AVG(density) FROM wood_characteristics GROUP BY hardness;

-- 32. Use of GROUP BY on wood_characteristics table + MIN value in each group
SELECT hardness, MIN(density) FROM wood_characteristics GROUP BY hardness;

-- 33. Use of GROUP BY on wood_characteristics table + MAX value in each group
SELECT hardness, MAX(density) FROM wood_characteristics GROUP BY hardness;

-- 34. Use of GROUP BY on wood_characteristics table + counts amount of rows in each group
SELECT hardness, COUNT(density) FROM wood_characteristics GROUP BY hardness;

-- 35. Use of GROUP BY on wood_characteristics table + counts deviation (відхилення) in each group
SELECT hardness, STDDEV(density) FROM wood_characteristics GROUP BY hardness;


-- 36. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id
SELECT w.name, s.supplier_name
FROM wood_suppliers AS s
JOIN wood_types w ON s.id=w.sup_id;

-- 37. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id
SELECT w.name, s.supplier_name
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id

-- 38. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + GROUPING WASNT GOOD HERE
SELECT w.name, s.supplier_name
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
GROUP BY s.supplier_name, w.name;

-- 39. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + order by w.name
SELECT w.name, s.supplier_name
FROM wood_suppliers AS s
JOIN wood_types w ON s.id=w.sup_id
ORDER BY w.name;

-- 40. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + WHWER NAME CONDITION + order by w.name + LIMIT
SELECT w.name, s.supplier_name
FROM wood_suppliers AS s
JOIN wood_types w ON s.id=w.sup_id
WHERE w.name LIKE '%e%'
ORDER BY w.name
LIMIT 10;

-- 41. Select 1column in wood_types and wood_char + join ids 
SELECT wc.density, w.common_uses
FROM wood_characteristics AS wc
JOIN wood_types w ON wc.id=w.char_id

-- 42. Select 1column in wood_types and wood_char + join ids + AVG dencity for common uses + ORDER BY avr dencity ASC
SELECT AVG(wc.density), w.common_uses
FROM wood_characteristics AS wc
JOIN wood_types w ON wc.id=w.char_id
GROUP BY w.common_uses
ORDER BY AVG(wc.density) ASC;

-- 43. Select 1column in wood_types and wood_char + join ids + AVG dencity for common uses + ORDER BY avr dencity DESC + LIMIT
SELECT AVG(wc.density), w.common_uses
FROM wood_characteristics AS wc
JOIN wood_types w ON wc.id=w.char_id
GROUP BY w.common_uses
ORDER BY AVG(wc.density) DESC
LIMIT 10;

-- 44. Select 1column in wood_types and wood_char + join ids + MIN dencity for common uses + ORDER BY avr dencity ASC + LIMIT
SELECT MIN(wc.density), w.common_uses
FROM wood_characteristics AS wc
JOIN wood_types w ON wc.id=w.char_id
GROUP BY w.common_uses
ORDER BY MIN(wc.density) ASC
LIMIT 9;

-- 45. Select 1column in wood_types and wood_char + join ids + MAX dencity for common uses + ORDER BY avr dencity DESC + LIMIT
SELECT MAX(wc.density), w.common_uses
FROM wood_characteristics AS wc
JOIN wood_types w ON wc.id=w.char_id
GROUP BY w.common_uses
ORDER BY MAX(wc.density) DESC
LIMIT 9;

-- 46. Select 1column in wood_types and wood_char + join ids + AVG dencity for common uses + ORDER BY avr dencity DESC + LIMIT + offset
SELECT AVG(wc.density), w.common_uses
FROM wood_characteristics AS wc
JOIN wood_types w ON wc.id=w.char_id
GROUP BY w.common_uses
ORDER BY AVG(wc.density) DESC
LIMIT 6 OFFSET 13;

-- 47. Select 1column in wood_types and wood_char + join ids + AVG dencity for common uses + ORDER BY avr dencity DESC + LIMIT + offset
SELECT AVG(wc.density), w.common_uses
FROM wood_characteristics AS wc
JOIN wood_types w ON wc.id=w.char_id
GROUP BY w.common_uses
HAVING AVG(wc.density) > 0.9
ORDER BY AVG(wc.density) DESC;

-- 48. Select 1column in wood_types and wood_char + join ids + AVG dencity for common uses + ORDER BY avr dencity DESC + wood_types + HAVING > 0.9
SELECT AVG(wc.density), w.common_uses
FROM wood_characteristics AS wc
JOIN wood_types w ON wc.id=w.char_id
GROUP BY w.common_uses
HAVING AVG(wc.density) > 0.9
ORDER BY AVG(wc.density) DESC;

-- 49. Select 1column in wood_types and wood_char + join ids + AVG dencity for common uses + ORDER BY avr dencity DESC + wood_types + HAVING < 0.7
SELECT AVG(wc.density), w.common_uses
FROM wood_characteristics AS wc
JOIN wood_types w ON wc.id=w.char_id
GROUP BY w.common_uses
HAVING AVG(wc.density) < 0.7
ORDER BY AVG(wc.density) DESC;

-- 50. Select 1column in wood_types and wood_char + join ids + AVG dencity for common uses + ORDER BY avr dencity DESC + wood_types + HAVING AVG < 0.7 + LIMIT
SELECT AVG(wc.density), w.common_uses
FROM wood_characteristics AS wc
JOIN wood_types w ON wc.id=w.char_id
GROUP BY w.common_uses
HAVING AVG(wc.density) < 0.7
ORDER BY AVG(wc.density) DESC
LIMIT 5;

-- 51. Select 1column in wood_types and wood_char + join ids + MAX dencity for common uses + ORDER BY avr dencity DESC + wood_types + HAVING MAX < 0.7
SELECT MAX(wc.density), w.common_uses
FROM wood_characteristics AS wc
JOIN wood_types w ON wc.id=w.char_id
GROUP BY w.common_uses
HAVING MAX(wc.density) < 0.7
ORDER BY MAX(wc.density) DESC;

-- 52. Select 1column in wood_types and wood_char + join ids + MAX dencity for common uses + ORDER BY avr dencity DESC + wood_types + HAVING MAX > 0.95
SELECT MAX(wc.density), w.common_uses
FROM wood_characteristics AS wc
JOIN wood_types w ON wc.id=w.char_id
GROUP BY w.common_uses
HAVING MAX(wc.density) > 0.95
ORDER BY MAX(wc.density) DESC;

-- 53. Select 1column in wood_types and wood_char + join ids + MAX dencity for common uses + ORDER BY avr dencity DESC + wood_types + HAVING MAX > 0.8 + LIMIT 8 + OFFSET 8
SELECT MAX(wc.density), w.common_uses
FROM wood_characteristics AS wc
JOIN wood_types w ON wc.id=w.char_id
GROUP BY w.common_uses
HAVING MAX(wc.density) > 0.8
ORDER BY MAX(wc.density) DESC
LIMIT 8 OFFSET 8;

-- 54. Select 1column in wood_suppliers and wood_char + join ids 
SELECT ws.contact_info, wc.color
FROM wood_characteristics AS wc
JOIN wood_suppliers ws ON wc.id=ws.id;

-- 55. Select 1column in wood_suppliers and wood_char + join ids + the same but different syntax + order by color asc
SELECT ws.contact_info, wc.color
FROM wood_characteristics AS wc
JOIN wood_suppliers ws USING(id)
ORDER BY color ASC;

-- 56. Select 1column in wood_suppliers and wood_char + join ids + the same but different syntax + order by color desc
SELECT ws.contact_info, wc.color
FROM wood_characteristics AS wc
JOIN wood_suppliers ws USING(id)
ORDER BY color DESC;

-- 57. Select 1column in wood_suppliers and wood_char + join ids + the same but different syntax + order by color asc + limit
SELECT ws.contact_info, wc.color
FROM wood_characteristics AS wc
JOIN wood_suppliers ws USING(id)
ORDER BY color ASC
LIMIT 10;

-- 58. Select 1column in wood_suppliers and wood_char + join ids + the same but different syntax + order by hardness asc
SELECT ws.contact_info, wc.color, wc.hardness
FROM wood_characteristics AS wc
JOIN wood_suppliers ws USING(id)
ORDER BY hardness ASC;

-- 59. Select 1column in wood_suppliers and wood_char + join ids + the same but different syntax + order by hardness asc
SELECT COUNT(id), hardness
FROM wood_characteristics
GROUP BY hardness
ORDER BY COUNT(hardness) ASC;

-- 60. Count amount by groups of hardness
SELECT COUNT(id), hardness
FROM wood_characteristics
GROUP BY hardness

-- 61. COUNT amount by groups of hardness + order by count asc
SELECT COUNT(id), hardness
FROM wood_characteristics
GROUP BY hardness
ORDER BY COUNT(hardness) ASC;

-- 62. COUNT amount by groups of hardness + order by count asc
SELECT COUNT(id), hardness
FROM wood_characteristics
GROUP BY hardness
ORDER BY COUNT(hardness) DESC;

-- 63. COUNT amount by groups of hardness + order by count desc + having (condition)
SELECT COUNT(id), hardness
FROM wood_characteristics
GROUP BY hardness
HAVING COUNT(id) > 16
ORDER BY COUNT(hardness) DESC;

-- 64. COUNT amount by groups of hardness + order by count desc + having (condition2)
SELECT COUNT(id), hardness
FROM wood_characteristics
GROUP BY hardness
HAVING COUNT(id) < 17
ORDER BY COUNT(hardness) DESC;

-- 65. COUNT amount by groups of hardness + order by count desc + having (condition3)
SELECT COUNT(id), hardness
FROM wood_characteristics
GROUP BY hardness
HAVING COUNT(id) < 20
ORDER BY COUNT(hardness) DESC;

-- 66. COUNT amount by groups of hardness + order by count desc + having (condition3)
SELECT COUNT(id), hardness
FROM wood_characteristics
GROUP BY hardness
HAVING COUNT(id) <= 20
ORDER BY COUNT(hardness) ASC;


-- 67. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id
SELECT w.name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id;

-- 68. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id
SELECT w.name, s.supplier_id, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id;

-- 69. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id
SELECT w.name, s.supplier_id, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id;

-- 70. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id
SELECT w.name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id;

-- 71. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + order by supplier_name asc
SELECT w.name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
ORDER BY s.supplier_name ASC;

-- 72. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + order by supplier_name desc + limit
SELECT w.name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
ORDER BY s.supplier_name DESC
LIMIT 7;

-- 73. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + order by name asc
SELECT w.name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
ORDER BY w.name ASC;

-- 74. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + order by name desc
SELECT w.name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
ORDER BY w.name DESC;

-- 75. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + order by name desc + LIMIT + OFFSET
SELECT w.name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
ORDER BY w.name DESC
LIMIT 5 OFFSET 10;

-- 76. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + order by name asc + LIMIT + OFFSET
SELECT w.name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
ORDER BY w.name ASC
LIMIT 8 OFFSET 12;

-- 77. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %A%
SELECT w.name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.name LIKE '%A%';

-- 78. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %ca%%
SELECT w.name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.name LIKE '%ca%';

-- 79. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %B%
SELECT w.name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.name LIKE '%B%';

-- 80. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where B%
SELECT w.name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.name LIKE 'B%';

-- 81. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %C%
SELECT w.name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.name LIKE '%C%';

-- 82. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where C%
SELECT w.name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.name LIKE 'C%';

-- 83. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %Ch%
SELECT w.name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.name LIKE '%Ch%';

-- 84. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %E%
SELECT w.name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.name LIKE '%E%';

-- 85. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %E% + order
SELECT w.name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.name LIKE '%E%'
ORDER BY w.name DESC;

-- 86. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %F% + order
SELECT w.name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.name LIKE '%F%'
ORDER BY w.name DESC;

-- 87. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %F% + order
SELECT w.name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.name LIKE '%ro%'
ORDER BY w.name DESC;

-- 88. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %r% + order + scientific_name
SELECT w.scientific_name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.name LIKE '%r%'
ORDER BY w.scientific_name DESC;

-- 89. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %ro% + order + scientific_name + desc
SELECT w.scientific_name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.scientific_name LIKE '%ro%'
ORDER BY w.scientific_name DESC;

-- 90. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %ro% + order + scientific_name + asc
SELECT w.scientific_name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.scientific_name LIKE '%ro%'
ORDER BY w.scientific_name ASC;

-- 91. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %ro% + order + scientific_name + asc
SELECT w.scientific_name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.scientific_name LIKE 'A%'
ORDER BY w.scientific_name ASC;

-- 92. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where A% + order + scientific_name + asc + limit
SELECT w.scientific_name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.scientific_name LIKE 'A%'
ORDER BY w.scientific_name ASC
LIMIT 5;

-- 93. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where C% + order + scientific_name + asc
SELECT w.scientific_name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.scientific_name LIKE 'C%'
ORDER BY w.scientific_name ASC;

-- 94. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %C% + order + scientific_name + asc
SELECT w.scientific_name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.scientific_name LIKE '%C%'
ORDER BY w.scientific_name ASC;

-- 95. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %F% + order + scientific_name + asc
SELECT w.scientific_name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.scientific_name LIKE '%F%'
ORDER BY w.scientific_name ASC;

-- 96. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %S% + order + scientific_name + asc
SELECT w.scientific_name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.scientific_name LIKE '%S%'
ORDER BY w.scientific_name ASC;

-- 96. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %S% + order + scientific_name + desc
SELECT w.scientific_name, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.scientific_name LIKE '%S%'
ORDER BY w.scientific_name DESC;

-- 97. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %S% + order + scientific_name + desc
SELECT w.scientific_name, w.name, s.supplier_name
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.scientific_name LIKE '%S%'
ORDER BY w.scientific_name DESC;

-- 98. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %S% + order + scientific_name + asc
SELECT w.scientific_name, w.name, w.common_uses, s.supplier_name
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.scientific_name LIKE '%S%'
ORDER BY w.scientific_name ASC;

-- 99. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %J% + order + scientific_name + asc
SELECT w.scientific_name, w.name, w.common_uses, s.supplier_name
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.scientific_name LIKE '%J%'
ORDER BY w.scientific_name ASC;

-- 100. Select 1column in wood_types and wood_suppliers each + join wood_suppliers id and wood_types sup_id + where %S% + order + scientific_name + desc
SELECT w.scientific_name, w.name, w.common_uses, s.supplier_name, s.contact_info
FROM wood_suppliers AS s
JOIN wood_types AS w ON s.id=w.sup_id
WHERE w.scientific_name LIKE '%J%'
ORDER BY w.scientific_name DESC;

-- Висновок: у ході лабораторної роботи було детально опрацьовано всі аргументи SELECT 
-- в різних комбінаціях та варіаціях. Були задіяні три таблиці, що були заповнені певними 
-- даними, для роботи з SELECT.