# Hasil Query — Winter Fashion Trend Analysis

### 1. Preview data (10 baris pertama)

```sql
select * from Winter_Fashion_Trends_Dataset limit 10;
```

| ID | Brand | Category | Color | Material | Style | Gender | Season | Price(USD) | Popularity_Score | Customer_Rating | Trend_Status |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | Adidas | Gloves | Brown | Polyester | Streetwear | Women | Winter 2025 | 244.06 | 6 | 4.9 | Trending |
| 2 | Gucci | Gloves | Red | Leather | Sporty | Men | Winter 2023 | 366.73 | 8.8 | 3.3 | Trending |
| 3 | H&M | Coat | Brown | Fleece | Streetwear | Unisex | Winter 2025 | 741.55 | 4.8 | 3.5 | Trending |
| 4 | North Face | Coat | Blue | Cashmere | Formal | Men | Winter 2024 | 116.09 | 7.5 | 3.1 | Outdated |
| 5 | Mango | Thermal | Blue | Cashmere | Formal | Unisex | Winter 2025 | 193.16 | 7.8 | 4.3 | Outdated |
| 6 | Uniqlo | Thermal | Black | Fleece | Formal | Unisex | Winter 2025 | 699.85 | 1.7 | 4.2 | Outdated |
| 7 | Uniqlo | Coat | Gray | Fleece | Casual | Men | Winter 2025 | 497.79 | 9.7 | 3 | Trending |
| 8 | Mango | Sweater | Cream | Cotton | Streetwear | Unisex | Winter 2025 | 579.37 | 6.6 | 3.8 | Outdated |
| 9 | Gucci | Gloves | Brown | Cotton | Casual | Unisex | Winter 2024 | 315.96 | 6.2 | 2.8 | Outdated |
| 10 | Mango | Scarf | Maroon | Leather | Luxury | Unisex | Winter 2023 | 468.58 | 2.5 | 4.9 | Classic |

### 2. Struktur tabel (PRAGMA table_info)

```sql
PRAGMA table_info(Winter_Fashion_Trends_Dataset);
```

| cid | name | type | notnull | dflt_value | pk |
|---|---|---|---|---|---|
| 0 | ID | INTEGER | 0 |  | 0 |
| 1 | Brand | TEXT | 0 |  | 0 |
| 2 | Category | TEXT | 0 |  | 0 |
| 3 | Color | TEXT | 0 |  | 0 |
| 4 | Material | TEXT | 0 |  | 0 |
| 5 | Style | TEXT | 0 |  | 0 |
| 6 | Gender | TEXT | 0 |  | 0 |
| 7 | Season | TEXT | 0 |  | 0 |
| 8 | Price(USD) | REAL | 0 |  | 0 |
| 9 | Popularity_Score | REAL | 0 |  | 0 |
| 10 | Customer_Rating | REAL | 0 |  | 0 |
| 11 | Trend_Status | TEXT | 0 |  | 0 |

### 3. Total baris data

```sql
select count(*) as total_row from Winter_Fashion_Trends_Dataset;
```

| total_row |
|---|
| 150 |

### 4. Jumlah item per kategori

```sql
select category, count(*) as total_items
from Winter_Fashion_Trends_Dataset
group by category
order by total_items desc;
```

| Category | total_items |
|---|---|
| Scarf | 23 |
| Thermal | 19 |
| Gloves | 18 |
| Sweater | 17 |
| Jacket | 14 |
| Coat | 14 |
| Beanie | 12 |
| Hoodie | 11 |
| Cardigan | 11 |
| Boots | 11 |

### 5. Total records (duplikat cek)

```sql
select count(*) as total_records from Winter_Fashion_Trends_Dataset;
```

| total_records |
|---|
| 150 |

### 6. Jumlah brand & kategori unik

```sql
select
count(distinct Brand) as unique_brands,
count(distinct Category) as unique_categories
from Winter_Fashion_Trends_Dataset;
```

| unique_brands | unique_categories |
|---|---|
| 10 | 10 |

### 7. Rata-rata harga & rating

```sql
SELECT
ROUND(AVG(`Price(USD)`),2) AS avg_price,
ROUND(AVG(Customer_Rating),2) AS avg_rating
FROM Winter_Fashion_Trends_Dataset;
```

