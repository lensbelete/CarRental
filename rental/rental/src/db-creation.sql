DROP TABLE user;

CREATE TABLE user(
    id INTEGER PRIMARY KEY,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    sex VARCHAR(100) NOT NULL,
    admin BOOLEAN NOT NULL DEFAULT FALSE
);

INSERT INTO user (firstName, lastName, email, password, sex)
VALUES ("Abebe", "Kebede", "abebe@gmail.com", "abebe", "male");

INSERT INTO user (firstName, lastName, email, password, sex)
VALUES ("Betel", "Ashebir", "betel@gmail.com", "betel", "female");

INSERT INTO user (firstName, lastName, email, password, sex, admin)
VALUES ("Admin", "Admin", "admin@admin.com", "admin", "female", true);


DROP TABLE car;

 CREATE TABLE car(
    id INTEGER PRIMARY KEY,
    model VARCHAR(100) NOT NULL,
    rental_fee INT NOT NULL,
    photo VARCHAR(100) NOT NULL,
    add_date DATE DEFAULT CURRENT_DATE,

    owner_id INT,
    start_date DATE,
    end_date DATE,

    FOREIGN KEY (owner_id) REFERENCES user(id) ON DELETE CASCADE
 );



-- many searchable cars
 INSERT INTO car (model, rental_fee, photo, owner_id, start_date, end_date)
 VALUES ("Toyota Corolla", 10000, "a.jpg", 1, "2020-01-01", "2020-05-04");

 INSERT INTO car (model, rental_fee, photo, owner_id, start_date, end_date)
 VALUES ("Toyota Camry", 12000, "b.jpg", 1, "2020-01-01", "2020-06-04");

INSERT INTO car (model, rental_fee, photo)
VALUES ("Toyota Prius", 20000, "c.jpg");

INSERT INTO car (model, rental_fee, photo)
VALUES ("Toyota Yaris", 25000, "d.jpg");

INSERT INTO car (model, rental_fee, photo)
VALUES ("Toyota Avalon", 30000, "e.jpg");

INSERT INTO car (model, rental_fee, photo)
VALUES ("Toyota Sienna", 35000, "f.jpg");

INSERT INTO car (model, rental_fee, photo)
VALUES ("Toyota Highlander", 40000, "g.jpg");

INSERT INTO car (model, rental_fee, photo)
VALUES ("Toyota RAV4", 45000, "h.jpg");

INSERT INTO car (model, rental_fee, photo)
VALUES ("Toyota 4Runner", 50000, "i.jpg");

INSERT INTO car (model, rental_fee, photo)
VALUES ("Toyota Land Cruiser", 55000, "j.jpg");

INSERT INTO car (model, rental_fee, photo)
VALUES ("Toyota Tacoma", 60000, "k.jpg");

INSERT INTO car (model, rental_fee, photo)
VALUES ("Toyota Tundra", 65000, "l.jpg");

INSERT INTO car (model, rental_fee, photo)
VALUES ("Toyota Sequoia", 70000, "m.jpg");

INSERT INTO car (model, rental_fee, photo)
VALUES ("Toyota C-HR", 75000, "n.jpg");

INSERT INTO car (model, rental_fee, photo)
VALUES ("Toyota Venza", 80000, "o.jpg");

INSERT INTO car (model, rental_fee, photo)
VALUES ("Toyota Supra", 85000, "p.jpg");

INSERT INTO car (model, rental_fee, photo)
VALUES ("Toyota Mirai", 90000, "q.jpg");

INSERT INTO car (model, rental_fee, photo)
VALUES ("Toyota GR86", 95000, "r.jpg");

INSERT INTO car (model, rental_fee, photo)
VALUES ("Toyota GR Yaris", 100000, "s.jpg");

INSERT INTO car (model, rental_fee, photo)
VALUES ("Toyota GR Supra", 105000, "t.jpg");

INSERT INTO car (model, rental_fee, photo)
VALUES ("Toyota Corolla", 110000, "u.jpg");


SELECT * FROM car WHERE model LIKE "%toyota%";


DROP TABLE request;
CREATE TABLE request(
    id INTEGER PRIMARY KEY,
    user_id INT NOT NULL,
    car_id INT NOT NULL,

    type VARCHAR NOT NULL DEFAULT 'new', -- new, month, remove
    
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,

    status VARCHAR NOT NULL DEFAULT 'pending', -- pending, accepted, rejected
    time_stamp VARCHAR NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    FOREIGN KEY (car_id) REFERENCES car(id) ON DELETE CASCADE

);


-- request history
INSERT INTO request (user_id, car_id, start_date, end_date, status)
VALUES (1, 1, "2020-01-01", "2020-05-04", "accepted");

INSERT INTO request (user_id, car_id, start_date, end_date, status)
VALUES (1, 2, "2020-01-01", "2020-06-04", "accepted");

INSERT INTO request (user_id, car_id, start_date, end_date, type)
VALUES (1, 2, "2020-01-01", "2020-06-04", "month");

INSERT INTO request (user_id, car_id, start_date, end_date, type, status)
VALUES (1, 1, "2020-01-01", "2020-05-04", "month", "rejected");



-- many requests for admin

INSERT INTO request (user_id, car_id, start_date, end_date)
VALUES (2, 3, "2020-01-01", "2020-02-04");

INSERT INTO request (user_id, car_id, start_date, end_date)
VALUES (2, 4, "2020-02-01", "2020-03-04");

INSERT INTO request (user_id, car_id, start_date, end_date)
VALUES (2, 5, "2020-02-01", "2020-03-04");

INSERT INTO request (user_id, car_id, start_date, end_date)
VALUES (2, 6, "2020-02-01", "2020-03-04");

INSERT INTO request (user_id, car_id, start_date, end_date)
VALUES (2, 7, "2020-02-01", "2020-06-04");



UPDATE request SET time_stamp = datetime('now') WHERE id = 1;
SELECT * FROM request WHERE id IS NOT 999 ORDER BY time_stamp DESC;

SELECT c.*, r.user_id FROM car c
LEFT JOIN request r ON c.id = r.car_id
WHERE c.owner_id IS NULL AND r.user_id IS NOT 1;
