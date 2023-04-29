Create database breakdownCompany;  -- creating database breakdownCompany
Use breakdownCompany; -- using the database

                                                 -- Task 1
                                                 
create table members (MemberId varchar(10) primary key , MFName varchar(20), MLName varchar(20), MLoc varchar(20), MTID int); -- creating members table
  SET FOREIGN_KEY_CHECKS = 0;   -- setting the foreign key to 0, in order to allow as to drop the table
  SET FOREIGN_KEY_CHECKS = 1;   -- setting the foreign key to 1, to create back the dependency
 
  drop table members;

create table vehicle (VehReg varchar(10) primary key, VehMake varchar(10), VehModel varchar(10), MemberID varchar(10), EngID int, MTID INT );
 drop table vehicle;
ALTER TABLE breakdowncompany.vehicle -- In order to add a foreign key, first you have to alter(change) the table
ADD CONSTRAINT MemberID              -- add a constraint
  FOREIGN KEY (MemberID)             -- adding a foreign key
  REFERENCES breakdowncompany.members (MemberID) -- In here you reference the member id from members table where is a primary key
  ON DELETE NO ACTION                -- no action will be taken on this line
  ON UPDATE NO ACTION;
  
create table engineer (EngID int primary key, EFName varchar(20), ELName varchar(20)); -- creating engineer table

create table EngVan (VanReg varchar(10) primary key, VanMake varchar(10), VanModel varchar(10), EngID int, VMileage int); -- creating EngVan table

ALTER TABLE breakdowncompany.engvan   -- same process as above - see the comments from line 5 to line 10
ADD CONSTRAINT EngID
  FOREIGN KEY (EngID)
  REFERENCES breakdowncompany.engineer (EngID)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
create table Breakdown (BDID int primary key, VehReg varchar(10), EngID int, VanReg varchar(10), BDDATE date, BDTIME time, BDLoc varchar(20)) ;
ALTER TABLE breakdowncompany.breakdown 
ADD CONSTRAINT VehReg
  FOREIGN KEY (VehReg)
  REFERENCES breakdowncompany.vehicle (VehReg)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE breakdowncompany.breakdown 
ADD CONSTRAINT VanReg
  FOREIGN KEY (VanReg)
  REFERENCES breakdowncompany.engvan (VanReg)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
                                           -- Task 2
  
  INSERT INTO members (MemberId, MFName, MLName, MLoc, MTID) values  
  ("AS001", "Richard", "Hunt", "SE9 1PT", 1 ),
  ("AS002", "Alex", "John", "NW2 9FL", 2),
  ("AS003", "Dipa", "Bonn", "SE14 3DB", 3),
  ("AS004", "ADNAN", "ROCHER", "N1 3MN", 4),
  ("AS005", "JOHN", "SMITH", "SW2 6FL", 5);
  drop table members;
  -- INSERT INTO members (MemberId, MFName, MLName, MLoc) values   -- I've inserted 3 more records, in order to be able to add 8 entries in vehicle table
 -- ("AS006", "VARSHA", "BELL", "E1 3DY"),
  -- ("AS007", "WERDA", "ROCHFELLER", "TR1 3MT"),
  -- ("AS008", "LUCIA", "STOIK", "T1 1SR");
  
  ALTER TABLE breakdowncompany.vehicle 
ADD INDEX MemberID_idx (MemberID ASC) VISIBLE;
ALTER TABLE breakdowncompany.vehicle 
ADD CONSTRAINT
 MemberID
  FOREIGN KEY (MemberID)
  REFERENCES breakdowncompany.members (MemberId)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE breakdowncompany.vehicle 