| avg_price | avg_rating |
|---|---|
| 443.11 | 3.8 |

### 8. Rata-rata popularitas & rating per brand

```sql
select
Brand,
round(avg(Popularity_Score),2) as avg_popularity,
round(avg(Customer_Rating),2) as avg_rating
from Winter_Fashion_Trends_Dataset
group by Brand
order by avg_popularity desc;
```

| Brand | avg_popularity | avg_rating |
|---|---|---|
| Mango | 6.53 | 3.74 |
| Zara | 6.48 | 3.72 |
| Nike | 6.46 | 3.54 |
| Adidas | 6.27 | 3.96 |
| North Face | 5.85 | 3.73 |
| Levi's | 5.83 | 3.45 |
| Gucci | 5.64 | 3.66 |
| H&M | 5.25 | 4.07 |
| Prada | 4.69 | 3.96 |
| Uniqlo | 4.61 | 4.07 |

### 9. Rata-rata popularitas per kategori

```sql
select
Category,
count(*) as item_count,
round(avg(Popularity_Score),2) as avg_popularity
from Winter_Fashion_Trends_Dataset
group by Category
order by avg_popularity desc;
```

| Category | item_count | avg_popularity |
|---|---|---|
| Boots | 11 | 7.06 |
| Sweater | 17 | 6.58 |
| Coat | 14 | 6.2 |
| Gloves | 18 | 6.02 |
| Beanie | 12 | 5.97 |
| Scarf | 23 | 5.48 |
| Jacket | 14 | 5.34 |
| Thermal | 19 | 5.16 |
| Hoodie | 11 | 4.99 |
| Cardigan | 11 | 4.95 |

### 10. Perbandingan Men vs Women vs Unisex

```sql
select
Gender,
round(avg(`Price(USD)`),2) as avg_price,
round(avg(Popularity_Score),2) as avg_popularity,
round(avg(Customer_Rating),2) as avg_rating
from Winter_Fashion_Trends_Dataset
group by Gender;
```

| Gender | avg_price | avg_popularity | avg_rating |
|---|---|---|---|
| Men | 436.21 | 5.85 | 3.58 |
| Unisex | 434.59 | 6.4 | 3.81 |
| Women | 458.68 | 4.99 | 3.99 |

### 11. Tren per musim (Season)

```sql
select
Season,
count(*) as total_items,
round(avg(`Price(USD)`),2) as avg_price,
round(avg(Popularity_Score),2) as avg_popularity
from Winter_Fashion_Trends_Dataset
group by Season
order by avg_popularity desc;
```

| Season | total_items | avg_price | avg_popularity |
|---|---|---|---|
| Winter 2023 | 42 | 428.96 | 5.84 |
| Winter 2024 | 52 | 418.97 | 5.79 |
| Winter 2025 | 56 | 476.13 | 5.68 |

### 12. Popularitas per warna

```sql
select
Color,
round(avg(Popularity_Score),2) as avg_popularity,
count(*) as total_items
from Winter_Fashion_Trends_Dataset
group by Color
order by avg_popularity desc;
```

| Color | avg_popularity | total_items |
|---|---|---|
| White | 6.42 | 14 |
| Gray | 6.15 | 15 |
| Red | 6.14 | 14 |
| Cream | 6.14 | 12 |
| Blue | 5.76 | 9 |
| Brown | 5.67 | 20 |
| Beige | 5.57 | 24 |
| Green | 5.53 | 10 |
| Black | 5.44 | 21 |
| Maroon | 4.94 | 11 |

### 13. Popularitas per gaya (Style)

```sql
select
Style,
round(avg(Popularity_Score),2) as avg_popularity,
count(*) as total_items
from Winter_Fashion_Trends_Dataset
group by Style
order by avg_popularity desc;
```

| Style | avg_popularity | total_items |
|---|---|---|
| Streetwear | 6.11 | 32 |
| Sporty | 6.08 | 34 |
| Casual | 5.95 | 22 |
| Formal | 5.62 | 32 |
| Luxury | 5.05 | 30 |

### 14. Segmentasi harga (Low/High Range)

```sql
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
```

