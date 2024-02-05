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
INSERT INTO "wood_types" ("name", "scientific_name", "common_uses", "image_url", "char_id", "sup_id")
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
  (1, 'Supplier Adam', 'Contact info for Adam'),
  (2, 'Supplier Bob', 'Contact info for Bob'),
  (3, 'Supplier Casy', 'Contact info for Casy');


SELECT * FROM wood_types;
SELECT * FROM wood_characteristics;
SELECT * FROM wood_suppliers;

SELECT w.name, s.supplier_name
FROM wood_suppliers AS s
JOIN wood_types w ON s.id=w.sup_id;

-- DELETE FROM wood_suppliers;
-- DELETE FROM wood_characteristics;
-- DELETE FROM wood_types;


INSERT INTO "wood_suppliers" ("supplier_id", "supplier_name", "contact_info")
VALUES
  (1, 'Supplier Adam', 'Contact info for Adam'),
  (2, 'Supplier Bob', 'Contact info for Bob'),
  (3, 'Supplier Casy', 'Contact info for Casy'),
  (4, 'Supplier Eve', 'Contact info for Eve'),
  (5, 'Supplier Frank', 'Contact info for Frank'),
  (6, 'Supplier George', 'Contact info for George'),
  (7, 'Supplier Henry', 'Contact info for Henry'),
  (8, 'Supplier Ivan', 'Contact info for Ivan'),
  (9, 'Supplier Jack', 'Contact info for Jack'),
  (10, 'Supplier Kevin', 'Contact info for Kevin'),
  (11, 'Supplier Lily', 'Contact info for Lily'),
  (12, 'Supplier Mike', 'Contact info for Mike'),
  (13, 'Supplier Nancy', 'Contact info for Nancy'),
  (14, 'Supplier Oscar', 'Contact info for Oscar'),
  (15, 'Supplier Peter', 'Contact info for Peter'),
  (16, 'Supplier Queen', 'Contact info for Queen'),
  (17, 'Supplier Robert', 'Contact info for Robert'),
  (18, 'Supplier Sam', 'Contact info for Sam'),
  (19, 'Supplier Tom', 'Contact info for Tom'),
  (20, 'Supplier Ursula', 'Contact info for Ursula');




INSERT INTO wood_characteristics ("density", "hardness", "color")
VALUES
  (0.75, 'Medium', 'Light Brown'),
  (0.65, 'Soft', 'Yellow'),
  (0.7, 'Medium', 'Dark Brown'),
  (0.8, 'Hard', 'Tan'),
  (0.68, 'Medium', 'Golden Brown'),
  (0.78, 'Hard', 'Chestnut'),
  (0.72, 'Medium', 'Honey'),
  (0.76, 'Hard', 'Amber'),
  (0.82, 'Hard', 'Walnut'),
  (0.74, 'Medium', 'Hazel'),
  (0.79, 'Hard', 'Caramel'),
  (0.71, 'Medium', 'Copper'),
  (0.69, 'Soft', 'Blonde'),
  (0.77, 'Hard', 'Sepia'),
  (0.73, 'Medium', 'Wheat'),
  (0.85, 'Hard', 'Mocha'),
  (0.81, 'Hard', 'Cocoa'),
  (0.83, 'Medium', 'Coffee'),
  (0.84, 'Hard', 'Mahogany'),
  (0.86, 'Medium', 'Cinnamon'),
  (0.87, 'Hard', 'Chocolate'),
  (0.88, 'Hard', 'Chestnut'),
  (0.89, 'Hard', 'Hickory'),
  (0.9, 'Medium', 'Auburn'),
  (0.91, 'Hard', 'Russet'),
  (0.92, 'Medium', 'Ginger'),
  (0.93, 'Hard', 'Bronze'),
  (0.94, 'Medium', 'Brass'),
  (0.95, 'Hard', 'Copper'),
  (0.96, 'Medium', 'Gold'),
  (0.97, 'Medium', 'Platinum'),
  (0.98, 'Hard', 'Silver'),
  (0.99, 'Hard', 'Steel'),
  (0.67, 'Medium', 'Ivory'),
  (0.66, 'Soft', 'Cream'),
  (0.64, 'Soft', 'Beige'),
  (0.63, 'Hard', 'Taupe'),
  (0.62, 'Soft', 'Sand'),
  (0.61, 'Soft', 'Linen'),
  (0.6, 'Medium', 'Ecru'),
  (0.59, 'Soft', 'Oatmeal'),
  (0.58, 'Hard', 'Khaki'),
  (0.57, 'Soft', 'Tan'),
  (0.56, 'Soft', 'Buff'),
  (0.55, 'Soft', 'Caramel'),
  (0.54, 'Medium', 'Mocha'),
  (0.53, 'Soft', 'Chestnut'),
  (0.52, 'Hard', 'Cinnamon'),
  (0.51, 'Soft', 'Coffee'),
  (0.5, 'Soft', 'Mahogany');





