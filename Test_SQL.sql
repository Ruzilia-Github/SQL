
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

9. Find the makers of PCs with a processor speed of 450 MHz or more. Result set: maker.

SELECT DISTINCT p.maker FROM Product p WHERE p.model IN (SELECT model FROM pc WHERE speed >= 450)

10. Find the printer models having the highest price. Result set: model, price.

SELECT model, price
FROM Printer
WHERE price =
(SELECT MAX(price)
FROM Printer
);

11. Find out the average speed of PCs.

SELECT AVG(speed) FROM PC

12. Find out the average speed of the laptops priced over $1000.

SELECT avg(speed) FROM Laptop WHERE  price> 1000

13. Find out the average speed of the PCs produced by maker A.

SELECT AVG(speed) FROM PC WHERE model IN (SELECT model FROM Product WHERE maker = 'A')


The database of naval ships that took part in World War II is under consideration. The database consists of the following relations:
Classes(class, type, country, numGuns, bore, displacement)
Ships(name, class, launched)
Battles(name, date)
Outcomes(ship, battle, result)
Ships in classes all have the same general design. A class is normally assigned either the name of the first ship built according to the corresponding
design, or a name that is different from any ship name in the database. The ship whose name is assigned to a class is called a lead ship.
The Classes relation includes the name of the class, type (can be either bb for a battle ship, or bc for a battle cruiser), country the ship was built in,
the number of main guns, gun caliber (bore diameter in inches), and displacement (weight in tons). The Ships relation holds information about the ship name,
the name of its corresponding class, and the year the ship was launched. The Battles relation contains names and dates of battles the ships participated in,
and the Outcomes relation - the battle result for a given ship (may be sunk, damaged, or OK, the last value meaning the ship survived the battle unharmed).
Notes: 1) The Outcomes relation may contain ships not present in the Ships relation. 2) A ship sunk can’t participate in later battles. 3) For historical reasons,
lead ships are referred to as head ships in many exercises.4) A ship found in the Outcomes table but not in the Ships table is still considered in the database.
This is true even if it is sunk.


14. For the ships in the Ships table that have at least 10 guns, get the class, name, and country.

SELECT s.class, s.name, c.country
FROM Ships AS s
LEFT JOIN Classes AS c ON c.class = s.class
WHERE numGuns >= 10

15. Get hard drive capacities that are identical for two or more PCs.
Result set: hd.

SELECT hd FROM PC
GROUP BY hd
HAVING COUNT (hd) >= 2


16. Get pairs of PC models with identical speeds and the same RAM capacity. Each resulting pair should be displayed only once, i.e. (i, j) but not (j, i).
Result set: model with the bigger number, model with the smaller number, speed, and RAM.

SELECT DISTINCT i.model, j.model, i.speed, i.ram
FROM PC i
JOIN PC j
ON i.speed= j.speed AND i.ram = j.ram AND i.model > j.model

17. Get the laptop models that have a speed smaller than the speed of any PC.
Result set: type, model, speed.

SELECT DISTINCT'Laptop' AS type, model, speed FROM Laptop WHERE speed < (SELECT MIN (speed) FROM PC)

18. Find the makers of the cheapest color printers.
Result set: maker, price.

SELECT DISTINCT pro.maker, pri.price
FROM product pro
INNER JOIN printer pri on pro.model = pri.model
WHERE color='y' AND pri.price = (SELECT MIN(price) FROM printer WHERE color='y')

