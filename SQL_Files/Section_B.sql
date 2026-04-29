
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