ADD INDEX MTID_idx (MTID ASC) VISIBLE;
;
ALTER TABLE breakdowncompany.vehicle 
ADD CONSTRAINT MTID
  FOREIGN KEY (MTID)
  REFERENCES breakdowncompany.mshiptype (MTID)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


  
  insert into vehicle (VehReg, VehMake , VehModel , MemberID, EngID, MTID) values  -- it will throw an error because we have only 5 primary keys in memebers table which are foreign keys
  ("YHZ5299", "PORCHE", "944", "AS001", 1, 1),                               -- in vehicle table, so we need to add 3 more entries in members table
  ("VU53BVG", "AUDI", "A4", "AS002", 2, 2),
  ("SD33DDC", "HUMMER", "H1", "AS003", 3, 3),
  ("LL99ODS", "PONTIAC", "GRAND AM", "AS004", 2, 4),
  ("RG33FGT", "FORD", "F-SERIES", "AS005", 3, 5),
  ("SS34LGF", "HONDA", "GRAND AM", "AS001", 2, 1),
  ("LL99OLS", "KIA", "NIRO", "AS002", 1, 2),
  ("LF99OPS", "BMW", "SERIES 6", "AS003", 1, 3);
  SET FOREIGN_KEY_CHECKS = 0;   -- setting the foreign key to 0, in order to allow as to drop the table
  SET FOREIGN_KEY_CHECKS = 1;   -- setting the foreign key to 1, to create back the dependency
  truncate table vehicle;
  drop table vehicle;
  
  -- delete from members where id in (AS001, AS002, AS003);  -- THIS LINE CODE WILL DELETE THE ROWS ONCE WILL INSERT THE ID VALUE
  
  -- Engineer table – 3 records
    insert into engineer (EngID, EFName, ELName) values
    (1,"Alex", "Stoica "),             
    (2,"Cleide", "Moft"),
    (3,"Glen", "Gianny");
   -- (4,"Robert", "Craft"),       -- we created 2 more entries that when we will insert records into engvan table, the primary keys from engineer table
   -- (5,"Dipa", "Pajaparti");     -- will refer to the number of foregn keys into engvan table
    
-- EngVan table – 5 records
 insert into EngVan (VanReg, VanMake, VanModel, EngID, VMileage) values  -- engID is a primary key in engineer, so here it will be a foreign key
    ( "DG7TGR", "Mercedes", "Benz",1,"11200"),
    ( "AS55TRG", "FIAT", "DUCATO",2,"21200"),
    ( "GH77YYT", "FORD", "TRANSIT",3,"22367"),
    ( "AS55TRL", "Volkswagen", "Crafter",1,"21200"),
    ( "GG43THG", "MERCEDES", "SPRINTER",2,"31400");
    
    -- Breakdown table – 12 records
   -- (BDID int primary key, VehReg varchar(10), VanReg varchar(10), BDDATE date, BDTIME time, BDLoc varchar(20))

   insert into breakdown (BDID, VehReg, EngID, VanReg, BDDATE, BDTIME, BDLoc) values  -- EngID
   (10, "YHZ5299", 3, "DG7TGR","2020-12-23","12:34:22","ND6 3SG"),      -- Have 2 breakdowns on the same day
   (11, "VU53BVG", 2, "AS55TRG","2020-12-23","08:20:21","NW9 0NE"),     -- Have 2 breakdowns on the same day    -- Have at least 3 vehicles that have broken down more than once
   (12, "SD33DDC", 1, "GH77YYT","2022-09-07","11:34:02","W4 5FF"),      -- Have 3 breakdowns in the same month
   (13, "LL99ODS", 3, "AS55TRL","2022-09-22","12:15:04","SE12 3DR"),    -- Have 3 breakdowns in the same month
   (14, "RG33FGT", 3, "GG43THG","2022-09-29","07:34:00","SW2 5GH"),     -- Have 3 breakdowns in the same month
   (15, "SS34LGF", 1, "DG7TGR","2016-01-24","05:44:56","DF4 77TG"),     -- Have at least 3 vehicles that have broken down more than once
   (16, "SS34LGF", 2, "AS55TRG","2011-11-03","10:34:32","WE4 5FZ"),     -- Have at least 3 vehicles that have broken down more than once
   (17, "LF99OPS", 1, "GH77YYT","2009-04-17","14:22:12","SD4 1SS"),     -- Have at least 3 vehicles that have broken down more than once
   (18, "LF99OPS", 3, "AS55TRG","2014-07-23","18:34:45","E3 4PO"),      -- Have at least 3 vehicles that have broken down more than once
   (19, "VU53BVG", 2, "GG43THG","2016-12-29","17:11:11","NE4 QW"),     -- Have at least 3 vehicles that have broken down more than once
   (20, "VU53BVG", 1, "DG7TGR","2018-09-09","19:46:44","NW9 6HH"),      -- Have at least 3 vehicles that have broken down more than once
   (21, "LL99ODS", 3, "AS55TRG","2020-11-25","13:34:42","NE3 5GG");     -- Have at least 3 vehicles that have broken down more than once
   
   truncate table breakdown;   -- this is a statement for removing the rows in a table as in the beginning I've inserted the wrong data
   drop table breakdown;
   
                                                 --  Task 3

   select * from members having (MLoc="SE9 1PT");-- The names of members who live in a location e.g. London using select all from memebers table having MLoc = to the loc
   
   select * from vehicle having (VehMake = "Porche");  -- All cars registered with the company e.g. all Nissan cars.   same as above
   
   select count(EngID) from engineer;   -- The number of engineers that work for the company using count function
   
   select count(MemberId) from members;   -- The number of members registered using count function
   
   SELECT *from breakdown WHERE DATE(BDDATE)>='2018-09-09'; -- select all the breakdown after a particular date
   
   SELECT *from breakdown WHERE DATE(BDDATE)>='2014-07-23' and (BDDATE)<='2020-11-25';  -- all the breakdown between 2 dates   
   
   select VehReg,count(VehReg) from breakdown where (VehReg) = 'VU53BVG'; -- using count function in order to find out the number of times a particular vehicle has broken down
   
   select VehReg,count(*) from breakdown group by VehReg having count(*) > 1;   -- The number of vehicles broken down more than once 
   
                                                     -- Task 4
                                                     
  create table MshipType(MTID int primary key, Mtype varchar(6), MPrice decimal(4, 2)); -- creating the table   - inside decimal brackets we have nr 4 which represent the 
                                                                                       -- total numbers inside the column, and nr 2 are the numbers after the .
  insert into MshipType(MTID, Mtype, MPrice) values
  (1, 'Gold', '99.99'),
  (2, 'Silver', '59.99'),
  (3, 'Bronze', '39.99');
  
                                                 -- Task 5
                                                 
   alter table members add MTID int;  -- using the alter command add the field MTID in the members table,
   
   ALTER TABLE members 
