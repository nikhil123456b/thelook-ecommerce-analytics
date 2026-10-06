select
    traffic_source,
    count(*) as customers,
    countif(valid_order_count >= 1) as buyers,
    countif(is_repeat_customer) as repeat_customers,
    round(countif(valid_order_count >= 1) / count(*), 4) as buyer_rate,
    round(countif(is_repeat_customer) / countif(valid_order_count >= 1), 4) as repeat_rate,
    round(sum(lifetime_revenue) / countif(valid_order_count >= 1), 2) as revenue_per_buyer
from {{ ref('dim_customers') }}
group by traffic_source