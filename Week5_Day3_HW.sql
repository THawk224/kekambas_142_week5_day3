-- Homework Exercises


-- 1. List all customers with their address who live in Texas (use JOINs) 
SELECT c.customer_id, c.first_name, c.last_name, a.address, a.district
FROM customer c
JOIN address a ON c.address_id = a.address_id
WHERE a.district = 'Texas'; -- Answer: Jennifer, Richard, Bryan, Ian, and Kim


-- 2. List all payments of more than $7.00 with the customer’s first and last name
SELECT c.first_name, c.last_name, p.amount
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
WHERE p.amount > 7.00
ORDER BY p.amount ASC; -- Answer: (First couple) Justin Ngo, Heather Morris, Cathy Spencer, Gail Knight, ... etc. [Used the query function for this question fyi]


-- 3. Show all customer names who have made over $175 in payments (use subqueries) 
SELECT *
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > 175
); -- Answer: Tommy Collazo, Rhonda Kennedy, Clara Shaw, Eleanor Hunt, Marion Snyder, Karl Seal


-- 4. List all customers that live in Argentina (use multiple joins) 
SELECT customer.customer_id, customer.first_name, customer.last_name
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE country.country = 'Argentina'; -- Answer: Willie Markham, Jordan Archuleta, Jason Morrissey, Kimberley Lee,... etc. [The entries matched the one given in Brian's homework sql. There were 13 entries]


-- 5. Show all the film categories with their count in descending order
SELECT category.name AS category_name, COUNT(film_category.film_id) AS film_count
FROM category
LEFT JOIN film_category ON category.category_id = film_category.category_id
GROUP BY category.name
ORDER BY film_count DESC; -- Answer: 13 categories, and they all matched the one shown in Brian's example. Mine did not show category IDs like Brian's did.


-- 6. What film had the most actors in it (show film info)?
SELECT film_id, title, COUNT(actor_id) AS num_actors
FROM film 
JOIN film_actor USING (film_id) 
GROUP BY film_id, title
ORDER BY num_actors DESC
LIMIT 1; -- Answer: Lambs Cincinatti with 15 actos


-- 7. Which actor has been in the least movies?
SELECT actor.actor_id, actor.first_name, actor.last_name, COUNT(film_actor.film_id)  
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
ORDER BY COUNT(actor.actor_id) ASC
LIMIT 1; -- Answer: Emily Dee WITH 14 movies
    

-- 8. Which country has the most cities?
SELECT country.country_id, COUNT(city_id) AS number_of_cities, country.country 
FROM country 
JOIN city ON country.country_id = city.country_id
GROUP BY country.country_id 
ORDER BY number_of_cities DESC
LIMIT 3; -- Answer: India(60), China(53), United States(35)

-- 9. List the actors who have been in between 20 and 25 films.
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id 
GROUP BY a.actor_id, a.first_name, a.last_name 
HAVING COUNT(fa.film_id) BETWEEN 20 AND 25
ORDER BY film_count DESC; -- Answer: 65 actors who have been in between 20 and 25 films. Some of the names from the output are Ellen Presley, Spencer Depp, Meryl Allen, Thora Temple, etc.