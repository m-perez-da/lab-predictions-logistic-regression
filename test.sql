USE sakila;

-- 1.

SELECT f.film_id, f.rental_rate, f.rental_duration, f.rating, c.name AS category, sub2.n_rentals 
FROM sakila.film f
LEFT JOIN sakila.film_category fc 
USING(film_id)
LEFT JOIN sakila.category c 
USING(category_id)
LEFT JOIN(
SELECT film_id, SUM(sub.n_rentals_by_inventory_id) AS n_rentals
FROM sakila.inventory
JOIN(
	SELECT inventory_id, COUNT(inventory_id) AS n_rentals_by_inventory_id
	FROM sakila.rental
    WHERE (YEAR(rental_date) = 2005)
	GROUP BY inventory_id) sub
USING (inventory_id)
GROUP BY (film_id)) sub2
USING (film_id);

-- 2. 

SELECT f.film_id, f.rental_rate, f.rental_duration, f.rating, c.name AS category, sub2.n_rentals, 
CASE
WHEN sub2.n_rentals>1 then "True" 
ELSE "False" 
END AS "rented" 
FROM sakila.film f
LEFT JOIN sakila.film_category fc 
USING(film_id)
LEFT JOIN sakila.category c 
USING(category_id)
LEFT JOIN(
SELECT film_id, SUM(sub.n_rentals_by_inventory_id) AS n_rentals
FROM sakila.inventory
JOIN(
	SELECT inventory_id, COUNT(inventory_id) AS n_rentals_by_inventory_id
	FROM sakila.rental
    WHERE (YEAR(rental_date) = 2005 AND month(rental_date)=5)
	GROUP BY inventory_id) sub
USING (inventory_id)
GROUP BY (film_id)) sub2
USING (film_id);



-- datos de film
SELECT f.film_id, f.rental_rate, f.rental_duration, f.rating, c.name AS category 
FROM sakila.film f
LEFT JOIN sakila.film_category fc 
USING(film_id)
LEFT JOIN sakila.category c 
USING(category_id);


