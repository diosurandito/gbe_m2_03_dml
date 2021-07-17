insert into items (name, price) values ('Nasi Goreng Gila', 25000);

insert into categories (name) values ('main dish');

insert into item_categories (item_id, category_id) values (1, 1);

alter table item_categories modify item_id int not null;
alter table item_categories modify category_id int not null;

alter table item_categories 
add foreign key (item_id) references items(id);

alter table item_categories 
add foreign key (category_id) references categories(id);

create unique index name
on categories (name);

// Creating tables
Table items {
  id int [pk, increment] // auto-increment
  name varchar(50)
  price int
}

Table categories {
  id int [pk, increment]
  name varchar(50)
 }
 
Table item_categories {
  item_id int 
  category_id int
}

//Additional table for homework
Table customers {
  id int [pk, increment]
  name varchar(80)
  phone varchar(20)
  
}

Table orders {
  id int [pk, increment]
  order_date date
  total int(20)
  customer_id int
}

Table order_details {
  order_id int
  item_id int
  quantity int [default: 1]
}

// Creating references
// You can also define relaionship separately
// > many-to-one; < one-to-many; - one-to-one
Ref: item_categories.item_id > items.id  
Ref: item_categories.category_id > categories.id
//----------------------------------------------
Ref: orders.customer_id > customers.id
Ref: order_details.order_id > orders.id
Ref: order_details.item_id > items.id
//----------------------------------------------//

select items.*, categories.name from items 
left join item_categories on items.id = item_categories.item_id
left join categories on categories.id = item_categories.category_id; 

select items.id, items.name from items 
join item_categories on items.id = item_categories.item_id
join categories on categories.id = item_categories.category_id
where categories.name = 'main dish'; 

select items.* from items 
join item_categories on items.id = item_categories.item_id
join categories on categories.id = item_categories.category_id
where categories.name = 'main dish' and items.price > 30000; 

select items.* from items 
left join item_categories on items.id = item_categories.item_id
where item_categories.category_id is null; 

select categories.*, group_concat(items.name separator ',') as item_name, max(items.price) as max_price from items 
join item_categories on items.id = item_categories.item_id
join categories on categories.id = item_categories.category_id
group by categories.id; 

CREATE TABLE `items` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(50),
  `price` int
);

CREATE TABLE `categories` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(50)
);

CREATE TABLE `item_categories` (
  `item_id` int,
  `category_id` int
);

CREATE TABLE `customers` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(80),
  `phone` varchar(20)
);

CREATE TABLE `orders` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `order_date` date,
  `total` int DEFAULT 0,
  `customer_id` int NOT NULL
);

CREATE TABLE `order_details` (
  `order_id` int NOT NULL,
  `item_id` int NOT NULL,
  `quantity` int DEFAULT 1
);

ALTER TABLE `item_categories` ADD FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);

ALTER TABLE `item_categories` ADD FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);

ALTER TABLE `order_details` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

ALTER TABLE `order_details` ADD FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);


INSERT INTO customers (name, phone) VALUES 
('Dio', '087737781051'),
('Ujank', '087737781052'),
('Afif', '087737781053'),
('Bayu', '087737781054'),
('Odenk', '087737781055'),
('Gilang', '087737781056');

INSERT INTO orders (order_date, total, customer_id) VALUES 
('2021-10-20', 27000, 1),
('2021-10-20', 42000, 2),
('2021-10-21', 18000, 3),
('2021-10-23', 15000, 4),
('2021-10-24', 33000, 5),
('2021-10-24', 36000, 6);

INSERT INTO order_details (order_id, item_id) VALUES 
(1, 1),
(1, 2),
(2, 3),
(2, 2),
(3, 4),
(4, 5),
(5, 6),
(5, 8),
(6, 7);

SELECT orders.id AS `Order ID`, orders.order_date AS `Order Date`, customers.name AS `Customer Name`, customers.phone AS `Customer Phone`, orders.total AS `Total` , group_concat(items.name separator ', ') AS `Items Bought` FROM orders 
LEFT JOIN customers ON customers.id = orders.customer_id 
LEFT JOIN order_details ON order_details.order_id = orders.id 
LEFT JOIN items ON items.id = order_details.item_id 
group by orders.id; 