ADD INDEX MTID_idx (MTID ASC) VISIBLE;  -- set it to foreign key and allow null.
ALTER TABLE members 
ADD CONSTRAINT MTID
  FOREIGN KEY (MTID)
  REFERENCES breakdowncompany.mshiptype (MTID)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  alter table vehicle add MTID int;
  -- ALTER table vehicle ADD MTID int not null;                             

-- Then using the update command assign a MTID to each vehicle. 
UPDATE vehicle SET MTID = 1 WHERE VehReg = 'YHZ5299';
UPDATE vehicle SET MTID = 2 WHERE VehReg = 'VU53BVG';
UPDATE vehicle SET MTID = 3 WHERE VehReg = 'SD33DDC';
UPDATE vehicle SET MTID = 4 WHERE VehReg = 'LL99ODS';
UPDATE vehicle SET MTID = 5 WHERE VehReg = 'RG33FGT';
UPDATE vehicle SET MTID = 6 WHERE VehReg = 'SS34LGF';
UPDATE vehicle SET MTID = 7 WHERE VehReg = 'LL99OLS';
UPDATE vehicle SET MTID = 8 WHERE VehReg = 'LF99OPS';
  
  
											-- Task 6
                                                    
  -- 6.1 All the vehicles a member owns.   
   select members.MemberID, vehicle.VehReg, vehicle.VehMake, vehicle.VehModel
   from members
   inner join vehicle
   on members.memberID = vehicle.memberID
   where members.memberID = 'AS002';
   
   -- The number of vehicles for each member in descending order.
   


-- 6.2 The number of vehicles for each member in descending order.

select vehicle.MemberID, members.MFName, members.MLName, count(vehicle.MemberID) as NoOfVehiclesOwned
from vehicle
inner join members on vehicle.MemberID = members.MemberID
group by vehicle.MemberID
order by NoOfVehiclesOwned desc;

-- 6.3 The number of vans driven by a particular engineer.

select engvan.VanMake, engineer.EngID, engineer.EFName, engineer.ELName, count(*) as NoOfVans
from engvan
inner JOIN engineer on engvan.EngID = engineer.EngID where engineer.EngID = 1
group by engvan.VanMake, engineer.EngID, engineer.EFName, engineer.ELName
order by NoOfVans;

-- 6.4 All vehicles that have broken down in a particular location along with member details.
select breakdown.VehReg, BDID, BDDATE, BDTIME, BDLoc, members.MemberId, MFName, MLName, MLoc
from breakdown
inner join vehicle on vehicle.VehReg = breakdown.VehReg 
inner join members on members.MemberId = vehicle.MemberID where BDLoc = 'WE4 5FZ'; 

-- 6.5 A list of all vehicles that broke down along with the member details and the engineer who attended

select breakdown.VehReg, BDID, BDDATE, BDTIME, members.MemberId, MFName, MLName, MLoc, engineer.EngID, EFName, ELName
from breakdown
inner join vehicle on vehicle.VehReg = breakdown.VehReg 
inner join members on members.MemberId = vehicle.MemberID 
inner join engineer on engineer.EngID = breakdown.EngID; 



