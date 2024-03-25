-- Основна різниця між процедурами та функціями в PostgreSQL полягає у їх призначенні та способах 
-- використання. Функції зосереджені на обчисленнях та поверненні даних і можуть використовуватися
-- всередині SQL-запитів, тоді як процедури зосереджені на виконанні дій, що не обов'язково 
-- пов'язані з поверненням значень, і забезпечують гнучкіші можливості для управління транзакціями.


-- FUNCTIONS
-- returns summary salary for chosen supplier
CREATE OR REPLACE FUNCTION calculate_total_price_of_supplier(supp_name VARCHAR) 
RETURNS DECIMAL(10,2)
LANGUAGE plpgsql
AS $$  -- marks the beginning of the function body
DECLARE
    total_price DECIMAL(10,2);
BEGIN
    SELECT SUM(pr.supplier_price) INTO total_price
    FROM price AS pr
    JOIN wood_suppliers as ws ON ws.id = pr.supplier_id
    WHERE ws.supplier_name=supp_name;
    RETURN total_price;
END;
$$;

SELECT * FROM wood_suppliers;
SELECT calculate_total_price_of_supplier('Kevin Penkin');
SELECT calculate_total_price_of_supplier('Tom Leafwood');
SELECT calculate_total_price_of_supplier('Casy Forest');
SELECT calculate_total_price_of_supplier('Peter Hemlock');


-- returns summary salary for chosen supplier for date period
CREATE OR REPLACE FUNCTION calculate_total_price_of_supplier_for_date1(
    supp_name VARCHAR,
    start_date DATE,
    end_date DATE
) 
RETURNS DECIMAL(10,2)
LANGUAGE plpgsql
AS $$  
DECLARE
    total_price DECIMAL(10,2);
BEGIN
    SELECT COALESCE(SUM(pr.supplier_price), 0) INTO total_price
    FROM price AS pr
    JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
    WHERE ws.supplier_name = supp_name
    AND pr.sup_date BETWEEN start_date AND end_date;

    RETURN total_price;
END;
$$;

SELECT calculate_total_price_of_supplier_for_date1('Tom Leafwood', '2023-11-01', '2024-02-02');
SELECT calculate_total_price_of_supplier_for_date1('Tom Leafwood', '2023-11-01', '2024-01-25');
SELECT calculate_total_price_of_supplier_for_date1('Tom Leafwood', '2023-12-01', '2024-01-21');


