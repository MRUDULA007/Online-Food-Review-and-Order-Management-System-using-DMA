/* Find owners' name who own 2 or more businesses:*/
select oname from businessowner
join business on businessowner.UID_BO = business.UID_B
having count(business.UID_B) > 2;

/* Retrieve all owners' names and the number of businesses they own*/
SELECT oname, COUNT(*) as num_of_businesses_owned
FROM businessowner
JOIN business ON businessowner.UID_BO = business.UID_B
GROUP BY oname;

/* Retrieve the total number of fans for each business:*/
SELECT business.Bname, SUM(user.num_of_fans) AS total_fans
FROM business
JOIN user ON business.UID_B = user.UID
GROUP BY business.Bname;

/* Retrieve the customer who have placed more than 2 orders:*/
Select Cname from costumer
where UID_C in (
select UID_OC from ie6700project.order
group by UID_OC
having count(*) > 2);

/* Find Customers who have placed more than 1 orders for products whose price is greater than their average price:*/
SELECT c.Cname, o.OID, od.price, od.amount
FROM costumer c, ie6700project.order o, orderdetails od
WHERE o.UID_OC = c.UID_C and od.OID = o.OID
AND od.price >= (SELECT AVG(price) FROM ie6700project.orderdetails) 
AND amount > 1;

/*Find the businesses whose highest priced product is greater than or equal to the highest priced product of all other businesses:*/
SELECT Bname, MAX(price) AS highest_price
FROM business b, productlist p
WHERE b.BID = p.BID_P
GROUP BY b.BID
HAVING MAX(price) >= ALL (SELECT MAX(price) FROM productlist GROUP BY BID_P);

/* Find the names of customers and deliverymen in a single result set:*/
SELECT Cname AS name FROM costumer
UNION
SELECT Dname AS name FROM deliveryman;

/* Find the businesses with their highest priced product. (null for no products): */
SELECT Bname, (SELECT MAX(price) FROM productlist WHERE BID_P = b.BID) AS highest_price
FROM business b;
