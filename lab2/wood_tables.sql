\dt   -- to see existing tables

-- creating table hardness_char
CREATE TABLE "hardness_char"(
  "id" SERIAL PRIMARY KEY,
  "hardness" VARCHAR(50)
);
-- creating table wood_characteristics
CREATE TABLE "wood_characteristics" (
  "id" SERIAL PRIMARY KEY,
  "density" DECIMAL(10,2),
  "hardness_id" INT REFERENCES "hardness_char" ("id"),              -- one-to-many
  "color" VARCHAR(50)
);

-- creating table common_uses
CREATE TABLE "common_uses"(
  "id" SERIAL PRIMARY KEY,
  "common_uses" TEXT
);

-- creating table wood_suppliers
CREATE TABLE "wood_suppliers" (
  "id" SERIAL PRIMARY KEY,
  "supplier_name" VARCHAR(100),
  "gmail" TEXT,
  "phone_number" TEXT
);
-- creating table price
CREATE TABLE "price"(
  "id" SERIAL PRIMARY KEY,
  "supplier_id" INT REFERENCES "wood_suppliers" ("id"),
  "supplier_price" DECIMAL(10,2),
  "sup_date" DATE
);

  "woodtype_id" INT REFERENCES "wood_types" ("id"),     -- add separately

-- creating table wood_types
CREATE TABLE "wood_types" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(100) NOT NULL,
  "scientific_name" VARCHAR(100),
  "image_url" VARCHAR(255),
  "uses_id" INT REFERENCES "common_uses" ("id"),                  -- one-to-many
  "char_id" INT UNIQUE REFERENCES "wood_characteristics" ("id")   -- one-to-one
);

ALTER TABLE price
ADD woodtype_id INT REFERENCES wood_types(id);


\dt
\d wood_types         -- to see contents of table
\d wood_characteristics
\d wood_suppliers
\d hardness_char
\d common_uses

-- ALTER TABLE "wood_types" ADD FOREIGN KEY ("wood_id") REFERENCES "wood_characteristics" ("wood_id");

SELECT * FROM wood_types;
SELECT * FROM wood_characteristics;
SELECT * FROM wood_suppliers;
SELECT * FROM hardness_char;
SELECT * FROM common_uses;
SELECT * FROM price;

SELECT w.name, s.supplier_name
FROM wood_suppliers AS s
JOIN wood_types w ON s.id=w.sup_id;

DELETE FROM hardness_char;
DELETE FROM wood_characteristics;
DELETE FROM common_uses;
DELETE FROM wood_suppliers;
DELETE FROM wood_types;
DELETE FROM price;

DROP TABLE price;
DROP TABLE wood_types;
DROP TABLE wood_suppliers;
DROP TABLE common_uses;
DROP TABLE wood_characteristics;
DROP TABLE hardness_char;

-- Reset sequence to start from 1
ALTER SEQUENCE table_name_id_seq RESTART WITH 1;
ALTER SEQUENCE wood_characteristics_id_seq RESTART WITH 1;
ALTER SEQUENCE common_uses_id_seq RESTART WITH 1;
ALTER SEQUENCE wood_suppliers_id_seq RESTART WITH 1;
ALTER SEQUENCE wood_types_id_seq RESTART WITH 1;
ALTER SEQUENCE price_id_seq RESTART WITH 1;



-- inserting into hardness_char table
INSERT INTO hardness_char ("hardness")
VALUES
  ('Soft'),
  ('Medium'),
  ('Hard');

