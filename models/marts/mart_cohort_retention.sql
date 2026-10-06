with orders as (
    select user_id, created_at
    from {{ ref('fct_orders') }}
    where is_valid_order
),

customers as (
    select user_id, first_order_at
    from {{ ref('dim_customers') }}
    where first_order_at is not null
),

activity as (
    select
        c.user_id,
        date_trunc(date(c.first_order_at), month) as cohort_month,
        date_diff(date(o.created_at), date(c.first_order_at), month) as months_since_first
    from customers c
    join orders o using (user_id)
),

cohort_counts as (
    select
        cohort_month,
        months_since_first,
        count(distinct user_id) as active_customers
    from activity
    group by cohort_month, months_since_first
)

select
    cohort_month,
    months_since_first,
    active_customers,
    first_value(active_customers) over (
        partition by cohort_month order by months_since_first
    ) as cohort_size,
    round(
        active_customers / first_value(active_customers) over (
            partition by cohort_month order by months_since_first
        ), 4
    ) as retention_rate
from cohort_counts