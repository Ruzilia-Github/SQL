
Short database description "Computer firm":

Скрыть|Hide
The database scheme consists of four tables:
Product(maker, model, type)
PC(code, model, speed, ram, hd, cd, price)
Laptop(code, model, speed, ram, hd, screen, price)
Printer(code, model, color, type, price)
The Product table contains data on the maker, model number, and type of product ('PC', 'Laptop', or 'Printer').
It is assumed that model numbers in the Product table are unique for all makers and product types.
Each personal computer in the PC table is unambiguously identified by a unique code, and is additionally characterized
by its model (foreign key referring to the Product table), processor speed (in MHz) – speed field, RAM capacity (in Mb) - ram,
hard disk drive capacity (in Gb) – hd, CD-ROM speed (e.g, '4x') - cd, and its price. The Laptop table is similar to the PC table,
except that instead of the CD-ROM speed, it contains the screen size (in inches) – screen. For each printer model in the Printer table,
its output type (‘y’ for color and ‘n’ for monochrome) – color field, printing technology ('Laser', 'Jet', or 'Matrix') – type, and price are specified.


1. Find the model number, speed and hard drive capacity for all the PCs with prices below $500.
Result set: model, speed, hd.


SELECT pc.model, pc.speed, pc.hd
FROM pc
JOIN product ON product.model = pc.model
WHERE pc.price <500

2. List all printer makers. Result set: maker.

SELECT DISTINCT maker
FROM Product
JOIN Printer ON Product.model = Printer.model


3. Find the model number, RAM and screen size of the laptops with prices over $1000.

SELECT model, ram, screen FROM Laptop WHERE price > 1000

4. Find all records from the Printer table containing data about color printers.

SELECT * FROM  Printer  WHERE color = 'y'

5. Find the model number, speed and hard drive capacity of PCs cheaper than $600 having a 12x or a 24x CD drive.

SELECT model, speed, hd FROM PC WHERE price < 600 AND (cd = '24x' OR cd = '12x')

6. For each maker producing laptops with a hard drive capacity of 10 Gb or higher, find the speed of such laptops. Result set: maker, speed.

SELECT DISTINCT maker, speed
FROM laptop l, Product p
WHERE l.model = p.model
AND l.hd >=10

7. Get the models and prices for all commercially available products (of any type) produced by maker B.

SELECT Product.model, PC.price FROM Product
JOIN PC ON Product.model = PC.model
WHERE Product.maker = 'B'
UNION
SELECT Product.model, Laptop.price FROM Product
JOIN Laptop ON Product.model = Laptop.model
WHERE Product.maker = 'B'
UNION
SELECT Product.model, Printer.price FROM Product
JOIN Printer ON Product.model = Printer.model
WHERE Product.maker = 'B'

8. Find the makers producing PCs but not laptops.

SELECT DISTINCT p.maker
FROM product p
WHERE p.type = 'PC'
AND p.maker NOT IN (SELECT maker
FROM product
WHERE type='Laptop')