-- inserting into wood_characteristics
INSERT INTO wood_characteristics ("density", "hardness_id", "color")
VALUES
  (0.75, 2, 'Light Brown'),
  (0.65, 2, 'Yellow'),
  (0.7, 2, 'Dark Brown'),
  (0.8, 3, 'Tan'),
  (0.68, 2, 'Golden Brown'),
  (0.78, 2, 'Chestnut'),
  (0.72, 2, 'Honey'),
  (0.76, 2, 'Amber'),
  (0.82, 3, 'Walnut'),
  (0.74, 2, 'Hazel'),
  (0.79, 3, 'Caramel'),
  (0.71, 2, 'Copper'),
  (0.69, 2, 'Blonde'),
  (0.77, 2, 'Sepia'),
  (0.73, 2, 'Wheat'),
  (0.85, 3, 'Mocha'),
  (0.81, 3, 'Cocoa'),
  (0.83, 3, 'Coffee'),
  (0.84, 3, 'Mahogany'),
  (0.86, 3, 'Cinnamon'),
  (0.87, 3, 'Chocolate'),
  (0.88, 3, 'Chestnut'),
  (0.89, 3, 'Hickory'),
  (0.9, 3, 'Auburn'),
  (0.91, 3, 'Russet'),
  (0.92, 3, 'Ginger'),
  (0.93, 3, 'Bronze'),
  (0.94, 3, 'Brass'),
  (0.95, 3, 'Copper'),
  (0.96, 3, 'Gold'),
  (0.97, 3, 'Platinum'),
  (0.98, 3, 'Silver'),
  (0.99, 3, 'Steel'),
  (0.67, 2, 'Ivory'),
  (0.66, 2, 'Cream'),
  (0.64, 2, 'Beige'),
  (0.63, 2, 'Taupe'),
  (0.62, 2, 'Sand'),
  (0.61, 2, 'Linen'),
  (0.6, 2, 'Ecru'),
  (0.59, 1, 'Oatmeal'),
  (0.58, 1, 'Khaki'),
  (0.57, 1, 'Tan'),
  (0.56, 1, 'Buff'),
  (0.55, 1, 'Caramel'),
  (0.54, 1, 'Mocha'),
  (0.53, 1, 'Chestnut'),
  (0.52, 1, 'Cinnamon'),
  (0.51, 1, 'Coffee'),
  (0.5, 1, 'Mahogany');


-- insert into table common_uses
INSERT Into common_uses ("common_uses")
VALUES
  ('Furniture, Flooring'),
  ('Construction, Furniture'),
  ('Furniture, Musical Instruments'),
  ('Furniture, Cabinetry'),
  ('Furniture, Plywood'),
  ('Furniture, Fencing'),
  ('Furniture, Tool Handles'),
  ('Furniture, Carving'),
  ('Construction, Musical Instruments'),
  ('Construction, Paper'),
  ('Model Making, Packaging'),
  ('Musical Instruments, Turning'),
  ('Furniture, Incense'),
  ('Construction, Flooring'),
  ('Tool Handles, Flooring'),
  ('Construction, Boat Building'),
  ('Construction, Outdoor Furniture'),
  ('Archery Bows, Furniture'),
  ('Flooring, Insulation'),
  ('Construction, Tool Handles'),
  ('Furniture, Turning'),
  ('Outdoor Furniture, Boat Building'),
  ('Model Making, Packaging');

-- insert into wood_suppliers
INSERT INTO wood_suppliers ("supplier_name", "gmail", "phone_number")
VALUES
  ('Adam Woodpecker', 'adam.woodpecker@example.com', '(380) 123-4567'),
  ('Bob Tree', 'bob.tree@example.com', '(380) 987-6543'),
  ('Casy Forest', 'casy.forest@example.com', '(380) 555-1234'),
  ('Eve Rovan', 'eve.rovan@example.com', '(380) 777-8888'),
  ('Frank Willowson', 'frank.willowson@example.com', '(380) 321-6549'),
  ('George Linden', 'george.linden@example.com', '(380) 456-7890'),
  ('Henry Timberlake', 'henry.timberlake@example.com', '(380) 234-5678'),
  ('Ivan Ashford', 'ivan.ashford@example.com', '(380) 876-5432'),
  ('Jack Branch', 'jack.branch@example.com', '(380) 111-2222'),
  ('Kevin Penkin', 'kevin.penkin@example.com', '(380) 999-8888'),
  ('Lily Spruce', 'lily.spruce@example.com', '(380) 777-1234'),
  ('Mike Coppard', 'mike.coppard@example.com', '(380) 654-3210'),
  ('Nancy Fernwood', 'nancy.fernwood@example.com', '(380) 432-1098'),
  ('Oscar Forestman', 'oscar.forestman@example.com', '(380) 888-7777'),
  ('Peter Hemlock', ' peter.hemlock@example.com', '(380) 555-9999'),
  ('Queen Sylvan', 'queen.sylvan@example.com', '(380) 246-1357'),
  ('Robert Thorneycroft', 'robert.thorneycroft@example.com', '(380) 369-2580'),
  ('Sam Driftwood', 'sam.driftwood@example.com', '(380) 741-8520'),
  ('Tom Leafwood', 'tom.leafwood@example.com', '(380) 753-9514'),
  ('Ursula Evergreen', 'ursula.evergreen@example.com', '(380) 999-1111');

