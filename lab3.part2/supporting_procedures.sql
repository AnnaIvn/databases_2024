CREATE OR REPLACE PROCEDURE UPDATE_PRICE_BY_ID(
    v_id INT,
    v_supplier_id INT,
    v_supplier_price DECIMAL(10,2),
    v_sup_date DATE,
    v_woodtype_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE price
    SET 
        supplier_id = v_supplier_id,
        supplier_price = v_supplier_price,
        sup_date = v_sup_date,
        woodtype_id = v_woodtype_id
    WHERE id = v_id;
END;
$$;

-- delete price
CREATE OR REPLACE PROCEDURE DELETE_PRICE_BY_ID(
    v_price_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM price
    WHERE id = v_price_id;
END;
$$;