-- shows all prices of a supplier, connects three tables
CREATE OR REPLACE FUNCTION get_supplier_details(v_supplier_name VARCHAR)
RETURNS TABLE (
    supplier_name VARCHAR,
    supplier_price DECIMAL(10, 2),
    supplier_date DATE,
    name VARCHAR,
    scientific_name VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY 
    SELECT ws.supplier_name, 
           pr.supplier_price, 
           pr.sup_date, 
           wt.name, 
           wt.scientific_name
    FROM wood_suppliers ws
    JOIN price pr ON ws.id = pr.supplier_id
    JOIN wood_types wt ON pr.woodtype_id = wt.id
    WHERE ws.supplier_name = v_supplier_name;
END;
$$;

SELECT * FROM get_supplier_details('Kevin Penkin');


-- -- returns summary salary for chosen supplier for date period
-- CREATE OR REPLACE FUNCTION count_suppliers_rate2(min_sup_rate INT) 
-- RETURNS VARCHAR
-- LANGUAGE plpgsql
-- AS $$  
-- DECLARE
--     -- total_price DECIMAL(10,2);
-- BEGIN
--     SELECT ws.supplier_name, COUNT(pr.supplier_id)
--     FROM price AS pr
--     JOIN wood_suppliers AS ws ON ws.id = pr.supplier_id
--     GROUP BY ws.supplier_name
--     HAVING COUNT(pr.supplier_id) >= min_sup_rate
--     ORDER BY COUNT(pr.supplier_id) DESC;

--     RETURN ws.supplier_name;
-- END;
-- $$;

-- SELECT count_suppliers_rate2(6);











-- PROCEDURES
-- -- updates price of spesific supplier (plus or minus)
-- older version
-- CREATE OR REPLACE PROCEDURE update_supplier_prices(
--     s_id INT,
--     increase_percentage DECIMAL
-- )
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     UPDATE price      -- table to update
--     SET supplier_price = supplier_price + (supplier_price * (increase_percentage / 100))     -- column of the table to set
--     WHERE s_id = supplier_id;
-- END;
-- $$;


-- -- increase/decrease price of spesific supplier, you must provide a name (plus or minus)
CREATE OR REPLACE PROCEDURE update_supplier_prices4(
    supp_name VARCHAR,
    increase_percentage DECIMAL
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE price
    SET supplier_price = supplier_price + (supplier_price * (increase_percentage / 100))
    FROM wood_suppliers AS ws 
    WHERE supplier_id = ws.id
    AND ws.supplier_name = supp_name;
END;
$$;

CALL update_supplier_prices4('Kevin Penkin', -1);
CALL update_supplier_prices4('Kevin Penkin', 5);
-- CALL update_supplier_prices(10, -1);
SELECT calculate_total_price_of_supplier('Kevin Penkin');


-- add price
CREATE OR REPLACE PROCEDURE add_to_price_table(
    v_supplier_id INT,
    v_supplier_price DECIMAL(10,2),
    v_sup_date DATE,
    v_woodtype_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO price(woodtype_id, supplier_id, supplier_price, sup_date)
    VALUES (v_woodtype_id, v_supplier_id, v_supplier_price, v_sup_date);
END;
$$;

CALL add_to_price_table(10, 400, '2024-03-08' , 9);
CALL add_to_price_table(10, 888, '2024-03-07' , 11);
SELECT * FROM price;


-- Create the trigger that gives today date
CREATE OR REPLACE FUNCTION trigger_add_to_price_table()
RETURNS TRIGGER AS $$
BEGIN
    -- Call the procedure with today's date
    PERFORM add_to_price_table(NEW.supplier_id, NEW.supplier_price, CURRENT_DATE, NEW.woodtype_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Attach the trigger to the price table
CREATE TRIGGER add_to_price_trigger
AFTER INSERT ON price
FOR EACH ROW
EXECUTE FUNCTION trigger_add_to_price_table();


-- delete price
CREATE OR REPLACE PROCEDURE delete_from_price_table(
    v_price_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM price
    WHERE id = v_price_id;
END;
$$;

CALL delete_from_price_table(322);


-- update price
CREATE OR REPLACE PROCEDURE update_price_table_by_id(
    v_price_id INT,
    v_supplier_id INT,
    v_supplier_price DECIMAL(10,2),
    v_sup_date DATE,
    v_woodtype_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE price
    SET woodtype_id = v_woodtype_id,
        supplier_id = v_supplier_id,
        supplier_price = v_supplier_price,
        sup_date = v_sup_date
    WHERE id = v_price_id;
END;
$$;

CALL update_price_table_by_id(316, 10, 400, '2024-03-09' , 15); -- to check
SELECT * FROM price;


-- TRIGGERS
-- trigger that raises an error when an attempt is made to insert a price with a negative value
CREATE OR REPLACE FUNCTION check_price_value()   -- trigger function
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.supplier_price < 0 THEN
        RAISE EXCEPTION 'Price cannot be negative';
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER price_insert_trigger    -- trigger
BEFORE INSERT OR UPDATE ON price
FOR EACH ROW
EXECUTE FUNCTION check_price_value();

CALL add_to_price_table(10, -400, '2024-03-08' , 9); -- to check


-- -- raises ann error for incorrect data format
-- CREATE OR REPLACE FUNCTION check_date_format()    -- trigger function
-- RETURNS TRIGGER       -- cause we are writing function for a trigger
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     -- ~ regular expression match operator, checks if sides of expresion match
--     -- ^ anchor that asserts the start of the string
--     -- \d{4} matches exactly four digits (0-9)
--     -- $ anchor that asserts the end of the string
--     IF NEW.sup_date IS NOT NULL AND NOT NEW.sup_date ~ '^\d{4}-\d{2}-\d{2}$' THEN   -- check date format
--         RAISE EXCEPTION 'Incorrect date format. Please use YYYY-MM-DD format';
--     END IF;

--     RETURN NEW;
-- END;
-- $$;

-- DROP TRIGGER date_insert_trigger ON price;
-- CREATE TRIGGER date_insert_trigger    -- trigger itself
-- BEFORE INSERT OR UPDATE ON price
-- FOR EACH ROW
-- EXECUTE FUNCTION check_date_format();

-- CALL add_to_price_table(10, 400, '2024-03-08' , 15); -- to check


-- checks if price is reasonable
CREATE OR REPLACE FUNCTION check_supplier_price_range()    -- trigger function
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    -- Check if the supplier_price is within the range of 0 to 1000
    IF NEW.supplier_price < 0 OR NEW.supplier_price > 10000 THEN
        RAISE EXCEPTION 'Supplier price must be between 0 and 10000';
    END IF;

    RETURN NEW;
END;
$$;

DROP TRIGGER price_check_trigger ON price;
CREATE TRIGGER price_check_trigger         -- trigger itself
BEFORE INSERT OR UPDATE ON price
FOR EACH ROW
EXECUTE FUNCTION check_supplier_price_range();

CALL add_to_price_table(10, 40000, '2024-03-08' , 9); -- to check


-- checks if the date was already, so that date wasn't in the future time
CREATE OR REPLACE FUNCTION check_sup_date()        -- trigger function
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    -- Check if the sup_date is in the future
    IF NEW.sup_date > CURRENT_DATE THEN
        RAISE EXCEPTION 'Supplied date cannot be in the future. Provide a proper date.';
    END IF;

    RETURN NEW;
END;
$$;

DROP TRIGGER sup_date_check_trigger ON price;
CREATE TRIGGER sup_date_check_trigger     -- trigger itself
BEFORE INSERT OR UPDATE ON price
FOR EACH ROW
EXECUTE FUNCTION check_sup_date();

CALL add_to_price_table(10, 400, '2024-03-13' , 9); -- to check


-- INDEXES
-- improve the speed of data retrieval 
-- CREATE INDEX index_name ON table_name (column1, column2, ...);

-- example of creating some indexes
CREATE INDEX idx_supplier_name ON wood_suppliers (supplier_name);
SELECT * FROM wood_suppliers ORDER BY supplier_name; 

CREATE INDEX idx_supplier_date ON price (supplier_id, sup_date);
SELECT * FROM price
WHERE supplier_id > 10
ORDER BY sup_date;


CREATE INDEX inx_sup_date ON price (sup_date);   -- we do not need to explicitly use indexes, it is done automaticaly
SELECT * FROM price ORDER BY sup_date;          -- now, it should be faster in execution


-- Висновок: у ході виконання цієї лабораторної  роботи, я навчилася створювати:
-- функції, процедури, тригери, функції для тригерів та індекси, та працювати з ними. 