create database bookstore;
use bookstore;

# Q1 . Top-Selling Books by Gross Sales
select b.book_name,r.gross_sales from books as b
join
ratings as r
on b.book_id = r.book_id
order by r.gross_sales desc limit 10;

# Q2 Average Rating by Genre
select b.genre,round(avg(r.book_average_rating), 2) as average_rating from books as b
join
ratings as r
on b.book_id = r.book_id
group by b.genre;

# Q3  Publishers with Highest Revenue

select publisher, total_publisher_revenue
from (
select b.publisher, sum(r.publisher_revenue) as total_publisher_revenue,
rank() over(order by sum(r.publisher_revenue) desc) as revenue_rank 
from books as b
join ratings as r
on b.book_id = r.book_id
group by b.publisher)
as t
where revenue_rank <= 5;

# Q4 High-Rated Books Published in 2012
select * from books;
select * from ratings;
select b.book_name,b.publishing_year,r.book_average_rating as avg_rating from books as b
join ratings as r
on b.book_id = r.book_id
where b.publishing_year = 2012 and r.book_average_rating >4.0
order by r.book_average_rating desc;

# Q5 Prolific Authors and Their Ratings
with author_state as (
select b.author,count(b.book_id) as book_no,round(avg(r.author_rating),2) avg_author_rating
from books as b
join ratings as r
on b.book_id=r.book_id
group by author)
select author,book_no,avg_author_rating from author_state
where book_no >1
order by avg_author_rating desc, book_no desc;

# Q6 Hidden Gems: High Rating, Low Sales
select b.book_name, r.book_average_rating, r.units_sold
from books as b
join ratings as r
on b.book_id=r.book_id
where r.book_average_rating >4 and r.units_sold <1000;

# Q7 Profit Margin per Book
select b.book_name, r.gross_sales, r.publisher_revenue, (r.gross_sales - r.publisher_revenue) as profit 
from books as b
join ratings as r
on b.book_id=r.book_id
order by profit desc;

# Q8 Most Rated English Books
select b.book_name, b.language_code, r.book_average_rating, r.book_ratings_count 
from books as b
join ratings as r
on b.book_id=r.book_id
where b.language_code ='en'
order by r.book_ratings_count desc limit 5;

# Q9 Sales by Publishing Year
select b.publishing_year, 
sum(r.units_sold) as total_unit,
sum(r.gross_sales) as gross_sales
from books as b
join ratings as r
on b.book_id=r.book_id
group by b.publishing_year
order by b.publishing_year;

# Q10  Author Rating > Book Rating
select b.book_name,b.author,r.author_rating,r.book_average_rating
from books as b
join ratings as r
on b.book_id=r.book_id
where r.author_rating > r.book_average_rating;




