with users as (
    select * from {{ ref('stg_users') }}
),

customer_orders as (
    select
        user_id,
        min(created_at) as first_order_at,
        count(*) as valid_order_count,
        sum(order_revenue) as lifetime_revenue
    from {{ ref('fct_orders') }}
    where is_valid_order
    group by user_id
)

select
    u.user_id,
    u.traffic_source,
    u.country,
    u.age,
    u.gender,
    u.signed_up_at,
    c.first_order_at,
    coalesce(c.valid_order_count, 0) as valid_order_count,
    coalesce(c.lifetime_revenue, 0) as lifetime_revenue,
    coalesce(c.valid_order_count, 0) >= 2 as is_repeat_customer
from users u
left join customer_orders c using (user_id)