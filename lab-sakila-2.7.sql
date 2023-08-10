USE sakila;

-- 1. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
SELECT c.name, count(f.film_id) AS number_of_films
FROM sakila.category c
JOIN sakila.film_category f
ON c.category_id = f.category_id
GROUP BY c.name;

-- 2. Display the total amount rung up by each staff member in August of 2005.
--    "Rung up" is a colloquial phrase often used to refer to the total amount of sales made by a retail staff member or cashier. 
--    In a retail or sales context, it means the total value of items or products that have been sold by a particular staff member during a given period of time. 
--    It's essentially the total dollar amount of transactions processed by that staff member at the cash register or point of sale system.
SELECT s.first_name, SUM(p.amount) AS rung_up
FROM sakila.staff s
JOIN sakila.payment p
ON s.staff_id = p.staff_id
WHERE p.payment_date BETWEEN '2005-08-01' AND '2005-08-31'
GROUP BY s.first_name;

-- Just to check
SELECT staff_id, SUM(amount) AS rung_up
FROM  sakila.payment
WHERE payment_date BETWEEN '2005-08-01' AND '2005-08-31'
GROUP BY staff_id;

-- Just to check
SELECT staff_id, amount AS rung_up, payment_date
FROM  sakila.payment
WHERE payment_date BETWEEN '2005-08-01' AND '2005-08-31';

-- 3. Which actor has appeared in the most films?
SELECT a.actor_id, a.first_name, count(f.film_id) AS numer_of_films
FROM sakila.actor a
JOIN sakila.film_actor f
ON a.actor_id = f.actor_id
GROUP BY a.actor_id
ORDER BY numer_of_films DESC
LIMIT 1;

-- Just to check
SELECT actor_id, COUNT(film_id) AS numer_of_films
FROM sakila.film_actor
GROUP BY actor_id
ORDER BY numer_of_films DESC
LIMIT 1;

-- 4. Most active customer (the customer that has rented the most number of films)

-- Just to check
SELECT customer_id, COUNT(rental_id) AS 'number of rentals'
FROM sakila.rental
GROUP BY customer_id
ORDER BY COUNT(rental_id) DESC
LIMIT 1;

-- Solution
SELECT c.first_name, COUNT(r.rental_id) AS number_of_rentals
FROM sakila.customer c
JOIN sakila.rental r
USING (customer_id)
GROUP BY r.customer_id
ORDER BY count(rental_id) DESC
LIMIT 1;

-- 5. Display the first and last names, as well as the address, of each staff member.
SELECT s.first_name, s.last_name, a.address
FROM sakila.staff s
JOIN sakila.address a
USING (address_id);

-- 6. List each film and the number of actors who are listed for that film.
SELECT f.title AS film, COUNT(a.actor_id) as number_of_actors
FROM sakila.film f
LEFT JOIN sakila.film_actor a
USING (film_id)
GROUP BY f.film_id;

-- Just to check
SELECT film_id, COUNT(actor_id) FROM sakila.film_actor
GROUP BY film_id;
-- I cannot check it this way because the table film_actor doesn´t list all films.

-- 7. Using the tables `payment` and `customer` and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
SELECT c.last_name, SUM(p.amount) AS total_amount
FROM sakila.customer c
JOIN sakila.payment p
USING (customer_id)
GROUP BY c.last_name
ORDER BY c.last_name ASC;

-- 8. List the titles of films per `category`.
SELECT c.name AS category, f.title AS title
FROM sakila.film_category fc
JOIN sakila.film f
USING (film_id)
JOIN sakila.category c
USING (category_id);