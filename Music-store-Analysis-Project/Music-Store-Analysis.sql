
-- Senior most employee based on the job title-- 

select * from employee
order by levels desc 
limit 1;

-- Which countries has the most invoices-- 
select count(*) as c , billing_country from invoice group by billing_country
order by c desc;

-- what are the top 3 values of invoices -- 
select * from invoice order by total desc limit 3 ;

/*  Which city has the best customers? We would like to throw a promotional Music
Festival in the city we made the most money. Write a query that returns one city that 
has the highest sum of invoice totals. Return both the city name & sum of all invoice 
totals*/ 


select sum(total) as total_invoice , billing_city  from invoice group by billing_city
 order by total_invoice desc limit 1 ;
 
 /*Who is the best customer? The customer who has spent the most money will be 
declared the best customer. Write a query that returns the person who has spent the 
most money*/


select  customer.customer_id, first_name, last_name , 
sum(invoice.total) as total from customer
join invoice on customer.customer_id = invoice.customer_id 
group by customer.customer_id,first_name, last_name order by total desc limit 1;

/*Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A*/

SELECT DISTINCT email,first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY email;

/*Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands*/

SELECT artist.artist_id, artist.name, COUNT(artist.artist_id) AS number_of_songs 
FROM track 
JOIN album2 ON album2.album_id = track.album_id 
JOIN artist ON artist.artist_id = album2.artist_id 
JOIN genre ON genre.genre_id = track.genre_id 
WHERE genre.name LIKE 'Rock' 
GROUP BY artist.artist_id, artist.name 
ORDER BY number_of_songs DESC 
LIMIT 10;

/*Return all the track names that have a song length longer than the average song length. Return the Name and Milliseconds for each track.
 Order by the song length with the longest songs listed first.*/
 
 SELECT name,milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS avg_track_length
	FROM track )
ORDER BY milliseconds DESC;

 