-- inserting into wood_types
INSERT INTO wood_types ("name", "scientific_name", "image_url", "uses_id", "char_id")
VALUES
  ('Oak', 'Quercus', 'oak.jpg', 1, 1),
  ('Pine', 'Pinus', 'pine.jpg', 2, 2),
  ('Mahogany', 'Swietenia', 'mahogany.jpg', 9, 3),
  ('Maple', 'Acer', 'maple.jpg', 4, 4),
  ('Walnut', 'Juglans', 'walnut.jpg', 5, 5),
  ('Cherry', 'Prunus','cherry.jpg', 16, 6),
  ('Birch', 'Betula', 'birch.jpg', 3, 7),
  ('Cedar', 'Cedrus', 'cedar.jpg', 8, 8),
  ('Ash', 'Fraxinus', 'ash.jpg', 3, 9),
  ('Poplar', 'Populus', 'poplar.jpg', 10, 10),
  ('Rosewood', 'Dalbergia', 'rosewood.jpg', 11, 11),
  ('Butternut', 'Juglans', 'butternut.jpg', 12, 12),
  ('Sycamore', 'Acer', 'sycamore.jpg', 13, 13),
  ('Spruce', 'Picea', 'spruce.jpg', 14, 14),
  ('Blue Spruce', 'Picea pungens', 'fir.jpg', 15, 15),
  ('Fraser Fir', 'Abies fraseri', 'balsa.jpg', 16, 16),
  ('Pale Moon Ebony', 'Diospyros malabarica', 'ebony.jpg', 17, 17),
  ('Sandalwood', 'Santalum', 'sandalwood.jpg', 18, 18),
  ('Larch', 'Larix', 'larch.jpg', 19, 19),
  ('Hickory', 'Carya', 'hickory.jpg', 20, 20),
  ('Cypress', 'Cupressus', 'cypress.jpg', 21, 21),
  ('Redwood', 'Sequoia', 'redwood.jpg', 22, 22),
  ('Beech', 'Fagus', 'beech.jpg', 23, 23),
  ('Yew', 'Taxus', 'yew.jpg', 22, 24),
  ('Cork', 'Quercus', 'cork.jpg', 20, 25),
  ('Alder', 'Alnus', 'alder.jpg', 19, 26),
  ('Mango', 'Mangifera', 'mango.jpg', 18, 27),
  ('Acacia', 'Acacia', 'acacia.jpg', 18, 28),
  ('Lignum', 'Gmelina', 'lignum.jpg', 7, 29),
  ('Padauk', 'Pterocarpus', 'padauk.jpg', 5, 30),
  ('Tulipwood', 'Liriodendron', 'tulipwood.jpg', 1, 31),
  ('Sapele', 'Entandrophragma', 'sapele.jpg', 22, 32),
  ('Cocobolo', 'Dalbergia', 'cocobolo.jpg', 7, 33),
  ('Zebrawood', 'Microberlinia', 'zebrawood.jpg', 20, 34),
  ('Iroko', 'Milicia', 'iroko.jpg', 9, 35),
  ('Ebony', 'Diospyros', 'ebony.jpg', 11, 36),
  ('Teak', 'Tectona', 'teak.jpg', 15, 37),
  ('Austrian Pine', 'Pinus nigra', 'pine.jpg', 18, 38),
  ('Bigleaf Mahogany', 'Swietenia macrophylla', 'mahogany.jpg', 13, 39),
  ('White Oak', 'Quercus alba', 'oak.jpg', 14, 40),
  ('Fir', 'Abies', 'fir.jpg', 13, 41),
  ('Balsa', 'Ochroma', 'balsa.jpg', 4, 42),
  ('Black Maple', 'Acer', 'maple.jpg', 3, 43),
  ('Hartley Walnut', 'Juglans regia', 'walnut.jpg', 4, 44),
  ('Higan Cherry', 'Prunus subhirtella', 'cherry.jpg', 7, 45),
  ('Paper Birch', 'Betula papyrifera', 'birch.jpg', 6, 46),
  ('Incense Cedar', 'Calocedrus decurrens', 'cedar.jpg', 17, 47),
  ('Pumpkin Ash', 'Fraxinus profunda', 'ash.jpg', 18, 48),
  ('Lombardy Poplar', 'Populus nigra', 'poplar.jpg', 20, 49),
  ('Burmese Rosewood', 'Dalbergia Oliveri', 'rosewood.jpg', 13, 50);

