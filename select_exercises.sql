USE albums_db;

SHOW TABLES;

DESCRIBE albums;

SELECT *
FROM albums;

SELECT DISTINCT artist
FROM albums; 

SELECT release_date
FROM albums;

SELECT release_date
FROM albums
ORDER BY release_date ASC;


SELECT release_date
FROM albums
ORDER BY release_date DESC;


SELECT *
FROM albums
WHERE artist = 'Pink Floyd';


SELECT *
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";


SELECT *
FROM albums
WHERE name = 'Nevermind';

SELECT name, genre
FROM albums
WHERE name = 'Nevermind';

SELECT *
FROM albums
WHERE release_date BETWEEN 1990 AND 1999;

SELECT *
FROM albums
WHERE sales < 20.0;

SELECT *
FROM albums
WHERE genre = 'Rock';

SELECT *
FROM albums
WHERE genre = 'hard rock';


SELECT *
FROM albums
WHERE genre ;
