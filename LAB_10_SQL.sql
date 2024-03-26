use sakila;

SELECT COUNT(DISTINCT last_name) as Apellidos_diferentes
FROM actor;

-- ¿En cuántos idiomas diferentes se produjeron originalmente las películas?

SELECT COUNT(DISTINCT language_id) AS idiomas_diferentes
FROM FILM;

-- ¿Cuántas películas se lanzaron con la clasificación "PG-13"?

SELECT count(*) AS Películas_PG
FROM film
WHERE rating = "PG-13";

-- Obtener las 10 películas más largas del año 2006.
SELECT *
FROM film
WHERE release_year = 2006
ORDER BY length DESC
LIMIT 10; -- otra forma de hacer selecionando solo las columnas que quieras

-- los dias que han operado, lo sacamos restando los dias
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- Mostrar información de alquiler con columnas adicionales mes y día de la semana. Obtener 20.
SELECT *,
	MONTH(rental_date) AS rental_month,
       DAYOFWEEK(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- Agregar una columna adicional day_type con valores 'weekend' y 'workday' según el día de la semana del alquiler.
SELECT *,
       CASE 
           WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
           ELSE 'workday'
       END AS day_type
FROM rental;

-- ¿Cuántos alquileres hubo en el último mes de actividad?
SELECT COUNT(*) AS last_month_rentals
FROM rental
WHERE rental_date >= LAST_DAY(NOW() - INTERVAL 1 MONTH) + INTERVAL 1 DAY;

-- otra forma de hacerlo

SELECT COUNT(*) AS last_month_rentals
FROM rental
WHERE rental_date >= DATE_FORMAT(NOW(), '%Y-%m-01') - INTERVAL 1 MONTH
AND rental_date < DATE_FORMAT(NOW(), '%Y-%m-01');

-- otra forma tambien de hacerlo
SELECT COUNT(*) AS num_alquileres_ultimo_mes
FROM rental
WHERE rental_date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

SELECT film.title AS last_rented_movie
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
ORDER BY rental.rental_date DESC
LIMIT 1;


SELECT film.title AS last_rented_movie, rental.rental_date AS rental_date
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
ORDER BY rental.rental_date DESC
LIMIT 1;

SELECT CURDATE();

SELECT
 date_format(rental_date, "%Y %m") as fecha_de_aqluiler, COUNT(rental_id)
 FROM rental
 GROUP BY date_format(rental_date, "%Y %m")
 ORDER BY date_format(rental_date, "%Y %m") DESC
 LIMIT 1;

 
 
 
 
 
