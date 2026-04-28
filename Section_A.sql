CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(100),
    user_email VARCHAR(100)
);

CREATE TABLE Movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    movie_name VARCHAR(100)
);

CREATE TABLE Theatres (
    theatre_id INT AUTO_INCREMENT PRIMARY KEY,
    theatre_name VARCHAR(100),
    theatre_location VARCHAR(100)
);

CREATE TABLE Bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    
    user_id INT,
    movie_id INT,
    theatre_id INT,
    
    show_time DATETIME,
    
    total_price DECIMAL(10,2),
    payment_status VARCHAR(20),
    
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (theatre_id) REFERENCES Theatres(theatre_id)
);

CREATE TABLE Booking_Seats (
    booking_id INT,
    seat_number VARCHAR(10),
    
    PRIMARY KEY (booking_id, seat_number),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

INSERT INTO Users (user_name, user_email) VALUES
('Rahul Sharma', 'rahul@gmail.com'),
('Priya Singh', 'priya@gmail.com'),
('Amit Verma', 'amit@gmail.com'),
('Sneha Reddy', 'sneha@gmail.com'),
('Arjun Patel', 'arjun@gmail.com');

INSERT INTO Movies (movie_name) VALUES
('Avengers: Endgame'),
('RRR'),
('KGF Chapter 2'),
('Pushpa'),
('Jawan');

INSERT INTO Theatres (theatre_name, theatre_location) VALUES
('PVR Cinemas', 'Bangalore'),
('INOX', 'Mumbai'),
('Cinepolis', 'Delhi'),
('PVR Cinemas', 'Hyderabad'),
('INOX', 'Ahmedabad');

INSERT INTO Bookings 
(user_id, movie_id, theatre_id, show_time, total_price, payment_status)
VALUES
(1, 1, 1, '2026-05-01 18:30:00', 500.00, 'PAID'),
(2, 2, 2, '2026-05-02 20:00:00', 750.00, 'PENDING'),
(3, 3, 3, '2026-05-03 17:00:00', 250.00, 'PAID'),
(4, 4, 4, '2026-05-04 21:30:00', 600.00, 'FAILED'),
(5, 5, 5, '2026-05-05 19:15:00', 900.00, 'PAID');

INSERT INTO Booking_Seats VALUES
(1, 'A1'), (1, 'A2'),
(2, 'B5'), (2, 'B6'), (2, 'B7'),
(3, 'C3'),
(4, 'D1'), (4, 'D2'),
(5, 'E4'), (5, 'E5'), (5, 'E6');