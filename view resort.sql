/*service_dim
-----------------
Service_id
Serice_nameservice_line
Resort_name
Country_name      
*/
select * from service_dim2;
select * from resort1;
select * from service;
select * from service_line;
select * from reservation;
select * from country1;
select * from city2;

create view service_dim as 
select s.service_id,s.service_name,s.sl_id,re.resort,re.country_id,co.country from service s
inner join service_line sl on s.sl_id=sl.sl_id
inner join resort1 re on re.resort_id=sl.resort_id
inner join country1 co on co.country_id=re.country_id;

select * from service_dim;
/*Customer_dim
--------------------
Cust_id
Cust_f_name
Cust_l_name
Age_range
Phone_number
Address
City_name
Region_name
Country_name
*/
select * from age_group;
select * from customer2;
select * from region;
select * from city2;
select * from country1;
create view customer_dim as 
select c.cust_id,c.first_name,c.last_name,c.phone_no,c.address,ct.city,rg.region,co.country from customer2 c
inner join age_group ag on ag.age_group_id=c.age_group_id
inner join city2 ct on ct.city_id=c.city_id
inner join region rg on rg.region_id=ct.region_id
inner join country1 co on co.country_id=rg.country_id;
select * from customer_dim;
/*Reservation_fact
----------------------
Res_id
Cust_id
Res_date
Service_id
Res_days
Number_of_guests
Price_of_serviceReservation_revenue
*/
select * from reservation;
select * from reservation_line;
select * from service;

create view reservation_fact as 
select r.res_id,r.cust_id,r.res_date,s.service_id,rl.res_days,rl.future_guests,s.price,(select sum(price) from service) revenue from reservation r
inner join reservation_line rl on r.res_id=rl.res_id
inner join service s on s.service_id=rl.service_id;
select * from reservation_fact;
drop view reservation_fact;

select * from reservation_fact;
create materialized view reser_fact as select * from reservation_fact;
select * from  reser_fact;

/*Calendar_dim
----------------------
Cal_date
Cal_week
Cal_day
Cal_month
Cal_quarter
Cal_year*/
create view calender_dim as select res_date cal_date,to_char(res_date,'w')cal_week ,to_char(res_date,'Day') cal_day,
to_char(res_date,'month') cal_month,to_char(res_date,'q') cal_quarter,to_char(res_date,'yyyy') cal_yyyy,to_char(res_date,'year') cal_year from reservation;
select * from calender_dim;
drop view calender_dim;

