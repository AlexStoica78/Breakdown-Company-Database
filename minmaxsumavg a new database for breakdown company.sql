
create table developers(ID int primary key auto_increment, firstName varchar(20), lastName varchar(20), email varchar(30), address varchar(30), age int, salary int) ;
drop table developers;

insert into developers (firstName, lastName, email, address, age, salary) values
('Cassie',	'Sollett','csollett0@wordpress.org','14th Floor', 14, 70000),
('Benedict','Herrema','bherrema1@unicef.org','Room 507', 38, 60000),
('Yolande',	'Limpenny',	'ylimpenny2@phpbb.com',	'PO Box 43892', 12, 65000),
('Cyrill',	'Felgate','cfelgate3@soundcloud.com','5th Floor', 22, 55000),
('Thibaut',	'Hear',	'tohear4@altervista.org','Suite 26', 42, 90000),
('Rufus','Norville','rnorville5@nbcnews.com','Apt 309', 43, 45000),
('Alano','Wrinch','awrinch6@delicious.com',	'Suite 42', 18, 70000),
('Sapphira','Shark','sshark7@gov.uk','17th Floor', 50, 67000);

select avg (salary)
from developers;

select max(age)
from developers;

select min(salary)
from developers;

select sum(id)
from developers;


-- Using W3Schools or any other resource research the following functions – Avg, Max, Min, Sum.  
-- Explain with examples how each one is used.  Create a separate database with sample data to illustrate your examples.  However please do not copy from the websites.