INSERT INTO wood_types ("name", "scientific_name", "common_uses", "image_url", "char_id", "sup_id")
VALUES
  ('Oak', 'Quercus', 'Furniture, Flooring', 'oak.jpg', 1, 1),
  ('Pine', 'Pinus', 'Construction, Furniture', 'pine.jpg', 2, 1),
  ('Mahogany', 'Swietenia', 'Furniture, Musical Instruments', 'mahogany.jpg', 3, 3),
  ('Maple', 'Acer', 'Furniture, Flooring', 'maple.jpg', 4, 2),
  ('Walnut', 'Juglans', 'Furniture, Cabinetry', 'walnut.jpg', 5, 3),
  ('Cherry', 'Prunus', 'Furniture, Cabinetry', 'cherry.jpg', 6, 4),
  ('Birch', 'Betula', 'Furniture, Plywood', 'birch.jpg', 7, 6),
  ('Cedar', 'Cedrus', 'Furniture, Fencing', 'cedar.jpg', 8, 6),
  ('Ash', 'Fraxinus', 'Furniture, Tool Handles', 'ash.jpg', 9, 7),
  ('Poplar', 'Populus', 'Furniture, Plywood', 'poplar.jpg', 10, 5),
  ('Rosewood', 'Dalbergia', 'Furniture, Musical Instruments', 'rosewood.jpg', 11, 8),
  ('Butternut', 'Juglans', 'Furniture, Carving', 'butternut.jpg', 12, 8),
  ('Sycamore', 'Acer', 'Furniture, Flooring', 'sycamore.jpg', 13, 11),
  ('Spruce', 'Picea', 'Construction, Musical Instruments', 'spruce.jpg', 14, 8),
  ('Blue Spruce', 'Picea pungens', 'Construction, Paper', 'fir.jpg', 15, 4),
  ('Fraser Fir', 'Abies fraseri', 'Model Making, Packaging', 'balsa.jpg', 16, 14),
  ('Pale Moon Ebony', 'Diospyros malabarica', 'Musical Instruments, Turning', 'ebony.jpg', 17, 15),
  ('Sandalwood', 'Santalum', 'Furniture, Incense', 'sandalwood.jpg', 18, 6),
  ('Larch', 'Larix', 'Construction, Flooring', 'larch.jpg', 19, 20),
  ('Hickory', 'Carya', 'Tool Handles, Flooring', 'hickory.jpg', 20, 6),
  ('Cypress', 'Cupressus', 'Construction, Boat Building', 'cypress.jpg', 21, 10),
  ('Redwood', 'Sequoia', 'Construction, Outdoor Furniture', 'redwood.jpg', 22, 20),
  ('Beech', 'Fagus', 'Furniture, Flooring', 'beech.jpg', 23, 1),
  ('Yew', 'Taxus', 'Archery Bows, Furniture', 'yew.jpg', 24, 8),
  ('Cork', 'Quercus', 'Flooring, Insulation', 'cork.jpg', 25, 3),
  ('Alder', 'Alnus', 'Furniture, Cabinetry', 'alder.jpg', 26, 13),
  ('Mango', 'Mangifera', 'Furniture, Flooring', 'mango.jpg', 27, 5),
  ('Acacia', 'Acacia', 'Furniture, Flooring', 'acacia.jpg', 28, 12),
  ('Lignum', 'Gmelina', 'Construction, Tool Handles', 'lignum.jpg', 29, 7),
  ('Padauk', 'Pterocarpus', 'Furniture, Turning', 'padauk.jpg', 30, 8),
  ('Tulipwood', 'Liriodendron', 'Furniture, Turning', 'tulipwood.jpg', 31, 9),
  ('Sapele', 'Entandrophragma', 'Furniture, Flooring', 'sapele.jpg', 32, 1),
  ('Cocobolo', 'Dalbergia', 'Guitar Making, Turning', 'cocobolo.jpg', 33, 11),
  ('Zebrawood', 'Microberlinia', 'Furniture, Flooring', 'zebrawood.jpg', 34, 8),
  ('Iroko', 'Milicia', 'Outdoor Furniture, Boat Building', 'iroko.jpg', 35, 13),
  ('Ebony', 'Diospyros', 'Musical Instruments, Turning', 'ebony.jpg', 36, 1),
  ('Teak', 'Tectona', 'Furniture, Boat Building', 'teak.jpg', 37, 15),
  ('Austrian Pine', 'Pinus nigra', 'Construction, Furniture', 'pine.jpg', 38, 13),
  ('Bigleaf Mahogany', 'Swietenia macrophylla', 'Furniture, Musical Instruments', 'mahogany.jpg', 39, 17),
  ('White Oak', 'Quercus alba', 'Furniture, Flooring', 'oak.jpg', 40, 13),
  ('Fir', 'Abies', 'Construction, Paper', 'fir.jpg', 41, 19),
  ('Balsa', 'Ochroma', 'Model Making, Packaging', 'balsa.jpg', 42, 20),
  ('Black Maple', 'Acer', 'Furniture, Flooring', 'maple.jpg', 43, 1),
  ('Hartley Walnut', 'Juglans regia', 'Furniture, Cabinetry', 'walnut.jpg', 44, 2),
  ('Higan Cherry', 'Prunus subhirtella', 'Furniture, Cabinetry', 'cherry.jpg', 45, 3),
  ('Paper Birch', 'Betula papyrifera', 'Furniture, Plywood', 'birch.jpg', 46, 4),
  ('Incense Cedar', 'Calocedrus decurrens', 'Furniture, Fencing', 'cedar.jpg', 47, 5),
  ('Pumpkin Ash', 'Fraxinus profunda', 'Furniture, Tool Handles', 'ash.jpg', 48, 13),
  ('Lombardy Poplar', 'Populus nigra', 'Furniture, Plywood', 'poplar.jpg', 49, 2),
  ('Burmese Rosewood', 'Dalbergia Oliveri', 'Furniture, Musical Instruments', 'rosewood.jpg', 50, 3);
