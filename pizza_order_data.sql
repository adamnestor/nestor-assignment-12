-- CREATE DATABASE

CREATE DATABASE	 pizza_orders;

-- CREATE TABLES

CREATE TABLE customers (
	customer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(255),
    phone_number VARCHAR(20)
);
    
CREATE TABLE orders (
	order_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_date_time DATETIME
);

CREATE TABLE pizzas (
	pizza_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    pizza_type VARCHAR(255),
    price DECIMAL(10,2)
);

CREATE TABLE orders_pizzas (
	order_id INT,
    pizza_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (pizza_id) REFERENCES pizzas(pizza_id)
);

CREATE TABLE orders_customers (
	order_id INT,
    customer_id INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ADD PIZZA VALUES

INSERT INTO pizzas (pizza_type, price)
VALUES ("Pepperoni & Cheese", 7.99); 

INSERT INTO pizzas (pizza_type, price)
VALUES ("Vegetarian", 9.99); 

INSERT INTO pizzas (pizza_type, price)
VALUES ("Meat Lovers", 14.99); 

INSERT INTO pizzas (pizza_type, price)
VALUES ("Hawaiian", 12.99); 

SELECT * FROM pizzas;

-- ADD CUSTOMER VALUES

INSERT INTO customers (customer_name, phone_number)
VALUES ("Trevor Page", "226-555-4982"); 

INSERT INTO customers (customer_name, phone_number)
VALUES ("John Doe", "555-555-9498");

SELECT * FROM customers;

-- ADD ORDER VALUES

INSERT INTO orders (order_date_time)
VALUES ('2023-09-10 09:47:00');

INSERT INTO orders (order_date_time)
VALUES ('2023-09-10 13:20:00');

INSERT INTO orders (order_date_time)
VALUES ('2023-09-10 09:47:00');

INSERT INTO orders (order_date_time)
VALUES ('2023-10-10 10:37:00');

SELECT * FROM orders;

-- ADD ORDERS_PIZZAS VALUES

INSERT INTO orders_pizzas (order_id, pizza_id, quantity)
VALUES (1, 1, 1);

INSERT INTO orders_pizzas (order_id, pizza_id, quantity)
VALUES (1, 3, 1);

INSERT INTO orders_pizzas (order_id, pizza_id, quantity)
VALUES (2, 2, 1);

INSERT INTO orders_pizzas (order_id, pizza_id, quantity)
VALUES (2, 3, 2);

INSERT INTO orders_pizzas (order_id, pizza_id, quantity)
VALUES (3, 3, 1);

INSERT INTO orders_pizzas (order_id, pizza_id, quantity)
VALUES (3, 4, 1);

INSERT INTO orders_pizzas (order_id, pizza_id, quantity)
VALUES (4, 2, 3);

INSERT INTO orders_pizzas (order_id, pizza_id, quantity)
VALUES (4, 4, 1);

SELECT * FROM orders_pizzas;

-- ADD ORDERS_CUSTOMERS VALUES

INSERT INTO orders_customers (order_id, customer_id)
VALUES (1, 1);

INSERT INTO orders_customers (order_id, customer_id)
VALUES (2, 2);

INSERT INTO orders_customers (order_id, customer_id)
VALUES (3, 1);

INSERT INTO orders_customers (order_id, customer_id)
VALUES (4, 2);

SELECT * FROM orders_customers;

-- TOTAL REVENUE BY CUSTOMER, DESCENDING ORDER

SELECT customer_name, SUM(orders_pizzas.quantity * pizzas.price) AS total_spent
FROM customers
JOIN orders_customers ON customers.customer_id = orders_customers.customer_id
JOIN orders ON orders_customers.order_id = orders.order_id
JOIN orders_pizzas ON orders.order_id = orders_pizzas.order_id
JOIN pizzas ON orders_pizzas.pizza_id = pizzas.pizza_id
GROUP BY customer_name
ORDER BY total_spent DESC;

-- TOTAL REVENUE BY CUSTOMER BY DATE, DESCENDING ORDER

SELECT customer_name, orders.order_date_time AS `date`, SUM(orders_pizzas.quantity * pizzas.price) AS total_spent
FROM customers
JOIN orders_customers ON customers.customer_id = orders_customers.customer_id
JOIN orders ON orders_customers.order_id = orders.order_id
JOIN orders_pizzas ON orders.order_id = orders_pizzas.order_id
JOIN pizzas ON orders_pizzas.pizza_id = pizzas.pizza_id
GROUP BY customer_name, orders.order_date_time
ORDER BY `date` DESC;