INSERT INTO price ("supplier_id", "supplier_price", "sup_date", "woodtype_id")
VALUES
  (1, 350.5, '2023-02-13', 1),
  (1, 653.77, '2023-04-21', 2),
  (1, 566.4, '2023-05-01', 3),
  (1, 605.5, '2023-05-28', 7),
  (1, 410.4, '2024-02-11', 9),
  (2, 370.3, '2023-03-20', 1),
  (2, 600.66, '2024-02-02', 3),
  (2, 750.5, '2023-07-08', 5),
  (2, 822.5, '2023-11-13', 11),
  (2, 630, '2023-12-15', 12),
  (2, 777.7, '2023-10-16', 14),
  (2, 649.99, '2023-09-05', 18),
  (3, 999.99, '2023-05-05', 50),
  (3, 999.9, '2024-01-01', 49),
  (3, 899.99, '2024-01-02', 48),
  (3, 799.99, '2024-01-11', 47),
  (3, 799.9, '2024-02-11', 46),
  (3, 899.9, '2024-02-01', 45),
  (4, 549.9, '2024-01-09', 40),
  (4, 559.9, '2024-01-10', 41),
  (4, 799, '2024-01-12', 47),
  (4, 1100, '2024-01-13', 50),
  (4, 1099, '2024-01-15', 46),
  (4, 444, '2024-01-16', 44),
  (5, 500.5, '2024-01-22', 19),
  (5, 550.5, '2024-01-23', 20),
  (5, 440.4, '2024-01-24', 10),
  (5, 430.3, '2023-11-26', 11),
  (5, 433.3, '2023-11-25', 12),
  (6, 450.5, '2023-11-21', 14),
  (6, 420.5, '2023-11-11', 11),
  (6, 470.54, '2023-10-17', 15),
  (6, 477.55, '2023-10-19', 16),
  (6, 457.53, '2023-10-22', 12),
  (6, 340.99, '2023-10-28', 1),
  (6, 640.5, '2023-10-30', 2),
  (7, 600, '2023-09-11', 20),
  (7, 700, '2023-09-20', 21),
  (7, 650, '2023-09-22', 22),
  (7, 750, '2023-09-12', 23),
  (7, 755, '2023-09-29', 24),
  (8, 1000, '2023-09-19', 25),
  (8, 1200, '2023-09-10', 26),
  (8, 1150, '2023-08-11', 27),
  (8, 1350, '2023-08-17', 50),
  (8, 1255.5, '2023-08-18', 49),
  (9, 800, '2023-09-19', 28),
  (9, 898, '2023-08-05', 29),
  (9, 820, '2023-08-21', 30),
  (9, 440.4, '2023-08-23', 1),
  (9, 730, '2024-01-31', 2),
  (10, 330, '2024-01-03', 31),
  (10, 390, '2024-02-05', 32),
  (10, 333, '2024-02-03', 33),
  (10, 490, '2024-02-08', 44),
  (11, 600, '2024-02-12', 34),
  (11, 610, '2024-02-09', 35),
  (11, 620, '2024-01-09', 36),
  (11, 630, '2024-01-10', 37),
  (11, 640, '2024-01-11', 44),
  (12, 900, '2024-01-12', 45),
  (12, 936.8, '2024-01-17', 46),
  (12, 973.3, '2024-01-15', 47),
  (12, 954.5, '2024-01-19', 48),
  (12, 1111.1, '2024-01-01', 50),
  (13, 344, '2024-01-04', 1),
  (13, 456, '2024-01-05', 2),
  (13, 600, '2023-11-09', 3),
  (13, 605, '2024-01-07', 5),
  (13, 400, '2024-01-10', 31),
  (13, 435, '2024-01-11', 32),
  (14, 435, '2024-01-14', 1),
  (14, 430, '2024-01-18', 2),
  (14, 570, '2024-01-19', 6),
  (15, 758.99, '2024-01-20', 18),
  (15, 700.99, '2023-10-21', 19),
  (15, 850.99, '2023-10-22', 20),
  (16, 855.9, '2023-10-25', 21),
  (16, 970.99, '2023-10-26', 50),
  (16, 880, '2023-10-22', 44),
  (17, 650, '2023-10-28', 10),
  (17, 720, '2023-11-26', 9),
  (17, 700, '2023-09-26', 8),
  (17, 670, '2023-09-03', 7),
  (17, 660, '2023-09-06', 6),
  (18, 500, '2023-09-05', 5),
  (18, 399, '2023-09-09', 4),
  (18, 411.1, '2023-10-10', 3),
  (18, 400.48, '2023-10-17', 2),
  (18, 375, '2024-01-17', 1),
  (19, 900.67, '2024-01-21', 29),
  (19, 910.6, '2024-01-24', 28),
  (19, 940, '2024-01-22', 27),
  (19, 960, '2024-01-28', 26),
  (20, 610.99, '2024-01-24', 34),
  (20, 730.5, '2024-02-02', 35),
  (20, 738.5, '2024-02-03', 36),
  (20, 748.9, '2024-02-04', 37),
  (20, 689.99, '2024-02-05', 2),
  (20, 378.5, '2024-02-08', 1),
  (20, 680, '2024-02-10', 6);


