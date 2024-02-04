
\dt   -- to see existing tables
-- creating table wood_types
CREATE TABLE "wood_types" (
  "wood_id" INT PRIMARY KEY,
  "name" VARCHAR(100) NOT NULL,
  "scientific_name" VARCHAR(100),
  "common_uses" TEXT,
  "image_url" VARCHAR(255)
);

-- creating table wood_characteristics
CREATE TABLE "wood_characteristics" (
  "wood_id" INT PRIMARY KEY,
  "density" DECIMAL(10,2),
  "hardness" VARCHAR(50),
  "color" VARCHAR(50)
);
\dt
\d wood_types         -- to see contents of table
\d wood_characteristics

ALTER TABLE "wood_types" ADD FOREIGN KEY ("wood_id") REFERENCES "wood_characteristics" ("wood_id");

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

SELECT * FROM wood_types;
SELECT * FROM wood_characteristics;


