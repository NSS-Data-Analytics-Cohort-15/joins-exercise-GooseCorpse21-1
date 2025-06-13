-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.
SELECT s.film_title, s.release_year, r.worldwide_gross
FROM specs AS s
INNER JOIN revenue AS r
USING (movie_id)
GROUP BY s.film_title, s.release_year, r.worldwide_gross
ORDER BY r.worldwide_gross ASC

-- 2. What year has the highest average imdb rating?
SELECT s.release_year, r.imdb_rating
FROM specs AS s
INNER JOIN rating AS r
USING (movie_id)
GROUP BY s.release_year, r.imdb_rating
ORDER BY r.imdb_rating DESC

-- 3. What is the highest grossing G-rated movie? Which company distributed it?
SELECT s.film_title, s.mpaa_rating, d.company_name, r.worldwide_gross
FROM specs AS s
INNER JOIN distributors AS d
ON s.domestic_distributor_id = d.distributor_id
INNER JOIN revenue AS r
ON r.movie_id = s.movie_id
WHERE s.mpaa_rating LIKE 'G'
GROUP BY s.film_title, s.mpaa_rating, d.company_name, r.worldwide_gross
ORDER BY r.worldwide_gross DESC

--4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies 
--associated with that distributor in the movies table. 
--Your result set should include all of the distributors, whether or not they have any movies in the movies table.
SELECT DISTINCT(d.company_name), COUNT(s.film_title)
FROM distributors AS d
INNER JOIN specs AS s 
ON s.domestic_distributor_id = d.distributor_id
GROUP BY d.company_name
ORDER BY COUNT(s.film_title) ASC

-- 5. Write a query that returns the five distributors with the highest average movie budget.
SELECT s.film_title,d.company_name, AVG(r.film_budget)
FROM specs AS s
INNER JOIN revenue AS r
ON s.movie_id = r.movie_id
INNER JOIN distributors AS d
ON d.distributor_id = s.domestic_distributor_id
GROUP BY s.film_title,d.company_name
ORDER BY AVG(r.film_budget) DESC

-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? 
-- Which of these movies has the highest imdb rating?
SELECT s.film_title, d.headquarters, r.imdb_rating
FROM specs AS s
INNER JOIN rating AS r
USING (movie_id)
INNER JOIN distributors AS d
ON d.distributor_id = s.domestic_distributor_id
WHERE d.headquarters NOT LIKE '%CA%'
GROUP BY s.film_title, d.headquarters, r.imdb_rating
ORDER BY r.imdb_rating DESC

-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?
SELECT s.film_title,s.length_in_min ,AVG(r.imdb_rating)
FROM specs AS s 
INNER JOIN rating AS r
USING(movie_id)
WHERE s.length_in_min > 120 OR s.length_in_min < 120
GROUP BY s.film_title,s.length_in_min
ORDER BY AVG(r.imdb_rating) DESC
















