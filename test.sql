
DROP DATABASE IF EXISTS Test;
CREATE DATABASE Test;
USE Test;

CREATE TABLE pets( 
	petid VARCHAR(255) , 
    name VARCHAR(255) ,
    kind VARCHAR(255) ,
    gender VARCHAR(255) ,
    age INT,
    ownerid VARCHAR(255));
    
    CREATE TABLE owners (
    ownerid VARCHAR(255) , 
    name VARCHAR(255) , 
    surname VARCHAR(255) , 
    streetaddress VARCHAR(255) , 
    city VARCHAR(255) , 
    state VARCHAR(255) , 
    statefull VARCHAR(255) , 
    zipcode VARCHAR(255) 
);
    
CREATE TABLE proceduredetails (
    proceduretype VARCHAR(255) , 
    proceduresubcode VARCHAR(255) , 
    description VARCHAR(255) , 
    price FLOAT
);

CREATE TABLE procedures(
    petid VARCHAR(255),
    proceduredate DATE,
    proceduretype VARCHAR(255),
    proceduresubcode VARCHAR(255) 
);

-- 1.

create view TopPetids as
(select petid, count(petid) as freq
from procedures
group by petid
order by freq desc limit 1);

select name from pets, TopPetids
where pets.petid = TopPetids.petid;

-- 2

create view TopSpend as
( select ownerid, sum(price) as total
	from pets join
    procedures on
    pets.petid = procedures.PetID
    join proceduredetails on
    procedures.ProcedureSubCode = proceduredetails.proceduresubcode
    and
    procedures.ProcedureType = proceduredetails.proceduretype
    group by ownerid
    order by total desc limit 1);

select * from TopSpend;

select name from owners, TopSpend
where owners.ownerid = TopSpend.ownerid;

-- 3

create view atemp as
( select ownerid, sum(price) as total, count(procedures.petid) as freq
	from pets join
    procedures on
    pets.petid = procedures.PetID
    join proceduredetails on
    procedures.ProcedureSubCode = proceduredetails.proceduresubcode
    and
    procedures.ProcedureType = proceduredetails.proceduretype
    group by ownerid
    order by total desc);

select * from atemp;

select zipcode, sum(freq) as n, sum(total) as total_price, (sum(total)/sum(freq)) as average
from atemp join owners
on atemp.ownerid = owners.ownerid
group by owners.zipcode
having zipcode = '49503';

-- 4

create view temp as
(select gender, count(gender) as total_gender from pets
where name like '%c%'
group by gender);

create view temp1 as 
(select sum(total_gender) as total from temp );

select gender, (total_gender/total) * 100 as percent
from temp, temp1;

-- 5

select stddev(age)             
from pets
where kind = 'dog';

-- 6

select max(age)
from pets
where kind = 'parrot';

-- 7

select avg(age)
from pets
where kind = 'cat';



