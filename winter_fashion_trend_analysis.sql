-- =========================================================
-- Winter Fashion Trend Analysis
-- Versi ini sudah disesuaikan supaya jalan di SQLite Online
-- (sqliteonline.com). Import CSV kamu dulu jadi tabel bernama
-- 'Winter_Fashion_Trends_Dataset' sebelum menjalankan query ini.
-- =========================================================

select * from Winter_Fashion_Trends_Dataset limit 10;

-- SQLite tidak punya DESCRIBE / SHOW COLUMNS, ganti dengan PRAGMA
PRAGMA table_info(Winter_Fashion_Trends_Dataset);

select count(*) as total_row from Winter_Fashion_Trends_Dataset;

select category, count(*) as total_items
from Winter_Fashion_Trends_Dataset
group by category
order by total_items desc;

select count(*) as total_records from Winter_Fashion_Trends_Dataset;

select
count(distinct Brand) as unique_brands,
count(distinct Category) as unique_categories
from Winter_Fashion_Trends_Dataset;

SELECT
ROUND(AVG(`Price(USD)`),2) AS avg_price,
ROUND(AVG(Customer_Rating),2) AS avg_rating
FROM Winter_Fashion_Trends_Dataset;

select
Brand,
round(avg(Popularity_Score),2) as avg_popularity,
round(avg(Customer_Rating),2) as avg_rating
from Winter_Fashion_Trends_Dataset
group by Brand
order by avg_popularity desc;

select
Category,
count(*) as item_count,
round(avg(Popularity_Score),2) as avg_popularity
from Winter_Fashion_Trends_Dataset
group by Category
order by avg_popularity desc;

select
Gender,
round(avg(`Price(USD)`),2) as avg_price,
round(avg(Popularity_Score),2) as avg_popularity,
round(avg(Customer_Rating),2) as avg_rating
from Winter_Fashion_Trends_Dataset
group by Gender;

select
Season,
count(*) as total_items,
round(avg(`Price(USD)`),2) as avg_price,
round(avg(Popularity_Score),2) as avg_popularity
from Winter_Fashion_Trends_Dataset
group by Season
order by avg_popularity desc;

select
Color,
round(avg(Popularity_Score),2) as avg_popularity,
count(*) as total_items
from Winter_Fashion_Trends_Dataset
group by Color
order by avg_popularity desc;

select
Style,
round(avg(Popularity_Score),2) as avg_popularity,
count(*) as total_items
from Winter_Fashion_Trends_Dataset
group by Style
order by avg_popularity desc;

select
case
when `Price(USD)` < 50 then 'Low Range (<$50)'
when `Price(USD)` between 50 and 150 then 'Mid Range ($50-$150)'
else 'High Range (>$150)'
end as price_segment,
count(*) as total_items,
round(avg(Popularity_Score),2) as avg_popularity
from Winter_Fashion_Trends_Dataset
group by price_segment
order by avg_popularity desc;

select
Brand,
Season,
round(avg(Popularity_Score),2) as avg_popularity,
count(*) as total_items
from Winter_Fashion_Trends_Dataset
group by Brand, Season
order by Brand, Season desc;

with brand_trend as (
select
Brand,
Season,
round(avg(Popularity_Score),2) as avg_popularity,
lag(round(avg(Popularity_Score),2)) over (partition by Brand order by Season) as prev_year_popularity
from Winter_Fashion_Trends_Dataset
group by Brand, Season
)
select
Brand,
Season,
avg_popularity,
prev_year_popularity,
case
when prev_year_popularity is null then 'No Data (First Year)'
when avg_popularity > prev_year_popularity then 'Up'
when avg_popularity < prev_year_popularity then 'Down'
end as Trends_Status,
round(((avg_popularity - prev_year_popularity) / prev_year_popularity) * 100, 2) AS change_percent
from brand_trend
order by Brand, Season desc;

-- pow(x,2) diganti (x*x) karena SQLite tidak selalu punya fungsi POW
select
round(
(
sum(`Price(USD)`*Popularity_Score) - count(*) * avg(`Price(USD)`)*avg(Popularity_Score)
)/
sqrt(
(sum(`Price(USD)`*`Price(USD)`) - count(*) * (avg(`Price(USD)`)*avg(`Price(USD)`))) *
(sum(Popularity_Score*Popularity_Score) - count(*) * (avg(Popularity_Score)*avg(Popularity_Score)))
),2
) as corr_price_popularity,
round(
(
sum(Customer_Rating * Popularity_Score) - count(*) * avg(Customer_Rating) * avg(Popularity_Score)
)/
sqrt(
(sum(Customer_Rating*Customer_Rating) - count(*) * (avg(Customer_Rating)*avg(Customer_Rating))) *
(sum(Popularity_Score*Popularity_Score) - count(*) * (avg(Popularity_Score)*avg(Popularity_Score)))
),2
) as corr_rating_popularity
from Winter_Fashion_Trends_Dataset;

with avg_pop as (
select
Category,
Brand,
round(avg(Popularity_Score),2) as avg_popularity
from Winter_Fashion_Trends_Dataset
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

select
Brand,
min(`Price(USD)`) as min_price,
max(`Price(USD)`) as max_price,
round(avg(`Price(USD)`),2) as avg_price
from Winter_Fashion_Trends_Dataset
group by Brand
order by (max(`Price(USD)`) - min(`Price(USD)`)) desc;

select
Color,
Season,
round(avg(Popularity_Score),2) as avg_popularity
from Winter_Fashion_Trends_Dataset
group by Color, Season
order by Color, avg_popularity desc;

-- stddev() tidak ada di SQLite, dihitung manual: sqrt(E[x^2] - (E[x])^2)
select *
from Winter_Fashion_Trends_Dataset
where Popularity_Score > (
    select avg(Popularity_Score) + 2 * sqrt(
        avg(Popularity_Score*Popularity_Score) - avg(Popularity_Score)*avg(Popularity_Score)
    )
    from Winter_Fashion_Trends_Dataset
);

select
case
when `Price(USD)` < 50 then 'Low Range'
when `Price(USD)` between 50 and 150 then 'Mid Range'
else 'High Range'
end as price_segment,
round(avg(Customer_Rating),2) as avg_rating,
round(avg(Popularity_Score),2) as avg_popularity,
count(*) as total_items
from Winter_Fashion_Trends_Dataset
group by price_segment;

select *
from (
  select
    Category, Brand,
    round(avg(Popularity_Score),2) as avg_popularity,
    rank() over (partition by Category order by avg(Popularity_Score) desc) as rank_in_cat
  from Winter_Fashion_Trends_Dataset
  group by Category, Brand
) ranked
where rank_in_cat <= 5;
