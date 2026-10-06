select
    (select count(*) from {{ ref('fct_orders') }} where is_valid_order) as valid_orders,
    (select round(sum(order_revenue), 2) from {{ ref('fct_orders') }} where is_valid_order) as revenue,
    (select round(sum(order_revenue) / count(*), 2) from {{ ref('fct_orders') }} where is_valid_order) as aov,
    (select round(countif(not is_valid_order) / count(*), 4) from {{ ref('fct_orders') }}) as cancel_return_rate,
    (select round(countif(is_repeat_customer) / countif(valid_order_count >= 1), 4) from {{ ref('dim_customers') }}) as repeat_rate,
    (select round(countif(purchased) / countif(added_to_cart), 4) from {{ ref('fct_sessions') }}) as cart_to_purchase_rate