| price_segment | total_items | avg_popularity |
|---|---|---|
| High Range (>$150) | 130 | 5.83 |
| Mid Range ($50-$150) | 19 | 5.34 |
| Low Range (<$50) | 1 | 4.9 |

### 15. Popularitas brand per musim

```sql
select
Brand,
Season,
round(avg(Popularity_Score),2) as avg_popularity,
count(*) as total_items
from Winter_Fashion_Trends_Dataset
group by Brand, Season
order by Brand, Season desc;
```

| Brand | Season | avg_popularity | total_items |
|---|---|---|---|
| Adidas | Winter 2025 | 4.85 | 4 |
| Adidas | Winter 2024 | 7.55 | 4 |
| Adidas | Winter 2023 | 6.55 | 2 |
| Gucci | Winter 2025 | 6.36 | 5 |
| Gucci | Winter 2024 | 4.64 | 5 |
| Gucci | Winter 2023 | 6 | 4 |
| H&M | Winter 2025 | 5.84 | 7 |
| H&M | Winter 2024 | 5.87 | 3 |
| H&M | Winter 2023 | 4.06 | 5 |
| Levi's | Winter 2025 | 5.72 | 4 |
| Levi's | Winter 2024 | 2.6 | 1 |
| Levi's | Winter 2023 | 7.03 | 3 |
| Mango | Winter 2025 | 6.4 | 11 |
| Mango | Winter 2024 | 5.86 | 8 |
| Mango | Winter 2023 | 7.65 | 6 |
| Nike | Winter 2025 | 5.9 | 2 |
| Nike | Winter 2024 | 6.14 | 7 |
| Nike | Winter 2023 | 7.3 | 4 |
| North Face | Winter 2025 | 6.44 | 7 |
| North Face | Winter 2024 | 6.5 | 8 |
| North Face | Winter 2023 | 4 | 5 |
| Prada | Winter 2025 | 5 | 7 |
| Prada | Winter 2024 | 4.97 | 6 |
| Prada | Winter 2023 | 3.43 | 3 |
| Uniqlo | Winter 2025 | 5.01 | 7 |
| Uniqlo | Winter 2024 | 4.15 | 4 |
| Uniqlo | Winter 2023 | 4.4 | 5 |
| Zara | Winter 2025 | 2.9 | 2 |
| Zara | Winter 2024 | 6.52 | 6 |
| Zara | Winter 2023 | 7.88 | 5 |

### 16. Tren naik/turun brand antar musim (window function)

```sql
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
```

| Brand | Season | avg_popularity | prev_year_popularity | Trends_Status | change_percent |
|---|---|---|---|---|---|
| Adidas | Winter 2025 | 4.85 | 7.55 | Down | -35.76 |
| Adidas | Winter 2024 | 7.55 | 6.55 | Up | 15.27 |
| Adidas | Winter 2023 | 6.55 |  | No Data (First Year) |  |
| Gucci | Winter 2025 | 6.36 | 4.64 | Up | 37.07 |
| Gucci | Winter 2024 | 4.64 | 6 | Down | -22.67 |
| Gucci | Winter 2023 | 6 |  | No Data (First Year) |  |
| H&M | Winter 2025 | 5.84 | 5.87 | Down | -0.51 |
| H&M | Winter 2024 | 5.87 | 4.06 | Up | 44.58 |
| H&M | Winter 2023 | 4.06 |  | No Data (First Year) |  |
| Levi's | Winter 2025 | 5.72 | 2.6 | Up | 120 |
| Levi's | Winter 2024 | 2.6 | 7.03 | Down | -63.02 |
| Levi's | Winter 2023 | 7.03 |  | No Data (First Year) |  |
| Mango | Winter 2025 | 6.4 | 5.86 | Up | 9.22 |
| Mango | Winter 2024 | 5.86 | 7.65 | Down | -23.4 |
| Mango | Winter 2023 | 7.65 |  | No Data (First Year) |  |
| Nike | Winter 2025 | 5.9 | 6.14 | Down | -3.91 |
| Nike | Winter 2024 | 6.14 | 7.3 | Down | -15.89 |
| Nike | Winter 2023 | 7.3 |  | No Data (First Year) |  |
| North Face | Winter 2025 | 6.44 | 6.5 | Down | -0.92 |
| North Face | Winter 2024 | 6.5 | 4 | Up | 62.5 |
| North Face | Winter 2023 | 4 |  | No Data (First Year) |  |
| Prada | Winter 2025 | 5 | 4.97 | Up | 0.6 |
| Prada | Winter 2024 | 4.97 | 3.43 | Up | 44.9 |
| Prada | Winter 2023 | 3.43 |  | No Data (First Year) |  |
| Uniqlo | Winter 2025 | 5.01 | 4.15 | Up | 20.72 |
| Uniqlo | Winter 2024 | 4.15 | 4.4 | Down | -5.68 |
| Uniqlo | Winter 2023 | 4.4 |  | No Data (First Year) |  |
| Zara | Winter 2025 | 2.9 | 6.52 | Down | -55.52 |
| Zara | Winter 2024 | 6.52 | 7.88 | Down | -17.26 |
| Zara | Winter 2023 | 7.88 |  | No Data (First Year) |  |

