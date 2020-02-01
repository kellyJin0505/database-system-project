use CS143;
-- drop all previous same table to avoid error
DROP TABLE if EXISTS MaxMovieId;
DROP TABLE IF EXISTS MaxPersonId;
DROP TABLE IF EXISTS MovieActor;
DROP TABLE IF EXISTS MovieDirector;
DROP TABLE IF EXISTS MovieGenre;
DROP TABLE IF EXISTS MovieRating;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Movie;
DROP TABLE IF EXISTS Actor;
DROP TABLE IF EXISTS Director;

CREATE TABLE Movie(
	id int NOT NULL,
	title varchar(100) NOT NULL,
	year int NOT NULL,
	rating varchar(10),
	company varchar(50),
	PRIMARY KEY (id),
    CHECK(id >= 0), -- 我加了movie actor director id >0 de 
	CHECK(rating IS NULL OR rating='G' OR rating='PG' OR rating='PG-13' OR rating='R' OR rating='NC-17' OR rating='surrendere'), -- 我加了surrendere 
	CHECK(year > 1900 AND year < 2025) -- 这个年份感觉check 不是很必要？ 作为一个应该支持insert新电影的话
) ENGINE = INNODB;

CREATE TABLE Actor(
	id INT NOT NULL,
    last VARCHAR(20),
	first VARCHAR(20),
	sex VARCHAR(6),
    dob DATE NOT NULL,
    dod DATE,
    CHECK(id >= 0),
    PRIMARY KEY (id)
) ENGINE = INNODB;

CREATE TABLE Director(
	id INT NOT NULL,
    last VARCHAR(20),
	first VARCHAR(20),
    dob DATE NOT NULL,
    dod DATE,
    PRIMARY KEY (id)
) ENGINE = INNODB;

CREATE TABLE Sales(
	mid INT NOT NULL,
	ticketssold INT,
    totalincome INT,
	FOREIGN KEY (mid) REFERENCES Movie(id) 
	ON DELETE CASCADE 
    ON UPDATE CASCADE
) ENGINE = INNODB;

CREATE TABLE MovieGenre(
	mid INT NOT NULL,
    genre VARCHAR(20), 
	FOREIGN KEY (mid) REFERENCES Movie(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = INNODB;

CREATE TABLE MovieDirector(
	mid INT NOT NULL,
    did INT NOT NULL,
    FOREIGN KEY (mid) REFERENCES Movie(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (did) REFERENCES Director(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = INNODB;

CREATE TABLE MovieActor(
	mid INT NOT NULL,
	aid INT NOT NULL,
    role VARCHAR (50),
    FOREIGN KEY (mid) REFERENCES Movie(id) ON DELETE CASCADE,
    FOREIGN KEY (aid) REFERENCES Actor(id) ON DELETE CASCADE
) ENGINE = INNODB;

CREATE TABLE MovieRating(
	mid INT NOT NULL,
    imdb INT,
    rot INT,
    FOREIGN KEY (mid) REFERENCES Movie(id) ON DELETE CASCADE

) ENGINE = INNODB;

CREATE TABLE Review(
	name VARCHAR (20),
    time TIMESTAMP,
    mid INT NOT NULL,
    rating INT NOT NULL,
    comment VARCHAR(500),
    FOREIGN KEY (mid) REFERENCES Movie(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CHECK(rating >= 0 AND rating <= 100)-- 这个数据不知道，是不是可以先不要
	
) ENGINE = INNODB;

CREATE TABLE MaxPersonId(
	id INT NOT NULL,
    PRIMARY KEY(id)
) ENGINE = INNODB;

CREATE TABLE MaxMovieId(
	id INT NOT NULL,
    PRIMARY KEY(id)
) ENGINE = INNODB;







