\dt   -- to see existing tables
CREATE TABLE wood_suppliers (
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
  "color" VARCHAR(50),
  "char_id" INT REFERENCES "wood_suppliers" ("id"), 
  UNIQUE("char_id")
);

-- creating table wood_types
CREATE TABLE "wood_types" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(100) NOT NULL,
  "scientific_name" VARCHAR(100),
  "common_uses" TEXT,
  "image_url" VARCHAR(255),
  "type_id" INT REFERENCES "wood_characteristics" ("id"), 
  UNIQUE("type_id")
);
\dt
\d wood_types         -- to see contents of table
\d wood_characteristics
\d wood_suppliers

-- ALTER TABLE "wood_types" ADD FOREIGN KEY ("wood_id") REFERENCES "wood_characteristics" ("wood_id");

-- insert data into wood_types table
INSERT INTO "wood_types" ("wood_id", "name", "scientific_name", "common_uses", "image_url")
VALUES (1, 'Oak', 'Quercus', 'Furniture, Flooring, Cabinetry', 'https://example.com/oak.jpg'),
       (2, 'Maple', 'Acer', 'Furniture, Flooring, Musical Instruments', 'https://example.com/maple.jpg'),
       (3, 'Mahogany', 'Swietenia', 'Furniture, Boatbuilding, Musical Instruments', 'https://example.com/mahogany.jpg');

-- insert data into wood_characteristics table
INSERT INTO "wood_characteristics" ("wood_id", "density", "hardness", "color")
VALUES (4, 0.75, 'Hard', 'Brown'),
       (5, 0.6, 'Medium', 'Light Brown'),
       (6, 0.55, 'Hard', 'Reddish Brown');

INSERT INTO wood_suppliers ("supplier_id", "supplier_name", "contact_info")
VALUES
  (1, 'Wood Supplier A', 'Contact info for Wood Supplier A'),
  (2, 'Wood Supplier B', 'Contact info for Wood Supplier B'),
  (3, 'Wood Supplier C', 'Contact info for Wood Supplier C');


SELECT * FROM wood_types;
SELECT * FROM wood_characteristics;
SELECT * FROM wood_suppliers;