-- 6.6	A list of all breakdown along with member and engineer details between two dates.

select * from breakdown                                   -- selecting everithing from breakdown
inner join vehicle on vehicle.VehReg = breakdown.VehReg   -- joinning 2 tables where the vehreg match
inner join members on members.MemberId = vehicle.MemberID -- joinning the third table where the member id match
inner join engineer on engineer.EngID = breakdown.EngID   -- joinning the forth table
where BDDATE < '2020-12-23'and BDDATE > '2014-07-23';     -- using where clause in order to retrive the desired data

-- 6.7	A further 3 relational queries of your choice that are meaningful to the company.
-- a
select members.MemberId, MFName, MLName, VehMake, VehModel  -- selecting all members along with their cars
 from members
 inner join vehicle on vehicle.MemberID = members.MemberId; 
 
-- b
select vehicle.VehMake, engineer.EngID, engineer.EFName, engineer.ELName, count(*) as NoOfVeh  -- The number of vehicles driven by a particular engineer.
from vehicle
inner JOIN engineer on vehicle.EngID = engineer.EngID where engineer.EngID = 2
group by vehicle.VehMake, engineer.EngID, engineer.EFName, engineer.ELName
order by NoOfVeh;

-- c 
-- All the mship type belonging to the members
select mshiptype.MTID, Mtype, Mprice, members.MemberId, MFName, MLName, MLoc
from mshiptype
inner join members on members.MTID = mshiptype.MTID;
-- select  mship.MT_id, MT_type, MP_price, members.member_id, MFName, MLName, MLoc
-- from mship 
-- inner join members on members.MT_id = mship.MT_id;

-- Task 7
-- minmaxsumavg database created separate as required  - task done

-- task 8
-- 1) For if a member owns more than one vehicle than it has a multi-car policy	
-- 2)	The number of times each car broken down
-- a.	If more than twice then next premium to be increased by 10%
-- b.	If twice then increase by 5%
-- c.	If once then no increase
-- d.	If not broken down then 10% discount

-- task 8.1 For if a member owns more than one vehicle than it has a multi-car policy	
select members.MemberId, MFName, MLName, vehicle.VehReg
from members
inner join vehicle on members.MemberId = vehicle.MemberID;
-- SELECT 
--     COUNT(DISTINCT VehReg) AS vehicle_count,
--     MemberID
-- FROM 
--     vehicle
-- WHERE 
--     MemberID = MemberID
-- GROUP BY 
--     MemberID
-- HAVING 
--     vehicle_count > 1;
    
 -- 8.2    The number of times each car broken down  
 -- I decided to use a case statement, which will check the count function of vehicles for each member and assign the policy type
 select members.MemberId, MFName, MLName, count(vehicle.VehReg),
   case 
     when count(vehicle.VehReg) = 1 then 'single vehicle car policy '
     else 'multivehicle car policy'
   end as policyType 
from members
inner join vehicle on members.MemberId = vehicle.MemberID
group by members.MemberId;
 
-- SELECT VehReg, COUNT(*) AS breakdown_count
-- FROM breakdown
-- GROUP BY VehReg;    
-- -- a. a.	If more than twice then next premium to be increased by 10%
 UPDATE vehicle SET insurancePolicy = insurancePolicy * 1.1 WHERE VehReg > 2;
select vehicle.VehReg, breakdown.BDID
from vehicle
left join breakdown on vehicle.VehReg = breakdown.VehReg;
-- -- b.	If twice then increase by 5%
-- UPDATE vehicle SET insurancePolicy = insurancePolicy * 1.05 WHERE breakdown_count = 2;
select vehicle.VehReg, count(breakdown.BDID),
case
  when count(breakdown.BDID) > 2 then 'plus 10%'
  when count(breakdown.BDID) = 2 then 'plus 5%'
  when count(breakdown.BDID) = 1 then 'no increase'
  else 'discount of 10%'
 end as policyAdjustment
from vehicle
left join breakdown on vehicle.VehReg = breakdown.VehReg
group by vehicle.VehReg;
-- -- c.	If once then no increase
-- -- No update needed

-- -- d.	If not broken down then 10% discount
--  UPDATE vehicle SET insurancePolicy = insurancePolicy* 0.9 WHERE breakdown_count = 0;





 
 
 










   
                                                  

 
  
  
  

 
 
   
   
    
    
    
    
  
  
  


  
  
 

