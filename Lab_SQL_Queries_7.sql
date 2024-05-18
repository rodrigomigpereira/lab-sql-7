## Lab | SQL Queries 7
## In this lab, you will be using the Sakila database of movie rentals.

use sakila; ## Use the database sakila 

## Instructions:
## In the table actor, which are the actors whose last names are not repeated? 
## For example if you would sort the data in the table actor by last_name, you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. 
## These three actors have the same last name. So we do not want to include this last name in our output. Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list.

select * from actor;
select count(*) from actor; ## There are 200 names on this table actor

select distinct last_name
	from actor;
    
select count(distinct last_name) from actor;  ## There are 121 distinct names on this table actor

select last_name, group_concat(first_name) AS first_names
	from actor
		group by last_name
			having count(*) = 1;  ## HAVING clause was added to SQL because the WHERE keyword cannot be used with aggregate functions. https://www.w3schools.com/sql/sql_having.asp

## Which last names appear more than once? We would use the same logic as in the previous question but this time we want to include the last names of the actors where the last name was present more than once

select last_name, group_concat(first_name) AS first_names
	from actor
		group by last_name
			having count(*) > 1;   
    
## Using the rental table, find out how many rentals were processed by each employee.

select distinct staff_id from rental;  ## We see that there are only two staff_id (1 and 2)

select staff_id, count(staff_id)
	from rental
		group by staff_id;  ## When we group by the number of rentals by staff, we see that the employee 1 processed 8041 rentals and the employee 2 processed 8004 rentals

## Using the film table, find out how many films were released each year.

select release_year, count(release_year)
	from film
		group by release_year;

## Using the film table, find out for each rating how many films were there.

select rating, count(rating)
	from film
		group by rating;

## What is the mean length of the film for each rating type. Round off the average lengths to two decimal places

select * from film;

select rating, count(rating), avg(length)
	from film
		group by rating
			order by avg(length) ASC;
            
select rating, count(rating), round(avg(length),2)  ## Adjusting the average to consider only two decimal places
	from film
		group by rating
			order by round(avg(length),2) ASC;

## Which kind of movies (rating) have a mean duration of more than two hours?

select * from film;

select rating, count(rating), round(avg(length),2)  
	from film
		group by rating
			having round(avg(length),2) > 120
			order by round(avg(length),2) ASC;  ## the result is that only the rating PG-13 has average length higher than two hours (120 minutes)