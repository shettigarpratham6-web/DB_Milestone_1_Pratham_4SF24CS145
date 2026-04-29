
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);



CREATE TABLE Cities (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(100)
);



CREATE TABLE Theatres (
    theatre_id INT PRIMARY KEY,
    theatre_name VARCHAR(100),
    city_id INT,
    FOREIGN KEY (city_id) REFERENCES Cities(city_id)
);



CREATE TABLE Screens (
    screen_id INT PRIMARY KEY,
    theatre_id INT,
    screen_name VARCHAR(100),
    FOREIGN KEY (theatre_id) REFERENCES Theatres(theatre_id)
);



CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    movie_name VARCHAR(100)
);



CREATE TABLE Genres (
    genre_id INT PRIMARY KEY,
    genre_name VARCHAR(100)
);



CREATE TABLE Movie_Genre (
    movie_id INT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (genre_id) REFERENCES Genres(genre_id)
);



CREATE TABLE Languages (
    language_id INT PRIMARY KEY,
    language_name VARCHAR(100)
);



CREATE TABLE Movie_Language (
    movie_id INT,
    language_id INT,
    PRIMARY KEY (movie_id, language_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (language_id) REFERENCES Languages(language_id)
);



CREATE TABLE Seats (
    seat_id INT PRIMARY KEY,
    screen_id INT,
    seat_number VARCHAR(10),
    seat_type VARCHAR(50),
    FOREIGN KEY (screen_id) REFERENCES Screens(screen_id)
);


CREATE TABLE Shows (
    show_id INT PRIMARY KEY,
    movie_id INT,
    screen_id INT,
    show_time DATETIME,
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (screen_id) REFERENCES Screens(screen_id)
);



CREATE TABLE Show_Seats (
    show_seat_id INT PRIMARY KEY,
    show_id INT,
    seat_id INT,
    price DECIMAL(10,2),
    is_available BOOLEAN,
    FOREIGN KEY (show_id) REFERENCES Shows(show_id),
    FOREIGN KEY (seat_id) REFERENCES Seats(seat_id)
);



CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    booking_time DATETIME,
    payment_status VARCHAR(50)
);



CREATE TABLE Booking_Seats (
    booking_id INT,
    show_seat_id INT,
    PRIMARY KEY (booking_id, show_seat_id),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id),
    FOREIGN KEY (show_seat_id) REFERENCES Show_Seats(show_seat_id)
);



CREATE TABLE Booking_Users (
    booking_id INT,
    user_id INT,
    PRIMARY KEY (booking_id, user_id),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);



CREATE TABLE Seat_User (
    booking_id INT,
    show_seat_id INT,
    user_id INT,
    PRIMARY KEY (booking_id, show_seat_id),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id),
    FOREIGN KEY (show_seat_id) REFERENCES Show_Seats(show_seat_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Users VALUES
(1, 'Rahul', 'rahul@gmail.com'),
(2, 'Anita', 'anita@gmail.com');

INSERT INTO Cities VALUES
(1, 'Bangalore'),
(2, 'Mumbai');

INSERT INTO Theatres VALUES
(1, 'PVR Orion', 1),
(2, 'INOX Mall', 2);

INSERT INTO Screens VALUES
(1, 1, 'Screen 1'),
(2, 1, 'Screen 2');

INSERT INTO Movies VALUES
(1, 'KGF'),
(2, 'RRR');

INSERT INTO Genres VALUES
(1, 'Action'),
(2, 'Drama');

INSERT INTO Movie_Genre VALUES
(1, 1),
(2, 2);

INSERT INTO Languages VALUES
(1, 'Kannada'),
(2, 'Hindi');

INSERT INTO Movie_Language VALUES
(1, 1),
(2, 2);

INSERT INTO Seats VALUES
(1, 1, 'A1', 'Regular'),
(2, 1, 'A2', 'Regular'),
(3, 2, 'B1', 'Premium');

INSERT INTO Shows VALUES
(1, 1, 1, '2026-05-01 10:00:00'),
(2, 2, 2, '2026-05-01 14:00:00');

INSERT INTO Show_Seats VALUES
(1, 1, 1, 200.00, TRUE),
(2, 1, 2, 200.00, TRUE),
(3, 2, 3, 300.00, TRUE);

INSERT INTO Bookings VALUES
(1, '2026-05-01 09:00:00', 'PAID');

INSERT INTO Booking_Seats VALUES
(1, 1),
(1, 2);

INSERT INTO Booking_Users VALUES
(1, 1),
(1, 2);

INSERT INTO Seat_User VALUES
(1, 1, 1),
(1, 2, 2);

--1
SELECT 
    b.booking_id,
    m.movie_name,
    t.theatre_name,
    s.show_time,
    se.seat_number
FROM Bookings b
JOIN Seat_User su ON b.booking_id = su.booking_id
JOIN Users u ON su.user_id = u.user_id
JOIN Show_Seats ss ON su.show_seat_id = ss.show_seat_id
JOIN Seats se ON ss.seat_id = se.seat_id
JOIN Shows s ON ss.show_id = s.show_id
JOIN Movies m ON s.movie_id = m.movie_id
JOIN Screens sc ON s.screen_id = sc.screen_id
JOIN Theatres t ON sc.theatre_id = t.theatre_id
WHERE u.user_id = 1
AND b.booking_time BETWEEN '2026-01-01' AND '2026-12-31';


--2
SELECT 
    m.movie_name,
    COUNT(DISTINCT b.booking_id) AS total_bookings
FROM Bookings b
JOIN Booking_Seats bs ON b.booking_id = bs.booking_id
JOIN Show_Seats ss ON bs.show_seat_id = ss.show_seat_id
JOIN Shows s ON ss.show_id = s.show_id
JOIN Movies m ON s.movie_id = m.movie_id
GROUP BY m.movie_name
ORDER BY total_bookings DESC
LIMIT 1;

--3
SELECT  
    s.show_id, 
    m.movie_name, 
    s.show_time, 
    COUNT(CASE WHEN ss.is_available = 0 THEN 1 ELSE NULL END) AS booked_seats, 
    COUNT(CASE WHEN ss.is_available = 1 THEN 1 ELSE NULL END) AS available_seats 
FROM Shows s 
JOIN Movies m ON s.movie_id = m.movie_id 
JOIN Screens sc ON s.screen_id = sc.screen_id 
JOIN Theatres t ON sc.theatre_id = t.theatre_id 
JOIN Show_Seats ss ON s.show_id = ss.show_id 
WHERE t.theatre_id = 1 
AND DATE(s.show_time) = '2026-05-01' 
GROUP BY s.show_id, m.movie_name, s.show_time;

--4
BEGIN TRANSACTION;

SELECT is_available  
FROM Show_Seats  
WHERE show_seat_id IN (101, 102);

INSERT INTO Bookings (booking_id, booking_time, payment_status) 
VALUES (2, CURRENT_TIMESTAMP, 'PENDING');

INSERT INTO Booking_Seats (booking_id, show_seat_id) 
VALUES (2, 101), (2, 102);

UPDATE Show_Seats 
SET is_available = 0 
WHERE show_seat_id IN (101, 102)
AND is_available = 1;

COMMIT;

select * from Bookings;
select * from Booking_Seats;