select
    p.category,
    count(*) as items_sold,
    round(sum(i.sale_price), 2) as revenue,
    round(sum(i.sale_price - p.cost), 2) as gross_profit,
    round(sum(i.sale_price - p.cost) / sum(i.sale_price), 4) as gross_margin
from {{ ref('stg_order_items') }} i
join {{ ref('stg_products') }} p using (product_id)
where i.status not in ('Cancelled', 'Returned')
group by p.category