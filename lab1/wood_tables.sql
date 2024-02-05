\dt   -- to see existing tables
CREATE TABLE "wood_suppliers" (
  "id" SERIAL PRIMARY KEY,
  "supplier_id" INT,
  "supplier_name" VARCHAR(100),
  "contact_info" TEXT
);

-- creating table wood_characteristics
CREATE TABLE "wood_characteristics" (
  "id" SERIAL PRIMARY KEY,
  "density" DECIMAL(10,2),
  "hardness" VARCHAR(50),
  "color" VARCHAR(50)
);

-- "char_id" INT REFERENCES "wood_suppliers" ("id"), 
  -- UNIQUE("char_id")

-- creating table wood_types
CREATE TABLE "wood_types" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(100) NOT NULL,
  "scientific_name" VARCHAR(100),
  "common_uses" TEXT,
  "image_url" VARCHAR(255),
  "char_id" INT UNIQUE REFERENCES "wood_characteristics" ("id"),   -- one-to-one
  "sup_id" INT REFERENCES "wood_suppliers" ("id")                  -- one-to-many
);
\dt
\d wood_types         -- to see contents of table
\d wood_characteristics
\d wood_suppliers

-- ALTER TABLE "wood_types" ADD FOREIGN KEY ("wood_id") REFERENCES "wood_characteristics" ("wood_id");

-- insert data into wood_types table
INSERT INTO wood_types ("name", "scientific_name", "common_uses", "image_url", "char_id", "sup_id")
VALUES
  ('Oak', 'Quercus', 'Furniture, Flooring', 'oak.jpg', 1, 1),
  ('Pine', 'Pinus', 'Construction, Furniture', 'pine.jpg', 2, 1),
  ('Mahogany', 'Swietenia', 'Furniture, Musical Instruments', 'mahogany.jpg', 3, 3);

-- insert data into wood_characteristics table
INSERT INTO "wood_characteristics" ("density", "hardness", "color")
VALUES
  (0.75, 'Hard', 'Brown'),
  (0.6, 'Medium', 'Light Brown'),
  (0.55, 'Hard', 'Reddish Brown');


INSERT INTO "wood_suppliers" ("supplier_id", "supplier_name", "contact_info")
VALUES
  (1, 'Wood Supplier Adam', 'Contact info for Wood Supplier Adam'),
  (2, 'Wood Supplier Bob', 'Contact info for Wood Supplier Bob'),
  (3, 'Wood Supplier Casy', 'Contact info for Wood Supplier Casy');


SELECT * FROM wood_types;
SELECT * FROM wood_characteristics;
SELECT * FROM wood_suppliers;

SELECT w.name, s.supplier_name
FROM wood_suppliers AS s
JOIN wood_types w ON s.id=w.sup_id;


