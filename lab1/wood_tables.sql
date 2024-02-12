\dt   -- to see existing tables
CREATE TABLE "wood_suppliers" (
  "id" SERIAL PRIMARY KEY,
  "supplier_name" VARCHAR(100),
  "contact_info" TEXT
);

-- creating table hardness_char
CREATE TABLE "hardness_char"(
  "id" SERIAL PRIMARY KEY,
  "hadness" VARCHAR(50)
);

-- creating table wood_characteristics
CREATE TABLE "wood_characteristics" (
  "id" SERIAL PRIMARY KEY,
  "density" DECIMAL(10,2),
  "hardness_id" INT REFERENCE "hardness_char" ("id"),              -- one-to-many
  "color" VARCHAR(50)
);

-- creating table common_uses
CREATE TABLE "common_uses"(
  "id" SERIAL PRIMARY KEY,
  "common_uses" TEXT
);

-- creating table wood_types
CREATE TABLE "wood_types" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(100) NOT NULL,
  "scientific_name" VARCHAR(100),
  "image_url" VARCHAR(255),
  "uses_id" INT REFERENCES "common_uses" ("id"),                   -- one-to-many
  "char_id" INT UNIQUE REFERENCES "wood_characteristics" ("id"),   -- one-to-one
);

-- creating table woodtype_supplier
CREATE TABLE "price"(  -- for many-to-many relationship
  "id" SERIAL PRIMARY KEY,
  "woodtype_id" INT REFERENCES "wood_types" ("id"),                
  "supplier_id" INT REFERENCES "wood_suppliers" ("id"),
  "supplier_price" DECIMAL(10,2),
  "sup_date" DATE
);

\dt
\d wood_types         -- to see contents of table
\d wood_characteristics
\d wood_suppliers
\d hardness_char
\d common_uses

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