### 17. Korelasi price-popularity & rating-popularity

```sql
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
```

| corr_price_popularity | corr_rating_popularity |
|---|---|
| -0.04 | -0.08 |

### 18. Brand terpopuler per kategori

```sql
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
```

| Category | Brand | avg_popularity |
|---|---|---|
| Beanie | Zara | 8.43 |
| Boots | Levi's | 9.5 |
| Cardigan | Levi's | 9.6 |
| Coat | North Face | 7.88 |
| Gloves | Adidas | 7.7 |
| Hoodie | Uniqlo | 8.3 |
| Jacket | Adidas | 9.2 |
| Scarf | Zara | 10 |
| Sweater | Mango | 8.32 |
| Thermal | Zara | 7.7 |

### 19. Variabilitas harga per brand (min/max/avg)

```sql
select
Brand,
min(`Price(USD)`) as min_price,
max(`Price(USD)`) as max_price,
round(avg(`Price(USD)`),2) as avg_price
from Winter_Fashion_Trends_Dataset
group by Brand
order by (max(`Price(USD)`) - min(`Price(USD)`)) desc;
```

| Brand | min_price | max_price | avg_price |
|---|---|---|---|
| Zara | 63.68 | 779.42 | 402.76 |
| Prada | 79.86 | 788.03 | 437.88 |
| Mango | 30.07 | 737.02 | 440.22 |
| Nike | 77.51 | 782.43 | 373.65 |
| Uniqlo | 52.28 | 747.33 | 536.19 |
| H&M | 65.26 | 741.55 | 443.94 |
| North Face | 69.14 | 730.08 | 368.17 |
| Gucci | 134.66 | 765.47 | 458.99 |
| Adidas | 214.48 | 779.5 | 565.4 |
| Levi's | 146.36 | 690.75 | 459.95 |

### 20. Tren warna per musim

```sql
select
Color,
Season,
round(avg(Popularity_Score),2) as avg_popularity
from Winter_Fashion_Trends_Dataset
group by Color, Season
order by Color, avg_popularity desc;
```

| Color | Season | avg_popularity |
|---|---|---|
| Beige | Winter 2024 | 6.85 |
| Beige | Winter 2023 | 5.3 |
| Beige | Winter 2025 | 4.75 |
| Black | Winter 2025 | 6.03 |
| Black | Winter 2024 | 5.71 |
| Black | Winter 2023 | 3.5 |
| Blue | Winter 2023 | 7.3 |
| Blue | Winter 2024 | 4.85 |
| Blue | Winter 2025 | 4.3 |
| Brown | Winter 2024 | 6 |
| Brown | Winter 2023 | 5.67 |
| Brown | Winter 2025 | 5.38 |
| Cream | Winter 2023 | 9.13 |
| Cream | Winter 2025 | 5.5 |
| Cream | Winter 2024 | 4.86 |
| Gray | Winter 2025 | 8.37 |
| Gray | Winter 2024 | 6.17 |
| Gray | Winter 2023 | 4.45 |
| Green | Winter 2023 | 6.75 |
| Green | Winter 2025 | 5.43 |
| Green | Winter 2024 | 5.1 |
| Maroon | Winter 2025 | 5.91 |
| Maroon | Winter 2023 | 3.3 |
| Maroon | Winter 2024 | 3.15 |
| Red | Winter 2025 | 7.47 |
| Red | Winter 2023 | 6.63 |
| Red | Winter 2024 | 5.17 |
| White | Winter 2024 | 8.27 |
| White | Winter 2023 | 6.57 |
| White | Winter 2025 | 5.14 |

