USE CS143;

-- Q1 the names of all the actors in the movie 'Die Another Day'.
SELECT CONCAT (Actor.first, ' ', Actor.last)
FROM Actor, MovieActor as MA, Movie as M
WHERE MA.aid = Actor.id AND MA.mid = M.id AND M.title = 'Die Another Day'; 

-- Q2 the count of all the actors who acted in multiple movies. 
-- Use two sql table to compare
SELECT COUNT(DISTINCT M1.aid)
FROM MovieActor as M1, MovieActor as M2
WHERE M1.aid = M2.aid AND M1.mid <> M2.mid;

-- Q3  the title of movies that sell more than 1,000,000 tickets.
--  Two select statements used. 
SELECT title 
FROM Movie
WHERE Movie.id IN 
(SELECT Sales.mid 
FROM Sales WHERE ticketsSold > 1000000);

-- Q4 the director(s)' names that direct(s) the largest number of movies. 
-- Compare all number of directors' movies with three select method
SELECT DISTINCT (CONCAT(D.first, ' ', D.last)) 
FROM Director as D, MovieDirector as MD
WHERE D.id = MD.did AND MD.did = 
	(SELECT did from MovieDirector
	GROUP BY did 
	HAVING COUNT(did) >= ALL
		(SELECT COUNT(did)
		FROM MovieDirector 
		GROUP BY did));

-- Q5 the count of all the actors who acted in only one movie.
-- find the reverse group of actors with multiple movies
SELECT COUNT(DISTINCT MovieActor.aid) 
FROM MovieActor 
WHERE NOT EXISTS (
	SELECT MA1.aid from MovieActor as MA1, MovieActor as MA2 
    WHERE MA1.aid = MA2.aid AND MA1.aid = MovieActor.aid AND MA1.mid <> MA2.mid);
    







