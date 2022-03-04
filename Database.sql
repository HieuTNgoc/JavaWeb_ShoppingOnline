Create database test01

--//student ID

use test01
create table admin(adminID int primary key identity(1,1),
username varchar(30) unique, password varchar(32) not null check(len(password)>=8))

Create table  Category(cateID int primary key identity(1,1), cateName nvarchar(50),
status bit default 1)

Create table Product(pid varchar(30) primary key,pname nvarchar(100) not null,
quantity int check(quantity>=0), price money check(price>=0), image varchar(100),
description nvarchar(max),status bit default 1,cateID int foreign key references Category(cateID))

create table Customer(cid int primary key identity(1,1), cname nvarchar(30) not null,
cphone varchar(30), cAddress nvarchar(100), username varchar(30) not null unique,
password varchar(32) not null check(len(password)>=8), status bit default 1)

Create table Bill(oID varchar(32) primary key,dateCreate dateTime default getdate(),
cname nvarchar(30) not null,cphone varchar(30), cAddress nvarchar(100), total money,
status int default 0,cid int foreign key references Customer(cid) )

create table BillDetail(pid varchar(30) foreign key references Product(pid),
oID varchar(32) foreign key references Bill(oID), quantity int, price money, total money,
primary key(pid,oID))

--//

insert into Category 
values('Fashion',	1),
('Laptop',	1),
('Phone',	1),
('Watch',	1),
('Cosmetic',		1),
('Footwear',	1),
('Health',	1);

insert into Product 
values ('F01', 'Hoodie', 50, 10, 'hoodie.jpg', 'No brand', 1, 1), 
('F02', 'Bomber unisex', 33, 15, 'Bomber.jfif', 'Coton, China product', 1, 1),
('L01', 'Acer Aspire', 20, 2200, 'hp.jpg', '4GB RAM/256GB SSD/15inch FHDIPS', 1, 2),
('L02', 'DELL Inspiron', 20, 4000, 'dell.jpg', 'Core I5 3.00GHz 4G 120G SSD', 1, 2),
('P01', 'Apple iPhone 12 Pro Max', 20, 2666, 'ip12.jpg', '128GB Gold', 1, 3),
('W01', 'Casio', 20, 28, 'casio.jpg', 'Casio MTP-VT01D-1BUDF Gold', 1, 4),
('C01', 'Vitamin mask', 50, 9, 'vitamin_mask.jpg', 'Vitamin E violet', 1, 5),
('FW01', 'Sneaker HPAS', 10, 33, 'sneaker.jpg', 'Second hand', 1, 6),
('FW02', 'Vans', 10, 200, 'vans.jpg', 'Second hand', 1, 6),
('H01', 'Vitamin C', 10, 300, 'vitaminC.jpg', 'Nam Ha', 0, 7);

insert into admin
values ('abcd',	'1234567890');

insert into Customer
values ('Tran Hieu',	'0915604251',	'SOCSON',	'LULU',	'123456789',	1);