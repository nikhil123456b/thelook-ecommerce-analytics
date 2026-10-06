with orders as (
    select * from {{ ref('stg_orders') }}
),

items as (
    select
        order_id,
        sum(sale_price) as order_revenue
    from {{ ref('stg_order_items') }}
    group by order_id
)

select
    orders.order_id,
    orders.user_id,
    orders.status,
    orders.created_at,
    orders.item_count,
    items.order_revenue,
    orders.status not in ('Cancelled', 'Returned') as is_valid_order
from orders
left join items using (order_id)