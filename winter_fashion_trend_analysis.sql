create database fashion_trend;
--- read database ---
use fashion_trend;
--- import csv ---
select * from winter_fashion_trends_dataset limit 10;
--- EDA data ---
describe winter_fashion_trends_dataset;
show columns from winter_fashion_trends_dataset;
select count(*) as total_row from winter_fashion_trends_dataset;
select category, count(*) as total_items
from winter_fashion_trends_dataset
group by category
order by total_items desc;
--- count data ---
select count(*) as total_records from winter_fashion_trends_dataset;
--- sum brand and category unique ---
select 
count(distinct Brand) as unique_brands,
count(distinct Category) as unique_categories
from winter_fashion_trends_dataset;
--- mean price and rating ---
SELECT
ROUND(AVG(`Price(USD)`),2) AS avg_price,
ROUND(AVG(Customer_Rating),2) AS avg_rating
FROM winter_fashion_trends_dataset;
--- top brand with score high popularity ---
select 
Brand,
round(avg(Popularity_Score),2) as avg_popularity,
round(avg(Customer_Rating),2) as avg_rating
from winter_fashion_trends_dataset
group by Brand
order by avg_popularity desc;
--- top category popular full ---
select
Category,
count(*) as item_count,
round(avg(Popularity_Score),2) as avg_popularity
from winter_fashion_trends_dataset
group by Category
order by avg_popularity desc;
--- man vs woman fashion ---
select
Gender,
round(avg(`Price(USD)`),2) as avg_price,
round(avg(Popularity_Score),2) as avg_popularity,
round(avg(Customer_Rating),2) as avg_rating
from winter_fashion_trends_dataset
group by Gender;
--- winter fashion every year ---
select
Season,
count(*) as total_items,
round(avg(`Price(USD)`),2) as avg_price,
round(avg(Popularity_Score),2) as avg_popularity
from winter_fashion_trends_dataset
group by Season
order by avg_popularity desc;
--- color is popular full ---
select
Color,
round(avg(Popularity_Score),2) as avg_popularity,
count(*) as total_items
from winter_fashion_trends_dataset
group by Color
order by avg_popularity desc;
--- most popularity style ---
select
Style,
round(avg(Popularity_Score),2) as avg_popularity,
count(*) as total_items
from winter_fashion_trends_dataset
group by Style
order by avg_popularity desc;
--- segmented by price ---
select
case
when `Price(USD)` < 50 then 'Low Range (<$50)'
when `Price(USD)` between 50 and 150 then 'Mid Range ($50-$150)'
else 'High Range (>$150)'
end as price_segment,
count(*) as total_items,
round(avg(Popularity_Score),2) as avg_popularity
from winter_fashion_trends_dataset
group by price_segment
order by avg_popularity desc;
--- trend brand by year ---
select
Brand,
Season,
round(avg(Popularity_Score),2) as avg_popularity,
count(*) as total_items
from winter_fashion_trends_dataset
group by Brand, Season
order by Brand, Season desc;
with brand_trend as (
select
Brand,
Season,
round(avg(Popularity_Score),2) as avg_popularity,
lag(round(avg(Popularity_Score),2)) over (partition by Brand order by Season) as prev_year_popularity
from winter_fashion_trends_dataset
group by Brand, Season
)
select
Brand,
Season,
avg_popularity,
prev_year_popularity,
case
when prev_year_popularity is null then 'No Data (First Year)'
when avg_popularity > prev_year_popularity then '📈 Up'
when avg_popularity < prev_year_popularity then '📉 Down'
end as Trends_Status,
round(((avg_popularity - prev_year_popularity) / prev_year_popularity) * 100, 2) AS change_percent
from brand_trend
order by Brand, Season desc;
--- correlation between price, rating and popularity ---
select
round(
(
sum(`Price(USD)`*Popularity_Score) - count(*) * avg(`Price(USD)`)*avg(Popularity_Score)
)/
sqrt(
(sum(pow(`Price(USD)`,2)) - count(*) * pow(avg(`Price(USD)`),2)) *
(sum(pow(Popularity_Score,2)) - count(*) * pow(avg(Popularity_Score),2))
),2
) as corr_price_popularity,
round(
(
sum(Customer_Rating * Popularity_Score) - count(*) * avg(Customer_Rating) * avg(Popularity_Score)
)/
sqrt(
(sum(pow(Customer_Rating,2)) - count(*) * pow(avg(Customer_Rating),2)) *
(sum(pow(Popularity_Score,2)) - count(*) * pow(avg(Popularity_Score),2))
),2
) as corr_rating_popularity
from winter_fashion_trends_dataset;
--- best brand in category ---
with avg_pop as (
select
Category,
Brand,
round(avg(Popularity_Score),2) as avg_popularity
from winter_fashion_Trends_dataset
group by Category, Brand
),
max_pop as (
select
Category,
max(avg_popularity) as max_popularity
from avg_pop
group by Category
)
select
a.Category,
a.Brand,
a.avg_popularity
from avg_pop a
join max_pop m
on a.Category = m.Category and a.avg_popularity = m.max_popularity
order by a.Category;
--- variability price ---
select
Brand,
min(`Price(USD)`) as min_price,
max(`Price(USD)`) as max_price,
round(avg(`Price(USD)`),2) as avg_price
from winter_fashion_trends_dataset
group by Brand
order by (max(`Price(USD)`) - min(`Price(USD)`)) desc;
--- color trend every year ---
select
Color,
Season,
round(avg(Popularity_Score),2) as avg_popularity
from winter_fashion_trends_dataset
group by Color, Season
order by Color, avg_popularity desc;
--- anomali popularity ---
select *
from winter_fashion_trends_dataset
where Popularity_Score > (
select avg(Popularity_Score) + 2 * stddev(Popularity_Score)
from winter_fashion_trends_dataset
);
--- distributin price ---
select
case
when `Price(USD)` < 50 then 'Low Range'
when `Price(USD)` between 50 and 150 then 'Mid Range'
else 'High Range'
end as price_segment,
round(avg(Customer_Rating),2) as avg_rating,
round(avg(Popularity_Score),2) as avg_popularity,
count(*) as total_items
from winter_fashion_trends_dataset
group by price_segment;
--- Top 5 brand in category ---
select *
from (
  select 
    Category, Brand,
    round(avg(Popularity_Score),2) as avg_popularity,
    rank() over (partition by Category order by avg(Popularity_Score) desc) as rank_in_cat
  from winter_fashion_trends_dataset
  group by Category, Brand
) ranked
where rank_in_cat <= 5;