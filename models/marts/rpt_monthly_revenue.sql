select
    date_trunc(date(created_at), month) as order_month,
    count(*) as orders,
    round(sum(order_revenue), 2) as revenue,
    round(sum(order_revenue) / count(*), 2) as aov
from {{ ref('fct_orders') }}
where is_valid_order
  and date_trunc(date(created_at), month) < (
      select date_trunc(max(date(created_at)), month) from {{ ref('fct_orders') }}
  )
group by order_month