### 21. Deteksi anomali popularitas (outlier)

```sql
select *
from Winter_Fashion_Trends_Dataset
where Popularity_Score > (
    select avg(Popularity_Score) + 2 * sqrt(
        avg(Popularity_Score*Popularity_Score) - avg(Popularity_Score)*avg(Popularity_Score)
    )
    from Winter_Fashion_Trends_Dataset
);
```

| ID | Brand | Category | Color | Material | Style | Gender | Season | Price(USD) | Popularity_Score | Customer_Rating | Trend_Status |
|---|---|---|---|---|---|---|---|---|---|---|---|

### 22. Distribusi harga vs rating & popularitas

```sql
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
```

| price_segment | avg_rating | avg_popularity | total_items |
|---|---|---|---|
| High Range | 3.8 | 5.83 | 130 |
| Low Range | 2.7 | 4.9 | 1 |
| Mid Range | 3.91 | 5.34 | 19 |

### 23. Top 5 brand per kategori (ranking)

```sql
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
```

| Category | Brand | avg_popularity | rank_in_cat |
|---|---|---|---|
| Beanie | Zara | 8.43 | 1 |
| Beanie | Nike | 6.7 | 2 |
| Beanie | H&M | 5.67 | 3 |
| Beanie | Gucci | 5.65 | 4 |
| Beanie | Prada | 3.5 | 5 |
| Boots | Levi's | 9.5 | 1 |
| Boots | North Face | 7.7 | 2 |
| Boots | Mango | 6.92 | 3 |
| Boots | Nike | 6.63 | 4 |
| Boots | Prada | 5.2 | 5 |
| Cardigan | Levi's | 9.6 | 1 |
| Cardigan | Nike | 7.7 | 2 |
| Cardigan | Mango | 7.05 | 3 |
| Cardigan | Adidas | 3.95 | 4 |
| Cardigan | North Face | 3.2 | 5 |
| Coat | North Face | 7.88 | 1 |
| Coat | Prada | 6.25 | 2 |
| Coat | Mango | 6.15 | 3 |
| Coat | Uniqlo | 5.75 | 4 |
| Coat | Levi's | 5.4 | 5 |
| Gloves | Adidas | 7.7 | 1 |
| Gloves | Gucci | 7.43 | 2 |
| Gloves | Mango | 7.35 | 3 |
| Gloves | Nike | 6.9 | 4 |
| Gloves | North Face | 6 | 5 |
| Hoodie | Uniqlo | 8.3 | 1 |
| Hoodie | Levi's | 5.5 | 2 |
| Hoodie | North Face | 5.47 | 3 |
| Hoodie | H&M | 5.15 | 4 |
| Hoodie | Mango | 4.95 | 5 |
| Jacket | Adidas | 9.2 | 1 |
| Jacket | Zara | 7.1 | 2 |
| Jacket | North Face | 6.9 | 3 |
| Jacket | Uniqlo | 5.8 | 4 |
| Jacket | H&M | 4.6 | 5 |
| Scarf | Zara | 10 | 1 |
| Scarf | North Face | 9 | 2 |
| Scarf | Nike | 6.67 | 3 |
| Scarf | Mango | 6.35 | 4 |
| Scarf | Gucci | 5.58 | 5 |
| Sweater | Mango | 8.32 | 1 |
| Sweater | Prada | 7.8 | 2 |
| Sweater | Nike | 7.15 | 3 |
| Sweater | H&M | 6.85 | 4 |
| Sweater | Gucci | 6 | 5 |
| Thermal | Zara | 7.7 | 1 |
| Thermal | Adidas | 7.5 | 2 |
| Thermal | Prada | 6.55 | 3 |
| Thermal | H&M | 6.4 | 4 |
| Thermal | Levi's | 5.9 | 5 |
