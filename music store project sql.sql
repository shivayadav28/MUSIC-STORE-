create database music_store;
use music_store;
select * from album;

#1.who is the senior most employee based on job title.
select * from employee
order by levels desc
limit 1;

#2.which countries have the most invoices.
select billing_country,count(*)as total_billing 
from invoice
group by billing_country
order by billing_country desc;

#3.what are top 3 values of total invoices.
select billing_country,count(*) as total_billing
from invoice
group by billing_country
order by total_billing desc
limit 3;

/*
#4.which city has the best customer? we would like to throw a promotional music festival in the city we made the most money.
write a query that returns one city that has the highest sum of invoice totals.
retuwn both the city name and sum of all invoice totals.*/
select billing_city,count(total) as total_invoice
from invoice
group by billing_city
order by total_invoice desc
limit 1;

/*
4.who is the best customer ?The customer who has spent the most money will be declared the best customer .
write a query that return the person who has spent the most money.*/
select customer.customer_id,max(customer.first_name)as first_name,max(customer.last_name)as last_name,sum(invoice.total) as total
from customer 
inner join invoice  on customer.customer_id=invoice.customer_id
group by customer.customer_id
order by total desc
limit 1;

/*
5.write a query to return the email,first name,last name & genre of all rock music listeners.
return your list order alphabitacally by email starting with A.*/
select first_name,last_name,email
from customer
inner join invoice on customer.customer_id=invoice.customer_id
inner join invoice_line on invoice.invoice_id=invoice_line.invoice_id
where track_id in(
	select track_id from track
    join genre on track.genre_id=genre.genre_id
    where genre.name like 'rock'
 )
 order by email;
 
 /*
 6.let's invite the artists who have written the most rock music in our dataset .
 write a query that returns the Artist name and total track count of the top 10 rock bands.*/
 select artist.artist_id,max(artist.name)as artist_name,count(artist.artist_id)as number_of_songs
 from track
 join album on album.﻿album_id=track.album_id
 join artist on artist.artist_id=album.artist_id
 join genre on genre.genre_id=track.genre_id
 where genre.name like 'rock'
 group by artist.artist_id
order by number_of_songs desc
limit 10;

/*
7.return all the track names that have a song length longer than the average song length .
return the names and millisecond for each track .order by the song length with the longest songs listed first
*/
select name,milliseconds
from track
where milliseconds>(
      select avg(milliseconds) as avg_track_len
      from track)
order by milliseconds desc;      

    